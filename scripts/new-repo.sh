#!/bin/bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "usage: new <repo-name>"
    exit 1
fi

REPO_NAME="$1"
REPO_DIR="$HOME/workspace/$REPO_NAME"
SCRIPTS_DIR="$(dirname "$(realpath "$0")")"
PRE_COMMIT_CONFIG="$(dirname "$SCRIPTS_DIR")/.pre-commit-config.yaml"

if [[ -e "$REPO_DIR" ]]; then
    echo "already exists: ~/workspace/$REPO_NAME"
    exit 1
fi

if [[ ! -f "$PRE_COMMIT_CONFIG" ]]; then
    echo "no such file: $PRE_COMMIT_CONFIG"
    exit 1
fi

mkdir -p "$REPO_DIR"
git -C "$REPO_DIR" init
cp "$PRE_COMMIT_CONFIG" "$REPO_DIR/.pre-commit-config.yaml"
(cd "$REPO_DIR" && pre-commit install)

if [[ -z "${TMUX:-}" ]]; then
    exec "$SCRIPTS_DIR/start-tmux.sh" "$REPO_NAME"
fi
