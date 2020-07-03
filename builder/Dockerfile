FROM alpine:3.12
RUN apk --no-cache add bash
RUN apk --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ tini

# install runtime dependencies into rootfs
ENV rootfs=/var/tmp/docker-phan-rootfs-XXXXXXXXXX
ENV mirror=http://nl.alpinelinux.org/alpine
# configure rootfs
RUN mkdir -p $rootfs/etc/apk && { echo "$mirror/edge/main"; echo "$mirror/edge/community"; } | tee "/etc/apk/repositories" "$rootfs/etc/apk/repositories" >&2

# install PHP7 dependencies and build dependencies
RUN apk --no-cache add php7 php7-json php7-sqlite3 php7-mbstring git build-base autoconf curl php7-dev php7-openssl php7-phar php7-dom php7-pcntl php7-tokenizer php7-iconv
RUN cd /tmp && \
    curl -O https://getcomposer.org/download/1.10.8/composer.phar && \
    printf "4c40737f5d5f36d04f8b2df37171c6a1ff520efcadcb8626cc7c30bd4c5178e5  composer.phar" | sha256sum -c && \
    mv composer.phar /usr/local/bin

RUN apk --no-cache --root "/var/tmp/docker-phan-rootfs-XXXXXXXXXX" --keys-dir /etc/apk/keys add --initdb php7 php7-json php7-sqlite3 php7-mbstring php7-pcntl php7-dom php7-tokenizer php7-iconv tini

COPY scripts/mkimage-phan.bash /
COPY scripts/docker-entrypoint.sh /var/tmp/docker-phan-rootfs-XXXXXXXXXX/

ENTRYPOINT ["/sbin/tini", "-g", "--", "/mkimage-phan.bash"]
