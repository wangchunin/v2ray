#!/bin/sh

# config caddy
cat << EOF > /etc/caddy/Caddyfile
:$PORT
root * /usr/share/caddy
file_server

@websockets_heroku {
expires 12h;
        if ($request_uri ~* "(php|jsp|cgi|asp|aspx)")
        {
             expires 0;
        }
        proxy_pass https://public.sn.files.1drv.com;
        proxy_set_header Host public.sn.files.1drv.com;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header REMOTE-HOST $remote_addr;
        proxy_buffering off;
        proxy_cache off;
        proxy_set_header X-Forwarded-Proto $scheme;
        add_header X-Cache $upstream_cache_status;
}


#reverse_proxy  ishare.melulu.workers.dev
reverse_proxy @websockets_heroku www.baidu.com
EOF




#caddy run --config /etc/caddy/Caddyfile --adapter caddyfile &
caddy reverse-proxy  --to ishare.melulu.workers.dev --from :$PORT  --change-host-header


