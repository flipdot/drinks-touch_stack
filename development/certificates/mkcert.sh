#!/bin/sh
THIS=$(dirname $(readlink -f "$0"))
NAME=drinks-touch

mkcert \
-cert-file "$THIS/$NAME.crt" \
-ecdsa \
-key-file "$THIS/$NAME.key" \
    $NAME.test \
    "*.$NAME.test"