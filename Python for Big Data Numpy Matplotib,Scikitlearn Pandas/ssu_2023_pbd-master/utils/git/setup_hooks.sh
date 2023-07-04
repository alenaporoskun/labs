#!/usr/bin/env bash

set -u
set -e
#set -x

ROOT_DIR="../.."
HOOK_DIR="${ROOT_DIR}/.git/hooks"
HOOK_FILE="pre-push"
SRC="./hooks/${HOOK_FILE}"
DST="${HOOK_DIR}/${HOOK_FILE}"

if [ -d "${HOOK_DIR}" ]; then
    cp "$SRC" "$DST"
    chmod +x "$DST"
fi
