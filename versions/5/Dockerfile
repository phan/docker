FROM alpine:3.16
ADD rootfs.tar.gz /
ENTRYPOINT ["/sbin/tini", "-g", "--", "/docker-entrypoint.sh"]
