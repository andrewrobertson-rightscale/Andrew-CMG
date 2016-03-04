#!/bin/bash
DIR_TEST="/home/vhosts/core.carbonmedia.net"
if [ -d "$DIR_TEST" ]; then
        TARGET_DIR="/home/vhosts/core.carbonmedia.net"
else
        TARGET_DIR="/CMGSites/CMGVolume/vhosts/core.carbonmedia.net"
fi

USER_TEST="rightscale"
if [ "$(id -u $USER_TEST >/dev/null 2>&1)" ]; then
        TARGET_USER="rightscale"
else
        TARGET_USER="ec2-user"
fi

TARGET_GROUP="apache"

TARGET_PATHS=(
        'wp-content/plugins'
        'wp-content/themes'
        'wp-content/upgrade'
        'wp-content/mu-plugins'
        'wp-content/uploads'
        'wp-content/w3tc-config'
        'wp-content/cache'
        'wp-includes'
)

for ((i=0; i<${#TARGET_PATHS[@]}; ++i))
do
        echo :: CHOWN -R $TARGET_USER:$TARGET_GROUP : $TARGET_DIR/${TARGET_PATHS[$i]} ...
        if [ ! -d "$TARGET_DIR/${TARGET_PATHS[$i]}" ]; then
            mkdir $TARGET_DIR/${TARGET_PATHS[$i]}
        fi
        chown -R $TARGET_USER:$TARGET_GROUP $TARGET_DIR/${TARGET_PATHS[$i]}
done

for ((i=0; i<${#TARGET_PATHS[@]}; ++i))
do
    echo :: CHMOD -R g+w: $TARGET_DIR/${TARGET_PATHS[$i]} ...
    chmod -R g+w $TARGET_DIR/${TARGET_PATHS[$i]}
done
