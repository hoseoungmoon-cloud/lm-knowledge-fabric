# LM KNOWLEDGE FABRIC — IMPLEMENTATION GUIDE

**Version:** v1.0  
**Status:** Production-Ready  
**Last Updated:** 2026-09-03

## Overview

A stable, scalable and cost-efficient knowledge architecture system with:
- **NotebookLM-first** — All raw sources and large data volumes first condensed in NotebookLM
- **JSON-LD canonical** — L2 master graph as the only system truth
- **YAML operational** — Control files for buttons, profiles and transfers
- **CIA-LCV compliant** — Context Integrity, Logical Validation, Segmented Transfer

## Quick Start

### 1. Clone Repository
```bash
git clone https://github.com/hoseoungmoon-cloud/lm-knowledge-fabric.git
cd lm-knowledge-fabric
```

### 2. Create Folder Structure
```bash
mkdir -p 00_System_Config 01_Live_Workspace 02_L0_Raw_Sources 03_L1_Notebook_Backups 04_L3_Canvas_Outputs
```

### 3. Setup NotebookLM
1. Open https://notebooklm.google.com
2. Create Notebook: "LM Knowledge Fabric - Primary"
3. Enable Google Drive integration
4. Create three companion notes (see docs/NOTEBOOKLM_SETUP.md)

### 4. Initialize System Files
Copy YAML and JSON-LD files from `00_System_Config/` to your working environment.

## Architecture

| Layer | Purpose | Technology | Location |
|-------|---------|------------|----------|
| **L0** | Raw sources (transient) | PDF, DOC, Web | Google Drive / Proton Drive |
| **L1** | Condensation & Grounding | NotebookLM | NotebookLM Notebooks |
| **L2** | Canonical Graph | JSON-LD | GitHub / Local Git |
| **L3** | Output & Export | Canvas / Gemini | Google Docs / ODT / LaTeX |

## Core Files

- `00_System_Config/MASTER_INDEX.yaml` — System navigation
- `00_System_Config/LM_NOTEBOOKS.jsonld` — Canonical knowledge graph
- `00_System_Config/BUTTONS.yaml` — Operational shortcuts
- `00_System_Config/CANVAS_TEMPLATES.yaml` — Export profiles
- `01_Live_Workspace/LIVE_DOCUMENT.md` — Daily working log

## Button System

7 operational shortcuts for daily workflow:
1. System Overview
2. New WISSEN Note
3. Organize Sources
4. Workflow Sync
5. Canvas Export
6. Archive Maintenance
7. Duplicate Check

See `docs/BUTTONS_GUIDE.md` for details.

## CIA-LCV Compliance

- **CIA (Context Integrity):** Each layer has clear input/output rules
- **LCV (Logical Validation):** JSON-LD schema validates nodes and relationships
- **CVT (Consistent Version Transfer):** YAML configs control versioned transfers

## Documentation

- `docs/INSTALLATION.md` — Complete setup guide
- `docs/NOTEBOOKLM_SETUP.md` — NotebookLM configuration
- `docs/JSONLD_SCHEMA.md` — JSON-LD structure reference
- `docs/AUTOMATION.md` — Daily sync workflows
- `docs/LOCAL_SCRIPTS.md` — Local model integration

## License

MIT License — See LICENSE file

## Contact

Maintained by: Ho-Seoung Moon
Issues: https://github.com/hoseoungmoon-cloud/lm-knowledge-fabric/issues
