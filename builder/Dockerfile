FROM alpine:edge
RUN apk --no-cache add bash
RUN apk --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ tini

# install runtime dependencies into rootfs
ENV rootfs=/var/tmp/docker-phan-rootfs-XXXXXXXXXX
ENV mirror=http://nl.alpinelinux.org/alpine
# configure rootfs
RUN mkdir -p $rootfs/etc/apk && { echo "$mirror/edge/main"; echo "$mirror/edge/community"; } | tee "/etc/apk/repositories" "$rootfs/etc/apk/repositories" >&2

# install PHP8 dependencies and build dependencies
RUN apk --no-cache add php8 php8-sqlite3 php8-mbstring curl php8-openssl php8-phar php8-dom php8-pcntl php8-tokenizer php8-iconv
RUN cd /tmp && \
    curl -O https://getcomposer.org/download/2.0.4/composer.phar && \
    printf "c3b2bc477429c923c69f7f9b137e06b2a93c6a1e192d40ffad1741ee5d54760d  composer.phar" | sha256sum -c && \
    mv composer.phar /usr/local/bin

# Use the ast versions provided by alpine
RUN apk --no-cache --root "/var/tmp/docker-phan-rootfs-XXXXXXXXXX" --keys-dir /etc/apk/keys add --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --initdb php8 php8-json php8-sqlite3 php8-mbstring php8-pcntl php8-dom php8-tokenizer php8-iconv php8-pecl-ast tini

# TODO: Merge into above for downloading phan releases (could use github api instead)
RUN apk --no-cache add git


COPY scripts/mkimage-phan.bash /
COPY scripts/docker-entrypoint.sh /var/tmp/docker-phan-rootfs-XXXXXXXXXX/

ENTRYPOINT ["/sbin/tini", "-g", "--", "/mkimage-phan.bash"]
