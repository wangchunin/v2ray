#!/bin/sh

# config caddy
cat << EOF > /etc/caddy/Caddyfile
:$PORT
reverse_proxy  /  https://public.sn.files.1drv.com {
    header_up Host public.sn.files.1drv.com
    header_up Referer public.sn.files.1drv.com
    header_up -X-Forwarded-For {remote}
    header_up X-Real-IP {remote}
    header_up User-Agent {>User-Agent}
    header_up Accept-Encoding identity
}
EOF




caddy run --config /etc/caddy/Caddyfile --adapter caddyfile


