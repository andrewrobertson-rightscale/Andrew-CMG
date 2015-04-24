#!/bin/bash
src_docroot=/home/glocktal/public_html
dst_docroot=/home/vhosts/glocktalk.com
mkdir -p $dst_docroot
rsync \
    --rsh='ssh' \
    -av \
    --progress \
    --include="\.*" \
    --partial \
    root@glocktalk.com:$src_docroot $dst_docroot
chown -R rightscale:apache /home/vhosts/glocktalk.com
