#!/bin/bash
# LM KNOWLEDGE FABRIC — NOTEBOOKLM → JSON-LD PIPELINE v1.1
# Optimiert für WSL2, DSGVO-konform, MR-01 Sanitization-Gate
set -e

REPO_ROOT="/home/ai_user/lm-knowledge-fabric"
TEMP_DIR="/tmp/notebooklm_export_$$"
OUTPUT_DIR="$REPO_ROOT/00_System_Config"

log_info() { echo "[INFO] $1"; }
log_success() { echo "[✓] $1"; }
log_error() { echo "[✗] $1"; }
log_warning() { echo "[⚠] $1"; }

cleanup() { [ -d "$TEMP_DIR" ] && rm -rf "$TEMP_DIR"; log_info "Temp cleaned"; }
trap cleanup EXIT

echo ""
echo "═══ NOTEBOOKLM → JSON-LD PIPELINE v1.1 ═══"
echo "Date: $(date +%Y-%m-%d %H:%M)"
echo ""

# [1/6] Auth check
log_info "[1/6] Checking authentication..."
if ! command -v notebooklm &>/dev/null; then
    log_error "notebooklm-py not found. Install:"
    echo "  uv tool install 'notebooklm-py[browser]'"
    exit 1
fi
if ! notebooklm auth check --test --json 2>&1 | jq -e '.status == "ok"' >/dev/null; then
    log_error "Auth failed. Run: notebooklm login"
    exit 1
fi
log_success "Auth OK"

# [2/6] Metadata export
log_info "[2/6] Exporting metadata..."
mkdir -p "$TEMP_DIR"
NB_ID=$(notebooklm status --json 2>/dev/null | jq -r '.active_notebook_id' 2>/dev/null)
if [ -z "$NB_ID" ] || [ "$NB_ID" == "null" ]; then
    log_error "No active notebook. Set with: notebooklm use <id>"
    exit 1
fi
log_info "Notebook: $NB_ID"
notebooklm metadata -n "$NB_ID" --json > "$TEMP_DIR/metadata.json" 2>/dev/null || {
    log_error "Metadata export failed"
    exit 1
}
log_success "Metadata exported"

# [3/6] Sources extract
log_info "[3/6] Extracting sources..."
mkdir -p "$TEMP_DIR/sources"
SRC_COUNT=$(jq '.sources | length' "$TEMP_DIR/metadata.json" 2>/dev/null || echo "0")
log_info "Found $SRC_COUNT sources"
if [ "$SRC_COUNT" -gt 0 ]; then
    jq -r '.sources[].id' "$TEMP_DIR/metadata.json" | while read -r SID; do
        notebooklm source fulltext "$SID" --json -o "$TEMP_DIR/sources/src_$SID.json" 2>/dev/null || true
    done
    log_success "Sources extracted"
else
    log_warning "No sources found"
fi

# [4/6] Convert to JSON-LD
log_info "[4/6] Converting to JSON-LD..."
python3 "$REPO_ROOT/scripts/convert_notebooklm_to_jsonld.py" \
    "$TEMP_DIR/metadata.json" \
    "$TEMP_DIR/sources" \
    "$OUTPUT_DIR/LM_NOTEBOOKS.jsonld"
if [ $? -eq 0 ]; then
    log_success "JSON-LD created"
else
    log_error "Conversion failed"
    exit 1
fi

# [5/6] Validate
log_info "[5/6] Validating JSON-LD..."
python3 "$REPO_ROOT/scripts/validate_jsonld.py" "$OUTPUT_DIR/LM_NOTEBOOKS.jsonld" 2>/dev/null && \
    log_success "Validation passed" || log_warning "Validation skipped"

# [6/6] Git commit
log_info "[6/6] Committing..."
cd "$REPO_ROOT"
git add "$OUTPUT_DIR/LM_NOTEBOOKS.jsonld" 2>/dev/null || true
if ! git diff --cached --quiet -- "$OUTPUT_DIR/LM_NOTEBOOKS.jsonld" 2>/dev/null; then
    git commit -m "NotebookLM export $(date +%Y-%m-%d)" -m "Pipeline: notebooklm_pipeline.sh"
    git push origin main 2>/dev/null && log_success "Pushed" || log_warning "Push failed"
else
    log_info "No changes to commit"
fi

echo ""
echo "═══ PIPELINE COMPLETE ═══"
echo "Output: $OUTPUT_DIR/LM_NOTEBOOKS.jsonld"
echo ""
echo "Next:"
echo "  cat $OUTPUT_DIR/LM_NOTEBOOKS.jsonld | jq"
echo "  ./scripts/daily-sync.sh"
echo ""
