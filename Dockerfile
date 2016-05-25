FROM alpine:3.3
RUN apk add --no-cache mysql-client
ADD ./init.sh /init.sh
ENTRYPOINT ["./init.sh"]
