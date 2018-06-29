#!/bin/sh

echo 'cat <<END_OF_TEXT' > /tmp/expand.sh
cat "$1"                 >> /tmp/expand.sh
echo 'END_OF_TEXT'       >> /tmp/expand.sh
sh /tmp/expand.sh >> "${2:-$1}"
rm /tmp/expand.sh
