#!/usr/bin/env bash

# This mkimage-phan.bash is a modified version from
# https://github.com/gliderlabs/docker-alpine/blob/master/builder/scripts/mkimage-alpine.bash.

declare REL="${REL:-edge}"
declare MIRROR="${MIRROR:-http://nl.alpinelinux.org/alpine}"
declare AST="${AST:-1.0.7}"

set -eo pipefail; [[ "$TRACE" ]] && set -x

build() {
  declare mirror="$1" rel="$2" ast="$3"

  # install phan
  mkdir -p "$rootfs/opt/"
  {
    cd "$rootfs/opt/"
    if [[ "$rel" == "edge" ]]; then
      git clone --single-branch --depth 1 https://github.com/phan/phan.git
    else
      git clone -b $rel --single-branch --depth 1 https://github.com/phan/phan.git
    fi
    cd phan

    php8 /usr/local/bin/composer.phar --prefer-dist --no-dev --ignore-platform-reqs --no-interaction install
    rm -rf .git
    rm -rf tests vendor/symfony/console/Tests vendor/symfony/debug/Tests
  } >&2

  # install php-ast
  # TODO: curl a zip from github releases and drop the dependency on git?
  {
    cd /tmp
    git clone -b "v${ast}" --single-branch --depth 1 https://github.com/nikic/php-ast.git
    cd php-ast
    phpize7
    ./configure --with-php-config=php-config7
    make INSTALL_ROOT="$rootfs" install

    printf "extension=ast.so" >> "$rootfs"/etc/php8/php.ini
  } >&2

  tar -z -f rootfs.tar.gz --numeric-owner -C "$rootfs" -c .
  [[ "$STDOUT" ]] && cat rootfs.tar.gz

  return 0
}

main() {
  while getopts "a:r:m:s" opt; do
    case $opt in
      r) REL="$OPTARG";;
      a) AST="$OPTARG";;
      m) MIRROR="$OPTARG";;
      s) STDOUT=1;;
    esac
  done

  build "$MIRROR" "$REL" "$AST"
}

main "$@"
