# NOTEBOOKLM SETUP GUIDE

## Notebook Creation

1. **Open NotebookLM**: https://notebooklm.google.com
2. **Create Notebook**: "LM Knowledge Fabric - Primary"
3. **Enable Google Drive Integration**: Settings → Connect Drive

## Source Organization

### Maximum Sources
- **Active Notebook**: ≤20 raw sources (your experience threshold)
- **Beyond 20**: Extract to sub-notebooks first, then consolidate

### Label Structure
Use auto-labels (available from 5+ sources) and map to prefixes:

- `WISSEN_[Thema]` — Stable facts
- `PROZESS_[Thema]` — Rules/Workflows
- `INDEX_[Thema]` — Navigation
- `OFFEN_[Thema]` — Undigested material
- `ARCHIV_[Thema]` — Obsolete/replaced

## Companion Notes

Create these three notes immediately:

### 1. INDEX_00MASTERINDEX
```
Title: INDEX_00MASTERINDEX

This is the central navigation and control node for my entire knowledge architecture.

Function:
- References all active notebooks (L1 NotebookLM)
- References L2 master graph (LM_NOTEBOOKS.jsonld)
- References format/export profiles (CANVAS_TEMPLATES.yaml)
- Documents prefixes: WISSEN, PROZESS, INDEX, OFFEN, ARCHIV

Current System Files:
- MASTER_INDEX.yaml — Organization and control file outside NotebookLM
- LM_NOTEBOOKS.jsonld — Canonical JSON-LD knowledge graph (L2)
- CANVAS_TEMPLATES.yaml — Export and Canvas profile definitions (L3)

RAG Usage:
- ALWAYS use this note first for system questions
- Instructions: "Use INDEX_00MASTERINDEX to find relevant WISSEN and PROZESS notes"
- Serves as Living Doc for topic and notebook landscape

#navigation #index #system
```

### 2. WISSEN_JSONLD-Schema_v1
```
Title: WISSEN_JSONLD-Schema_v1

This note describes the core structure of my JSON-LD knowledge graph (LM_NOTEBOOKS.jsonld).

Core Entities:
- Notebook: Logical project or topic container
- Note: Condensed knowledge unit with prefix (WISSEN/PROZESS/INDEX/ARCHIV/OFFEN)
- DocumentSource: Original source (PDF, Doc, Web, Audio)
- Document: Structured document node with reference to Source
- ProcessRule: Rule node for workflows (archival, duplicate check, sync)
- ArchiveNote: Node for archived content with reference to condensed note
- ExportTemplate: Template for Canvas/export formats (ODT, LaTeX, Markdown)
- ProtonSegment: Schema for sanitized segments from Proton Drive/Lumo

Important Fields:
- id: Stable ID (e.g., notebook:NB-001, note:WISSEN_LLMArchitektur_v1)
- type: Notebook / Note / DocumentSource / Document / ProcessRule / ArchiveNote / ExportTemplate / ProtonSegment
- status: ACTIVE / ARCHIVED / DISCOVERED
- prefix: Prefix of note (WISSEN, PROZESS etc.)
- notebookRef: Reference to Notebook node
- sourceRef: Reference to DocumentSource
- tags: Thematic keywords

RAG Usage:
- Use this note as reference for questions about structure or IDs
- System architecture answers should rely on this schema definition

#jsonld #schema #graph
```

### 3. PROZESS_Sync-Workflow_v1
```
Title: PROZESS_Sync-Workflow_v1

This note describes the standard workflow for consolidation and synchronization of my knowledge system.

Workflow Steps:
1. Raw Source (L0)
   - New PDF/Doc/Web source only if relevant and text-rich
   - NotebookLM sources ideally stay under ~20 per working notebook

2. Condensation in NotebookLM (L1)
   - Create condensed notes with prefix:
     - WISSEN_... for facts
     - PROZESS_... for rules/workflows
     - INDEX_... for navigation/Living docs
   - Each note receives tags and clear titles in format PREFIX_Topic_v[Version]

3. Transfer to JSON-LD (L2)
   - Enter new Notebook, Note, Document and ProcessRule nodes in LM_NOTEBOOKS.jsonld
   - Set status (ACTIVE/ARCHIVED) and references (notebookRef, sourceRef)

4. Canvas/Export Phase (L3)
   - Read consolidated L2 nodes and profile info from CANVAS_TEMPLATES.yaml
   - Generate Canvas documents (ODT, LaTeX, Markdown) from this data
   - Export to target formats (DOCX, PDF etc.) if needed

5. Archival
   - When sources are obsolete:
     - Condense into ARCHIV_... note
     - Set corresponding Document node in JSON-LD to status=ARCHIVED
     - Remove or move raw source from active notebook

Synchronization Principle:
- Changes to system files (MASTER_INDEX.yaml, LM_NOTEBOOKS.jsonld, CANVAS_TEMPLATES.yaml)
  are first documented here as changed steps,
  then implemented in the files themselves.

RAG Usage:
- ALWAYS consult this note first for workflow questions
- Answers to "How do I proceed?" should orient to these steps

#workflow #sync #processes
```

## Daily Workflow

### Morning (Button 1)
```
Show me INDEX_00MASTERINDEX and all active WISSEN and PROZESS notes.
```

### Work Session (Buttons 2-3)
```
Create new WISSEN note from sources. Check duplicates.
```

### Closing (Buttons 4-7)
```
Update PROZESS_Sync-Workflow_v1. Prepare Canvas export.
```

## Sync Strategy

When Google Doc sources change:
1. Click **Sync** button on the source in NotebookLM
2. NotebookLM pulls latest version without consuming new source quota
3. Your RAG context is immediately updated

## Best Practices

- Use Google Docs for dynamic sources (Live Document, INDEX, workflows)
- Use PDFs for static references
- Review and reorganize labels weekly
- Archive obsolete sources promptly
- Never exceed 20 active raw sources without sub-notebooks
