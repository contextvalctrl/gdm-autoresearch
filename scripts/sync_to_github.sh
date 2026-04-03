#!/usr/bin/env bash
# sync_to_github.sh
# Syncs GDM topic knowledge docs from Richard's memory to GitHub.
# Docs are CRUDed in place — this is a living knowledge base, not a run log.
set -euo pipefail

REPO_DIR="/home/ubuntu/dev/contextvalctrl/gdm-autoresearch"
MEMORY_DIR="/home/ubuntu/agents/richard/.openclaw/workspace/memory"

cd "$REPO_DIR"
git pull --rebase origin main

CHANGED=0

# Map: memory file -> topics/ destination
declare -A TOPIC_MAP=(
  ["gdm_r69.md"]="topics/query-as-first-class-object.md"
  ["gdm_knowledge_marketplace.md"]="topics/knowledge-marketplace-primitive.md"
  ["gdm_r70_reasoning.md"]="topics/extended-reasoning-notes.md"
)

for src_name in "${!TOPIC_MAP[@]}"; do
  src="$MEMORY_DIR/$src_name"
  dest="$REPO_DIR/${TOPIC_MAP[$src_name]}"
  if [ -f "$src" ]; then
    if [ ! -f "$dest" ] || ! diff -q "$src" "$dest" > /dev/null 2>&1; then
      cp "$src" "$dest"
      echo "Updated: ${TOPIC_MAP[$src_name]}"
      CHANGED=1
    fi
  fi
done

git add topics/
if [ "$CHANGED" -eq 0 ] || git diff --cached --quiet; then
  echo "Nothing new to commit."
  exit 0
fi

git commit -m "research: sync GDM knowledge base [$(date -u '+%Y-%m-%d %H:%M UTC')]"
git push origin main
