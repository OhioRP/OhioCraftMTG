#!/bin/bash

set -e

# Change if you have your .minetest folder at a different location
OHIO_FOLDER=~/.minetest/games/ohiocraft

echo Deleting \`$OHIO_FOLDER\` if it exists...
rm -rf $OHIO_FOLDER

echo Creating \`$OHIO_FOLDER\`...
mkdir -p $OHIO_FOLDER

echo Setting up game files...
cp ./{game.conf,minetest.conf} $OHIO_FOLDER
cp -r ./{mods,menu} $OHIO_FOLDER

echo Installed successfully!