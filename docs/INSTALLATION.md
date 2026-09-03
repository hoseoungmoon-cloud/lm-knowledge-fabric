# INSTALLATION GUIDE — LM KNOWLEDGE FABRIC v1.0

## Prerequisites

- Google Drive account with Workspace integration
- NotebookLM access (free, 50 sources/notebook, 500k words/source)
- GitHub account for versioning
- Optional: Proton Drive for encrypted raw data

## Step 1: Repository Setup

```bash
git clone https://github.com/hoseoungmoon-cloud/lm-knowledge-fabric.git
cd lm-knowledge-fabric
```

## Step 2: Folder Structure

```bash
mkdir -p 00_System_Config 01_Live_Workspace 02_L0_Raw_Sources 03_L1_Notebook_Backups 04_L3_Canvas_Outputs
mkdir -p docs scripts
```

## Step 3: Initialize System Files

Create these files in `00_System_Config/`:

### 3.1 MASTER_INDEX.yaml
```yaml
system:
  name: LM Knowledge Fabric
  version: v1.0
  purpose: Cross-platform consolidation
layers:
  l0: { label: raw_sources, state: transient }
  l1: { label: notebooklm_knowledge, state: grounded }
  l2: { label: jsonld_master_graph, state: canonical }
  l3: { label: canvas_output, state: operational }
notebooks:
  - notebook_id: NB-001
    title: LM Knowledge Fabric - Primary
    status: active
    source_count: 0
master_index:
  index_id: INDEX_00MASTERINDEX
  sections: [knowledge, process, open, archive]
handoff:
  source: notebooklm
  target: gemini_canvas
  mode: transform
```

### 3.2 LM_NOTEBOOKS.jsonld
See `docs/JSONLD_SCHEMA.md` for complete schema.

### 3.3 BUTTONS.yaml
See `docs/BUTTONS_GUIDE.md` for complete button definitions.

### 3.4 CANVAS_TEMPLATES.yaml
See `docs/CANVAS_TEMPLATES.md` for export profiles.

## Step 4: NotebookLM Setup

1. Open https://notebooklm.google.com
2. Create notebook: "LM Knowledge Fabric - Primary"
3. Enable Google Drive integration
4. Create three companion notes:
   - `INDEX_00MASTERINDEX`
   - `WISSEN_JSONLD-Schema_v1`
   - `PROZESS_Sync-Workflow_v1`

## Step 5: Live Document

Create Google Doc in `01_Live_Workspace/`:
- Title: "LIVE DOCUMENT — LM KNOWLEDGE FABRIC"
- Use template from `docs/LIVE_DOCUMENT_TEMPLATE.md`

## Step 6: Gemini Custom Instructions

Configure Gemini Advanced with system instructions from `docs/SYSTEM_PROMPTS.md`.

## Verification

- [ ] Repository cloned
- [ ] Folder structure created
- [ ] YAML files initialized
- [ ] NotebookLM notebook created
- [ ] Three companion notes added
- [ ] Live Document created
- [ ] Gemini instructions configured

## Next Steps

1. Add first 10-20 raw sources to NotebookLM
2. Establish daily sync workflow
3. Populate JSON-LD graph with initial nodes
4. Test Canvas exports (ODT, LaTeX, Markdown)

For troubleshooting, see `docs/TROUBLESHOOTING.md`.
