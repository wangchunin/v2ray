#!/bin/sh

# config caddy
cat << EOF > /etc/caddy/Caddyfile
:$PORT
root * /usr/share/caddy
file_server

reverse_proxy / public.sn.files.1drv.com {
    # 请求头Host设置
    header_up Host public.sn.files.1drv.com
    # 请求头transparent设置
    header_up X-Real-IP {http.request.remote.host}
    header_up X-Forwarded-For {http.request.remote.host}
    header_up REMOTE-HOST {http.request.remote.host}
    header_up X-Forwarded-Proto {http.request.scheme}
}
EOF




caddy run --config /etc/caddy/Caddyfile --adapter caddyfile


