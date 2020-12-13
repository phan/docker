#!/bin/sh
cd /mnt/src
exec php8 /opt/phan/phan "$@"
