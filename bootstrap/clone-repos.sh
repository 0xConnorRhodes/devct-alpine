#!/bin/sh

git clone git@github.com:0xConnorRhodes/priv-scripts.git $HOME/code/priv-scripts
git clone git@github.com:0xConnorRhodes/notes-snapshot.git $HOME/notes

git clone git@github.com:0xConnorRhodes/notes-scripts.git $HOME/code/notes-scripts
cd $HOME/code/notes-scripts
just pull-sub
