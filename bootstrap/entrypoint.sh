#!/bin/sh

# second apply to decrypt files if key is present
chezmoi apply
chezmoi apply

# symlink notes mount to home directory if it exists
if [ ! -e "$HOME/notes" ]; then
  if [ -d "/nmount/zk_notes" ]; then
    ln -s /nmount/zk_notes "$HOME/notes"
  fi
fi

# infinite task to hold container open so shell sessions can be attached
sh -c "tail -f /dev/null"
