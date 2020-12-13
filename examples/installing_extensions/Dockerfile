# You can build your own docker images based on phanphp/phan
# with the extensions you need to run plugins or analyze your codebase.
#
# Currently, Phan images use php 8.0
FROM phanphp/phan:4
# To list available extensions, run apk update && apk search -v 'php8*' | sort

# For example, to install simplexml and redis:
RUN apk --no-cache add \
    php8-simplexml \
    php8-pecl-redis

# See builder/scripts/mkimage-phan.bash for an example of how to install extensions that are not available through alpine's repos.
# Installing gcc, git, etc. would make the resulting image much larger,
# so it may be useful to only copy the resulting shared library and add an extension=myextension.so line to /etc/php8/conf.d/myextension.ini
