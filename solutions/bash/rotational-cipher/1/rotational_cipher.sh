#!/usr/bin/env bash
set -euo pipefail

text=$1
key=${2}

rot=$((10#$key % 26))

alpha=abcdefghijklmnopqrstuvwxyz
ALPHA=${alpha^^}

src="$alpha$ALPHA"
dst="${alpha:rot}${alpha:0:rot}${ALPHA:rot}${ALPHA:0:rot}"

export LC_ALL=C
printf '%s' "$text" | tr "$src" "$dst"
