FROM alpine:edge
ADD rootfs.tar.gz /
ENTRYPOINT ["/sbin/tini", "-g", "--", "/docker-entrypoint.sh"]
