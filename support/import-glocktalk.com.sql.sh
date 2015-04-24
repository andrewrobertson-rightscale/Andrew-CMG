#!/bin/bash
dbfile1=glocktalk.com_glocktal_vB387.sql
dbfile2=glocktalk.com_glocktal_photopost.sql
dbfile3=glocktalk.com_glocktal_wikidb.sql
dbname1=glocktal_vB387
dbname2=glocktal_photopost
dbname3=glocktal_wikidb

cd /home/vhosts/db-migrations
ssh \
    root@glocktalk.com \
    " \
        mkdir -p /backup/db-migrations ; \
        cd /backup/db-migrations ; \
        rm /backup/db-migrations/$dbfile1.gz ; \
        rm /backup/db-migrations/$dbfile2.gz ; \
        rm /backup/db-migrations/$dbfile3.gz ; \
        mysqldump --force --quick --single-transaction $dbname1 > $dbfile1 ; \
        mysqldump --force --quick --single-transaction $dbname2 > $dbfile2 ; \
        mysqldump --force --quick --single-transaction $dbname3 > $dbfile3 ; \
        gzip $dbfile1 \
        gzip $dbfile2 \
        gzip $dbfile3 \
    "
scp root@glocktalk.com:/backup/db-migrations/$dbfile1.gz .
scp root@glocktalk.com:/backup/db-migrations/$dbfile2.gz .
scp root@glocktalk.com:/backup/db-migrations/$dbfile3.gz .
gunzip $dbfile1.gz
gunzip $dbfile2.gz
gunzip $dbfile3.gz
mysql $dbname1 < $dbfile1
mysql $dbname2 < $dbfile2
mysql $dbname3 < $dbfile3
rm $dbfile1
rm $dbfile2
rm $dbfile3