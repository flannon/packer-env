#!/bin/bash -eux

echo "Set locale to en_US.utf8"

localedef --list-archive | grep -a -v en_US.utf8 | xargs sudo localedef --delete-from-archive
cp /usr/lib/locale/locale-archive{,.tmpl}
build-locale-archive
