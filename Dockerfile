FROM alpine:3.6

COPY ./docker-entrypoint.sh /
ADD ./rootfs.tar.gz /
ENTRYPOINT ["/sbin/tini", "-g", "--", "/docker-entrypoint.sh"]
