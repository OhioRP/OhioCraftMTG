#!/bin/bash

set -e

# Change if you have your .minetest folder at a different location
OHIO_FOLDER=~/.minetest/mods/ohiocraft

echo Deleting \`$OHIO_FOLDER\` if it exists...
rm -rf $OHIO_FOLDER

mkdir -p $OHIO_FOLDER
cp ./{modpack.txt,modpack.conf} $OHIO_FOLDER
for x in ./*; do
    if [ -d $x ]; then
        echo Found folder \`$x\`
        if [ -f $x/mod.conf ]; then
            echo Folder is mod, installing it...
            cp -r $x $OHIO_FOLDER/`basename $x`
        else
            echo Folder is not mod, ignoring it...
        fi
    fi
done