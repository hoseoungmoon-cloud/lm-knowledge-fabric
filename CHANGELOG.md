# CHANGELOG — LM Knowledge Fabric

Alle nennenswerten Änderungen dieses Repositories werden hier dokumentiert.
Format angelehnt an [Keep a Changelog](https://keepachangelog.com/), Versionierung nach SemVer.

## [1.2.0] — 2026-09-27 (Konsolidierung)
### Added
- `CHANGELOG.md` — konsolidierte Versionshistorie (dieses Dokument)
- `00_System_Config/CANVAS_TEMPLATES.yaml` — bisher in README referenzierte, aber fehlende Exportprofile (House-Markdown, ODT-Report, Word-Structured, LaTeX-Article, YAML-Generic, JSON-LD-Generic)
- `docs/README.md` — zentrale Navigationsseite für alle Dokumente, inkl. Klarstellung der Abgrenzung zwischen `daily-sync.sh` und `notebooklm_pipeline.sh`

### Notes
- Keine bestehenden Dateien wurden destruktiv verändert; Konsolidierung erfolgte additiv, um Informationsverlust zu vermeiden.
- Offene Prüfpunkte: Inhalt von `scripts/notebooklm_pipeline.sh` (v1.1) sollte bei nächster Gelegenheit gegen `scripts/daily-sync.sh` auf Funktionsüberlappung geprüft werden (siehe docs/README.md → Script-Matrix).

## [1.1.0] — 2026-09-14
### Added
- `docs/USAGE_GUIDE.md` — Nutzungs- und Funktionsübersicht mit Effektivitäts-Metriken (Zeitersparnis, ROI, Qualitätskennzahlen)

## [1.0.4] — 2026-09-03
### Added
- `scripts/notebooklm_pipeline.sh` v1.1 — optimierte WSL2-Pipeline mit DSGVO-Konformität

### Fixed
- Execute-Permission auf `daily-sync.sh` dauerhaft im Git-Index gesetzt (`git update-index --chmod=+x`)

## [1.0.3] — 2026-09-03
### Fixed
- `daily-sync.sh` gehärtet: Template-Auto-Creation für `LIVE_DOCUMENT.md`, Git-Rebase-Support, verbesserte Fehlerbehandlung (`set -e`, blocking JSON-LD-Validation)

### Changed
- `README.md` aktualisiert mit WSL2-spezifischen Anweisungen und System-Synthese für Hybrid-Windows/Linux-Umgebungen

## [1.0.2] — 2026-09-03
### Added
- `scripts/validate_jsonld.py` — JSON-LD Schema-Validator (prüft `@context`, `@graph`, Node-IDs)
- `scripts/daily-sync.sh` (Erstversion) — automatisierter täglicher Sync (Git, Validation, Drive, Live Document, Commit)
- `docs/WSL2_INTEGRATION.md` — Hybrid-Architektur-Analyse (WSL2 native vs. Windows-Laufwerke), Performance-Vergleiche, VIBE 3.0 / Ollama-Integration

## [1.0.1] — 2026-09-03
### Added
- `LICENSE` (MIT)
- `.gitignore`
- `00_System_Config/LM_NOTEBOOKS.jsonld` — kanonischer JSON-LD-Wissensgraph (8 Nodes: Notebook, Notes, Process, Templates, Proton-Segment)
- `00_System_Config/MASTER_INDEX.yaml` — System-Navigation
- `00_System_Config/BUTTONS.yaml` — 7 operative Buttons (System-Übersicht, Neue WISSEN-Notiz, Quellen ordnen, Workflow-Sync, Canvas-Export, Archivpflege, Dublettencheck)
- `docs/INSTALLATION.md`, `docs/NOTEBOOKLM_SETUP.md`

## [1.0.0] — 2026-09-03
### Added
- Initial commit: vollständiger LM Knowledge Fabric Implementation Guide v1.0
- Grundlegende Repository-Struktur (00_System_Config, docs, scripts)

---

## Versionslogik
- **MAJOR**: Architektur-Änderungen (z.B. neues Schichtenmodell)
- **MINOR**: Neue Dokumente/Scripts, additive Features
- **PATCH**: Bugfixes, Härtung, Klarstellungen

## Nächste geplante Version [1.3.0]
- [ ] Klärung/Zusammenführung `daily-sync.sh` ↔ `notebooklm_pipeline.sh`
- [ ] CI/CD-Validierung (GitHub Actions: JSON-LD-Lint bei jedem Push)
- [ ] `docs/TROUBLESHOOTING.md`