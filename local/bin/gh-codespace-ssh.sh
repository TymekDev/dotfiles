#!/bin/sh

set -e

CODESPACES=$(gh codespace list --json name,repository)
REPOS=$(echo $CODESPACES | jq -r '.[] .repository')
REPO=$(gum choose $REPOS)
CS_NAME=$(echo $CODESPACES | jq -r ".[] | select(.repository == \"$REPO\") | .name")

status() {
  gh codespace view --codespace "$CS_NAME" --json state --jq '.state'
}

until [ $(status) = "Available" ]; do
  printf '\r[%s] %s is not Available, retrying in 15s...' $(date +%H:%M:%S) $REPO
  sleep 5
done

gh codespace ssh --codespace "$CS_NAME" -- -o IdentitiesOnly=yes
