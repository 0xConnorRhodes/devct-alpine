#!/bin/sh

# second apply to decrypt files if key is present
chezmoi apply
chezmoi apply

# symlink external notes mount if it exitst
if [ ! -e "$HOME/notes" ]; then
 #if [ -d "/nmount/zk_notes" ]; then
  if [ -d "/nmount/box/notes" ]; then
    ln -s /nmount/box/notes "$HOME/notes"
  fi
fi

# infinite task to hold container open so shell sessions can be attached
sh -c "tail -f /dev/null"
