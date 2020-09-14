#!/bin/sh

# config caddy
cat << EOF > /etc/caddy/Caddyfile
:$PORT
root * /usr/share/caddy
file_server

@websockets_heroku {
header Connection *Upgrade*
header Upgrade    websocket
path $WSPATH
}

# 
@proxy_heroku {
header Connection *Upgrade*
header Upgrade    websocket
path /
}
reverse_proxy @proxy_heroku ishare.melulu.workers.dev
#

reverse_proxy @websockets_heroku 127.0.0.1:10086
EOF

# config v2ray
cat << EOF > /usr/bin/v2ray/config.json
{
    "inbounds": 
    [
        {
            "port": 10086,"listen": "127.0.0.1","protocol": "vless",
            "settings": {"clients": [{"id": "$UUID"}],"decryption": "none"},
            "streamSettings": {"network": "ws","wsSettings": {"path": "$WSPATH"}}
        }
    ],
	
    "outbounds": 
    [
        {"protocol": "freedom","tag": "direct","settings": {}},
        {"protocol": "socks","tag": "sockstor","settings": {"servers": [{"address": "127.0.0.1","port": 9050}]}},
        {"protocol": "blackhole","tag": "blocked","settings": {}}
    ],
	
    "routing": 
    {
        "rules": 
        [
            {"type": "field","outboundTag": "blocked","ip": ["geoip:private","geoip:cn"]},
            {"type": "field","outboundTag": "blocked","domain": ["geosite:private","geosite:cn","geosite:category-ads-all"]},
            {"type": "field","outboundTag": "sockstor","domain": ["geosite:tor"]}
        ]
    }
}	
EOF

# start tor v2ray
nohup tor &
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile &
/usr/bin/v2ray/v2ray -config /usr/bin/v2ray/config.json
