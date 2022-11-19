FROM alpine:3.16
RUN apk --no-cache add bash
RUN apk --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/v3.16/community/ tini

# install runtime dependencies into rootfs
ENV rootfs=/var/tmp/docker-phan-rootfs-XXXXXXXXXX
ENV mirror=http://nl.alpinelinux.org/alpine
# configure rootfs
RUN mkdir -p $rootfs/etc/apk && { echo "$mirror/v3.16/main"; echo "$mirror/v3.16/community"; } | tee "/etc/apk/repositories" "$rootfs/etc/apk/repositories" >&2

# install PHP8 dependencies and build dependencies
RUN apk --no-cache add php php-sqlite3 php-mbstring curl php-openssl php-phar php-dom php-pcntl php-tokenizer php-iconv
RUN cd /tmp && \
    curl -O https://getcomposer.org/download/2.4.4/composer.phar && \
    printf "c252c2a2219956f88089ffc242b42c8cb9300a368fd3890d63940e4fc9652345  composer.phar" | sha256sum -c && \
    mv composer.phar /usr/local/bin

# Use the ast versions provided by alpine
RUN apk --no-cache --root "/var/tmp/docker-phan-rootfs-XXXXXXXXXX" --keys-dir /etc/apk/keys add --initdb php php-json php-sqlite3 php-mbstring php-pcntl php-dom php-tokenizer php-iconv php8-pecl-ast tini

# TODO: Merge into above for downloading phan releases (could use github api instead)
RUN apk --no-cache add git


COPY scripts/mkimage-phan.bash /
COPY scripts/docker-entrypoint.sh /var/tmp/docker-phan-rootfs-XXXXXXXXXX/

ENTRYPOINT ["/sbin/tini", "-g", "--", "/mkimage-phan.bash"]
