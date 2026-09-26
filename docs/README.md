# 📚 Dokumentations-Index — LM Knowledge Fabric

Zentrale Navigationsseite für alle Dokumente im Repository. Ergänzt im Rahmen der Konsolidierung v1.2.0.

## Übersicht nach Zweck

| Dokument | Zweck | Wann lesen |
|----------|-------|------------|
| [../README.md](../README.md) | Einstieg, Quick Start | Zuerst |
| [INSTALLATION.md](INSTALLATION.md) | Setup-Schritte (Ordner, Git, NotebookLM) | Bei Ersteinrichtung |
| [NOTEBOOKLM_SETUP.md](NOTEBOOKLM_SETUP.md) | NotebookLM-Konfiguration, Labels, Begleitnotizen | Bei L1-Setup |
| [WSL2_INTEGRATION.md](WSL2_INTEGRATION.md) | Hybrid-Architektur WSL2/Windows, Performance, VIBE 3.0/Ollama | Bei lokaler Systemintegration |
| [USAGE_GUIDE.md](USAGE_GUIDE.md) | Täglicher/wöchentlicher Workflow, Effektivitäts-Metriken, ROI | Für laufenden Betrieb |
| [../CHANGELOG.md](../CHANGELOG.md) | Versionshistorie | Bei Updates prüfen |

## Script-Matrix (Klarstellung zur Vermeidung von Redundanz)

| Script | Zweck | Scope | Status |
|--------|-------|-------|--------|
| `scripts/daily-sync.sh` | Allgemeiner täglicher Sync: Git pull/push, JSON-LD-Validation, Live Document, optionaler Drive-Sync | Repository-weit (L0-L3) | Aktiv, gehärtet (v1.0.3) |
| `scripts/notebooklm_pipeline.sh` | Spezialisierte Pipeline für NotebookLM-Quellenverarbeitung mit DSGVO-Konformität | L1-Schicht (NotebookLM) | Aktiv (v1.1) — **Funktionsüberlappung mit daily-sync.sh noch zu prüfen** |
| `scripts/validate_jsonld.py` | Schema-Validierung des L2-Mastergraphen | L2-Schicht (JSON-LD) | Aktiv |

**Empfehlung:** Bis zur Prüfung der Funktionsüberlappung beide Scripts unabhängig verwenden:
- `daily-sync.sh` für den allgemeinen Repository-Sync (Git/JSON-LD/Live Doc)
- `notebooklm_pipeline.sh` gezielt für DSGVO-relevante NotebookLM-Quellenimporte

## Konfigurationsdateien (00_System_Config/)

| Datei | Inhalt |
|-------|--------|
| `MASTER_INDEX.yaml` | System-Navigation, Präfix-Legende |
| `BUTTONS.yaml` | 7 operative Shortcuts (Trigger-Prompts, Sync-Targets) |
| `LM_NOTEBOOKS.jsonld` | Kanonischer L2-Wissensgraph |
| `CANVAS_TEMPLATES.yaml` | 6 Export-Profile für L3-Ausgabe (neu in v1.2.0) |

## Empfohlene Lesereihenfolge für neue Nutzer

1. README.md (Überblick)
2. INSTALLATION.md (Setup)
3. NOTEBOOKLM_SETUP.md (L1-Konfiguration)
4. WSL2_INTEGRATION.md (falls lokale/hybride Umgebung)
5. USAGE_GUIDE.md (täglicher Betrieb)