#!/bin/sh
THIS=$(dirname $(readlink -f "$0"))
NAME=drinks-touch

# until flipdot has a central development certificate
export CAROOT="$THIS/"

mkcert \
-cert-file "$THIS/$NAME.crt" \
-ecdsa \
-key-file "$THIS/$NAME.key" \
    $NAME.test \
    "*.$NAME.test"