#!/bin/sh

# second apply to decrypt files if key is present
chezmoi apply

# infinite task to hold container open so shell sessions can be attached
sh -c "tail -f /dev/null"
