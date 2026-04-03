#!/usr/bin/env bash
# sync_to_github.sh — copy new GDM research runs from Richard's memory dir and push to GitHub
set -euo pipefail

REPO_DIR="/home/ubuntu/dev/contextvalctrl/gdm-autoresearch"
MEMORY_DIR="/home/ubuntu/agents/richard/.openclaw/workspace/memory"

cd "$REPO_DIR"
git pull --rebase origin main

# Copy any gdm_* files that are new or updated
for f in "$MEMORY_DIR"/gdm_*.md; do
  fname=$(basename "$f")
  dest="$REPO_DIR/runs/$fname"
  if [ ! -f "$dest" ] || [ "$f" -nt "$dest" ]; then
    cp "$f" "$dest"
    echo "Synced: $fname"
  fi
done

git add runs/
if git diff --cached --quiet; then
  echo "Nothing new to commit."
  exit 0
fi

git commit -m "chore: sync GDM research runs [$(date -u '+%Y-%m-%d %H:%M UTC')]"
git push origin main
