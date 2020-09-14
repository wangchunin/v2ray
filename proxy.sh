#!/bin/sh

# start caddy
nohup tor &

caddy reverse-proxy  -to ishare.melulu.workers.dev --from :$PORT  --change-host-header &


