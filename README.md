# LM KNOWLEDGE FABRIC — IMPLEMENTATION GUIDE

**Version:** v1.1 (WSL2-Optimized)  
**Status:** Production-Ready  
**Last Updated:** 2026-09-03  
**Architecture:** Hybrid Windows/WSL2 with Ollama integration

## Overview

A stable, scalable and cost-efficient knowledge architecture system optimized for WSL2 environments with:
- **NotebookLM-first** — All raw sources and large data volumes first condensed in NotebookLM
- **JSON-LD canonical** — L2 master graph as the only system truth
- **YAML operational** — Control files for buttons, profiles and transfers
- **CIA-LCV compliant** — Context Integrity, Logical Validation, Segmented Transfer
- **WSL2-native** — Optimized for Windows Subsystem for Linux 2 with Ollama

## Quick Start

### 1. Clone Repository (WSL2)

**CRITICAL**: Clone to WSL2 filesystem for best performance!

```bash
# In WSL2 (Ubuntu, etc.)
cd /home/<your-username>
git clone https://github.com/hoseoungmoon-cloud/lm-knowledge-fabric.git
cd lm-knowledge-fabric
```

**DO NOT** clone to `/mnt/c/Users/...` — this is slow!

### 2. Create Folder Structure

```bash
mkdir -p 00_System_Config 01_Live_Workspace 02_L0_Raw_Sources 03_L1_Notebook_Backups 04_L3_Canvas_Outputs
mkdir -p scripts
```

### 3. Setup NotebookLM

1. Open https://notebooklm.google.com
2. Create Notebook: "LM Knowledge Fabric - Primary"
3. Enable Google Drive integration
4. Create three companion notes (see `docs/NOTEBOOKLM_SETUP.md`)

### 4. Initialize System Files

```bash
# Copy from Git repo to working directories
cp 00_System_Config/*.yaml ~/lm-knowledge-fabric-working/
cp 00_System_Config/LM_NOTEBOOKS.jsonld ~/lm-knowledge-fabric-working/
```

### 5. Configure WSL2 ↔ Windows Bridge

```bash
# Access your Windows legal system from WSL2
ls -la /mnt/c/Rechtssystem/RECHTSBIBLIOTHEK/

# Optional: Create symlink for easier access
ln -s /mnt/c/Rechtssystem /home/<user>/lm-knowledge-fabric/data/RECHTSBIBLIOTHEK
```

## Architecture

| Layer | Purpose | Technology | Location |
|-------|---------|------------|----------|
| **L0** | Raw sources (transient) | PDF, DOC, Web | Windows: `C:\Rechtssystem` |
| **L1** | Condensation & Grounding | NotebookLM | Cloud (Google) |
| **L2** | Canonical Graph | JSON-LD | WSL2: `/home/<user>/lm-knowledge-fabric` |
| **L3** | Output & Export | Canvas / Gemini | Google Docs / ODT |
| **Local LLM** | Inference | Ollama | WSL2-native |

### Integration with VIBE 3.0

This system complements your existing VIBE Universal System 3.0:

- **VIBE Services**: Docling (8001), Chroma (8002), Legal Processor (8003), etc.
- **Knowledge Fabric**: NotebookLM + JSON-LD + YAML control
- **Bridge**: Docker volumes can access both WSL2 and Windows paths

## Core Files

- `00_System_Config/MASTER_INDEX.yaml` — System navigation
- `00_System_Config/LM_NOTEBOOKS.jsonld` — Canonical knowledge graph
- `00_System_Config/BUTTONS.yaml` — 7 operational shortcuts
- `00_System_Config/CANVAS_TEMPLATES.yaml` — Export profiles
- `01_Live_Workspace/LIVE_DOCUMENT.md` — Daily working log
- `scripts/daily-sync.sh` — Automated daily workflow
- `scripts/validate_jsonld.py` — JSON-LD validation

## Button System

7 operational shortcuts for daily workflow:

1. **System Overview** — Show INDEX and active notes
2. **New WISSEN Note** — Create condensed knowledge
3. **Organize Sources** — Classify and detect duplicates
4. **Workflow Sync** — Update process definitions
5. **Canvas Export** — Generate documents (ODT, LaTeX, Markdown)
6. **Archive Maintenance** — Review and reclassify old content
7. **Duplicate Check** — Prevent redundancy before creating notes

See `docs/BUTTONS_GUIDE.md` for details.

## WSL2 Integration

### Performance Best Practices

✅ **DO**:
- Store repo in WSL2: `/home/<user>/lm-knowledge-fabric`
- Run scripts from WSL2: `./scripts/daily-sync.sh`
- Use Ollama natively: `ollama run llama2`
- Access Windows files read-only: `/mnt/c/Rechtssystem`

❌ **DON'T**:
- Store Git repo in `/mnt/c/...` (slow!)
- Run Python scripts from Windows paths
- Mount WSL2 files to Windows for active work

### File Access Speed Comparison

| Operation | Location | Speed |
|-----------|----------|-------|
| Git operations | WSL2 (`/home/...`) | ⚡⚡⚡ Fastest |
| Python scripts | WSL2 (`/home/...`) | ⚡⚡⚡ Fastest |
| Ollama inference | WSL2 (native) | ⚡⚡⚡ Fastest |
| Docker volumes | WSL2 path | ⚡⚡ Fast |
| Windows file access | `/mnt/c/...` | ⚡ Slow |

## CIA-LCV Compliance

- **CIA (Context Integrity):** Each layer has clear input/output rules
- **LCV (Logical Validation):** JSON-LD schema validates nodes and relationships
- **CVT (Consistent Version Transfer):** YAML configs control versioned transfers

## Documentation

- `docs/INSTALLATION.md` — Complete setup guide
- `docs/NOTEBOOKLM_SETUP.md` — NotebookLM configuration
- `docs/WSL2_INTEGRATION.md` — **NEW** WSL2 optimization guide
- `docs/JSONLD_SCHEMA.md` — JSON-LD structure reference
- `docs/AUTOMATION.md` — Daily sync workflows
- `docs/LOCAL_SCRIPTS.md` — Local model integration (Ollama)

## Daily Workflow

```bash
# Morning sync (WSL2)
cd /home/<user>/lm-knowledge-fabric
./scripts/daily-sync.sh

# Check NotebookLM for new insights
# Run Button 1: System Overview
# Run Button 7: Duplicate check before adding sources

# Evening: Update Live Document
# Run Button 4: Workflow Sync
# Run Button 5: Canvas Export if needed
```

## License

MIT License — See LICENSE file

## Contact

Maintained by: Ho-Seoung Moon  
Issues: https://github.com/hoseoungmoon-cloud/lm-knowledge-fabric/issues  
VIBE System Integration: Compatible with VIBE 3.0 (C:\Apps\VIBE_Universal_System)
