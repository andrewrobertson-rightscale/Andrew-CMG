<?php

?>
#!/bin/bash
src_docroot=/home/ohiogame/public_html/*
dst_docroot=/home/vhosts/ohiogamefishing.com
mkdir -p $dst_docroot
rsync \
    --rsh='ssh' \
    -av \
    --progress \
    --exclude="*log*" \
    --include="\.*" \
    --partial \
    root@ohiogamefishing.com:'\
        /home/ohiogame/public_html/photopost/data \
        /home/ohiogame/public_html/lakemaps \
        /home/ohiogame/public_html/community/attachments \
        /home/ohiogame/public_html/2010_crappie_results_files \
        /home/ohiogame/public_html/2011 \
        /home/ohiogame/public_html/2012 \
        /home/ohiogame/public_html/2013 \
        /home/ohiogame/public_html/adpics \
        /home/ohiogame/public_html/brandon \
        /home/ohiogame/public_html/crappie2011pics \
        /home/ohiogame/public_html/crappie2012 \
        /home/ohiogame/public_html/crappieforms \
        /home/ohiogame/public_html/crappietiest \
        /home/ohiogame/public_html/docs \
        /home/ohiogame/public_html/crappieforms \
        /home/ohiogame/public_html/hawgfest \
        /home/ohiogame/public_html/hfdocs \
        /home/ohiogame/public_html/images \
        /home/ohiogame/public_html/tempdocs \
        /home/ohiogame/public_html/webpics \
    ' \
    $dst_docroot
