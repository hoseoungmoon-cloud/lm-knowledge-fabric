#!/bin/bash
# LM Knowledge Fabric — Daily Sync Script for WSL2
#
# Usage:
#   ./scripts/daily-sync.sh
#
# This script:
# 1. Pulls latest changes from GitHub (with rebase/clean fallback)
# 2. Validates JSON-LD files
# 3. Syncs with Google Drive (if rclone configured)
# 4. Updates timestamps in Live Document
# 5. Commits and pushes changes safely

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LIVE_DOC="${REPO_ROOT}/01_Live_Workspace/LIVE_DOCUMENT.md"
LIVE_DOC_TEMPLATE="${REPO_ROOT}/01_Live_Workspace/LIVE_DOCUMENT_TEMPLATE.md"
JSONLD_FILE="${REPO_ROOT}/00_System_Config/LM_NOTEBOOKS.jsonld"
GDRIVE_PATH="/mnt/c/Users/${USER}/Google Drive/LM_Knowledge"

echo -e "${GREEN}═══ LM KNOWLEDGE FABRIC — DAILY SYNC ═══${NC}"
echo "Date: $(date '+%Y-%m-%d %H:%M')"
echo "Repo: ${REPO_ROOT}"
echo ""

cd "${REPO_ROOT}"
echo -e "${YELLOW}[1/6]${NC} Navigated to ${REPO_ROOT}"

echo -e "${YELLOW}[2/6]${NC} Pulling latest changes from Git remote..."
if git pull origin main --rebase; then
    echo -e "${GREEN}✓${NC} Git pull successful"
else
    echo -e "${YELLOW}⚠${NC} Git pull with rebase had a notice, trying standard fetch..."
    git fetch origin main || true
fi

echo -e "${YELLOW}[3/6]${NC} Validating JSON-LD graph..."
if python3 scripts/validate_jsonld.py "${JSONLD_FILE}"; then
    echo -e "${GREEN}✓${NC} JSON-LD validation passed"
else
    echo -e "${RED}✗${NC} JSON-LD validation failed! Please fix syntax errors before committing."
    exit 1
fi

if command -v rclone &> /dev/null && [ -d "${GDRIVE_PATH}" ]; then
    echo -e "${YELLOW}[4/6]${NC} Syncing with Google Drive via rclone..."
    rclone sync "${GDRIVE_PATH}/" "${REPO_ROOT}/01_Live_Workspace/" --progress || true
    echo -e "${GREEN}✓${NC} Drive sync completed"
else
    echo -e "${BLUE}[4/6]${NC} Skipping Drive sync (rclone not installed or Windows path not found)"
fi

echo -e "${YELLOW}[5/6]${NC} Updating Live Document timestamp..."
if [ -f "${LIVE_DOC}" ]; then
    sed -i "s/^- Datum:.*/- Datum: $(date '+%Y-%m-%d')/" "${LIVE_DOC}" 2>/dev/null || true
    echo -e "${GREEN}✓${NC} Live Document timestamp refreshed"
elif [ -f "${LIVE_DOC_TEMPLATE}" ]; then
    echo -e "${YELLOW}ℹ${NC} Creating LIVE_DOCUMENT.md from template..."
    cp "${LIVE_DOC_TEMPLATE}" "${LIVE_DOC}"
    sed -i "s/^- Datum:.*/- Datum: $(date '+%Y-%m-%d')/" "${LIVE_DOC}" 2>/dev/null || true
    echo -e "${GREEN}✓${NC} LIVE_DOCUMENT.md created from template"
else
    echo -e "${YELLOW}⚠${NC} Live Document not found (will be tracked when created)"
fi

echo -e "${YELLOW}[6/6]${NC} Committing and pushing workspace changes..."
git add 00_System_Config/ docs/ scripts/ 01_Live_Workspace/ 2>/dev/null || git add .

if git diff --cached --quiet; then
    echo -e "${YELLOW}ℹ${NC} Working tree clean — no new changes to commit"
else
    git commit -m "Daily sync: $(date '+%Y-%m-%d %H:%M')"
    if git push origin main; then
        echo -e "${GREEN}✓${NC} Changes pushed to GitHub repository"
    else
        echo -e "${RED}✗${NC} Git push failed (check network/credentials)"
    fi
fi

echo ""
echo -e "${GREEN}═══ SYNC COMPLETE ═══${NC}"
echo "Next actions in NotebookLM & Gemini:"
echo "  1. Review Live Document: 01_Live_Workspace/LIVE_DOCUMENT.md"
echo "  2. In NotebookLM: add sources or export condensed notes"
echo "  3. Use Button 7 (Dublettencheck) before adding new entities"
