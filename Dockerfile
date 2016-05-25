FROM alpine:edge
RUN apk add --no-cache mysql-client
ADD ./init.sh /init.sh
CMD ["/init.sh"]
