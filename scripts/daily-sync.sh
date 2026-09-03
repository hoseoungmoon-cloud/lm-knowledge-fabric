#!/bin/bash
# LM Knowledge Fabric — Daily Sync Script for WSL2
# 
# Usage:
#   ./scripts/daily-sync.sh
#
# This script:
# 1. Pulls latest changes from GitHub
# 2. Validates JSON-LD files
# 3. Syncs with Google Drive (if rclone configured)
# 4. Updates timestamps in Live Document
# 5. Commits and pushes changes

set -e  # Exit on error

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LIVE_DOC="${REPO_ROOT}/01_Live_Workspace/LIVE_DOCUMENT.md"
JSONLD_FILE="${REPO_ROOT}/00_System_Config/LM_NOTEBOOKS.jsonld"
GDRIVE_PATH="/mnt/c/Users/${USER}/Google Drive/LM_Knowledge"

echo -e "${GREEN}═══ LM KNOWLEDGE FABRIC — DAILY SYNC ═══${NC}"
echo "Date: $(date '+%Y-%m-%d %H:%M')"
echo "Repo: ${REPO_ROOT}"
echo ""

# Step 1: Navigate to repo
cd "${REPO_ROOT}"
echo -e "${YELLOW}[1/6]${NC} Navigated to ${REPO_ROOT}"

# Step 2: Pull latest from GitHub
echo -e "${YELLOW}[2/6]${NC} Pulling latest changes..."
if git pull origin main; then
    echo -e "${GREEN}✓${NC} Git pull successful"
else
    echo -e "${RED}✗${NC} Git pull failed (expected if first run)"
fi

# Step 3: Validate JSON-LD
echo -e "${YELLOW}[3/6]${NC} Validating JSON-LD..."
if python3 scripts/validate_jsonld.py "${JSONLD_FILE}"; then
    echo -e "${GREEN}✓${NC} JSON-LD validation passed"
else
    echo -e "${RED}✗${NC} JSON-LD validation failed"
    exit 1
fi

# Step 4: Sync with Google Drive (optional)
if command -v rclone &> /dev/null && [ -d "${GDRIVE_PATH}" ]; then
    echo -e "${YELLOW}[4/6]${NC} Syncing with Google Drive..."
    rclone sync "${GDRIVE_PATH}/" "${REPO_ROOT}/01_Live_Workspace/" --progress || true
    echo -e "${GREEN}✓${NC} Drive sync completed"
else
    echo -e "${YELLOW}[4/6]${NC} Skipping Drive sync (rclone not configured)"
fi

# Step 5: Update Live Document timestamp
echo -e "${YELLOW}[5/6]${NC} Updating Live Document..."
if [ -f "${LIVE_DOC}" ]; then
    # Update date in header if exists
    sed -i "s/- Datum: .*/- Datum: $(date '+%Y-%m-%d')/" "${LIVE_DOC}" 2>/dev/null || true
    echo -e "${GREEN}✓${NC} Live Document updated"
else
    echo -e "${YELLOW}⚠${NC} Live Document not found (create manually)"
fi

# Step 6: Commit and push
echo -e "${YELLOW}[6/6]${NC} Committing changes..."
git add .
if git diff --cached --quiet; then
    echo -e "${YELLOW}⚠${NC} No changes to commit"
else
    git commit -m "Daily sync: $(date '+%Y-%m-%d')"
    git push origin main
    echo -e "${GREEN}✓${NC} Changes pushed to GitHub"
fi

echo ""
echo -e "${GREEN}═══ SYNC COMPLETE ═══${NC}"
echo "Next steps:"
echo "  1. Review Live Document in Google Drive"
echo "  2. Update NotebookLM with new insights"
echo "  3. Run Button 7 (Dublettencheck) if adding sources"
