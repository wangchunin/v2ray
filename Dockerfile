FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git bash wget curl


FROM caddy:2.1.1-alpine


RUN apk update && apk add --no-cache tor ca-certificates

ADD proxy.sh /proxy.sh
RUN chmod +x /proxy.sh
CMD /proxy.sh
