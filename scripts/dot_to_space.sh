#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title . to space
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

pbpaste | tr '.' ' ' | pbcopy
