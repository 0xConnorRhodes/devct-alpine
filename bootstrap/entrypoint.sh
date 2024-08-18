#!/bin/sh

# infinite task to hold container open so shell sessions can be attached
sh -c "tail -f /dev/null"
