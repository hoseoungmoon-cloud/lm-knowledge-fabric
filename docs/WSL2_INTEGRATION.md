# WSL2 INTEGRATION GUIDE — LM KNOWLEDGE FABRIC

## System Analysis & Optimized Synthesis

Based on your existing VIBE Universal System 3.0 architecture and WSL2-native Ollama setup, this guide provides an optimized system synthesis that respects Windows/Linux filesystem boundaries while maximizing performance.

## Architecture Overview

### Your Current System
- **VIBE 3.0**: Docker-Compose microservices (9 containers)
- **Base Path**: `C:\Apps\VIBE_Universal_System`
- **Services**: Docling (8001), Chroma (8002), Legal Processor (8003), Orchestrator (8004), Intelligence Router (8005), Text Sanitizer (8006), Hybrid Chunker (8010)
- **Ollama**: Native in WSL2
- **Knowledge System**: `C:\Rechtssystem` (9175.9 MB)

### Optimized Integration Strategy

**CRITICAL RULE**: Store WSL2 project files in Linux filesystem for best performance:
- ✅ **Use**: `\wsl$\<DistroName>\home\<User>\lm-knowledge-fabric`
- ❌ **Avoid**: `/mnt/c/Users/<User>/lm-knowledge-fabric` or `C:\Users\<User>\...`

## Filesystem Strategy

### Three-Tier Storage Model

```
TIER 1: WSL2 Native (Performance-Critical)
├── /home/<user>/lm-knowledge-fabric/
│   ├── 00_System_Config/          ← YAML, JSON-LD (Git-tracked)
│   ├── docs/                       ← Documentation
│   ├── scripts/                    ← Python/Shell scripts
│   └── .git/                       ← Repository
│
└── /home/<user>/ollama/
    └── models/                     ← Local LLM models

TIER 2: Windows Drive (Raw Sources)
├── C:\Apps\VIBE_Universal_System\  ← Docker services
├── C:\Rechtssystem\                ← Legal library (9.1 GB)
└── C:\Users\<User>\Documents\      ← Office exports

TIER 3: Cloud Sync (Backup & Access)
├── Google Drive/                   ← Live Document, Canvas outputs
├── Proton Drive/                   ← Encrypted sources
└── GitHub/                         ← Version control
```

## Integration Patterns

### Pattern 1: WSL2 ↔ Windows Interop

**From WSL2 (Ubuntu):**
```bash
# Access Windows files (read-only recommended)
ls -la /mnt/c/Rechtssystem/RECHTSBIBLIOTHEK/

# Open Windows Explorer from WSL2
explorer.exe .

# Run Windows tools from Linux
notepad.exe /home/<user>/lm-knowledge-fabric/00_System_Config/BUTTONS.yaml

# Access Ollama (native in WSL2)
ollama run llama2
```

**From Windows (PowerShell):**
```powershell
# Run Linux commands
wsl ls -la /home/<user>/lm-knowledge-fabric/

# Access WSL2 files from Windows
explorer.exe \\wsl$\Ubuntu\home\<user>\lm-knowledge-fabric

# Run Ollama via WSL2
wsl ollama run llama2
```

### Pattern 2: Docker ↔ WSL2 Bridge

Your VIBE 3.0 Docker containers can access WSL2 filesystem:

**docker-compose.yml addition:**
```yaml
services:
  vibe-orchestrator:
    volumes:
      - \\wsl$\Ubuntu\home\<user>\lm-knowledge-fabric\00_System_Config:/app/config:ro
      - /mnt/c/Rechtssystem/RECHTSBIBLIOTHEK:/data/legal:ro
```

### Pattern 3: Ollama Integration

**Local LLM access from knowledge fabric:**
```python
# scripts/ollama_client.py
import requests

def query_ollama(prompt, model="llama2"):
    response = requests.post(
        "http://localhost:11434/api/generate",
        json={
            "model": model,
            "prompt": prompt,
            "stream": False
        }
    )
    return response.json()["response"]
```

## Optimized Workflow

### Daily Sync (WSL2-Native)

```bash
#!/bin/bash
# scripts/daily-sync.sh

# 1. Navigate to WSL2 project (FAST)
cd /home/<user>/lm-knowledge-fabric

# 2. Pull latest from GitHub
git pull origin main

# 3. Run local validation
python scripts/validate_jsonld.py

# 4. Sync with Google Drive (via rclone or similar)
rclone sync gdrive:Live_Workspace/ ./01_Live_Workspace/

# 5. Update JSON-LD graph
python scripts/update_graph.py

# 6. Commit changes
git add .
git commit -m "Daily sync: $(date +%Y-%m-%d)"
git push origin main
```

### NotebookLM ↔ WSL2 Bridge

Since NotebookLM is cloud-based, use this pattern:

1. **Upload from WSL2 to Google Drive:**
```bash
# Export JSON-LD to Drive-observable folder
cp 00_System_Config/LM_NOTEBOOKS.jsonld "/mnt/c/Users/<user>/Google Drive/LM_Knowledge/"
```

2. **NotebookLM reads from Google Drive** (native integration)

3. **Download condensed notes back to WSL2:**
```bash
rsync -av "/mnt/c/Users/<user>/Google Drive/LM_Knowledge/Notes/" ./03_L1_Notebook_Backups/
```

## Performance Optimization

### File Access Speed

| Operation | Location | Speed |
|-----------|----------|-------|
| Git operations | WSL2 (`/home/...`) | ⚡⚡⚡ Fastest |
| Python scripts | WSL2 (`/home/...`) | ⚡⚡⚡ Fastest |
| Ollama inference | WSL2 (native) | ⚡⚡⚡ Fastest |
| Docker volumes | WSL2 path | ⚡⚡ Fast |
| Windows file access | `/mnt/c/...` | ⚡ Slow |
| Cross-filesystem | WSL2 ↔ Windows | ⚠️ Slowest |

### Best Practices

1. **Keep Git repo in WSL2**: `/home/<user>/lm-knowledge-fabric`
2. **Run Python scripts from WSL2**: Native Linux performance
3. **Use Ollama natively**: Already in WSL2, perfect
4. **Mount Windows data read-only**: `/mnt/c/Rechtssystem` for VIBE services
5. **Sync via cloud, not direct mount**: Google Drive/Proton Drive as bridge

## System Commands

### WSL2 Setup Commands

```bash
# Check WSL2 version
wsl --version

# Set Ubuntu as default
wsl --set-default Ubuntu

# Access WSL2 from Windows
\\wsl$\Ubuntu\

# Open current directory in Windows Explorer
explorer.exe .

# Check mounted drives
ls -la /mnt/

# Disable interop (if needed for security)
echo 0 > /proc/sys/fs/binfmt_misc/WSLInterop
```

### Docker Integration

```bash
# Ensure Docker can access WSL2 filesystem
docker run -v /home/<user>/lm-knowledge-fabric:/app:ro my-image

# For Windows paths (slower)
docker run -v /mnt/c/Rechtssystem:/data:ro my-image
```

### Ollama Commands

```bash
# List models
ollama list

# Run model
ollama run llama2

# Pull new model
ollama pull mistral

# Check Ollama status
systemctl status ollama  # or check service
```

## Security Considerations

### File Permissions

```bash
# Set proper permissions in WSL2
chmod 755 /home/<user>/lm-knowledge-fabric
chmod 644 /home/<user>/lm-knowledge-fabric/00_System_Config/*.yaml

# Restrict access to sensitive configs
chmod 600 /home/<user>/lm-knowledge-fabric/00_System_Config/.env
```

### Windows ↔ WSL2 Boundary

- **WSL2 files**: Not directly accessible by Windows apps (good for security)
- **Windows files**: Accessible from WSL2 via `/mnt/c/` (be careful)
- **Recommendation**: Keep sensitive data in WSL2, sync encrypted via cloud

## Migration Path

### From Pure Windows to WSL2-Hybrid

```bash
# 1. Clone repo to WSL2
cd /home/<user>
git clone https://github.com/hoseoungmoon-cloud/lm-knowledge-fabric.git

# 2. Create symlink to Windows data (optional)
ln -s /mnt/c/Rechtssystem /home/<user>/lm-knowledge-fabric/data/RECHTSBIBLIOTHEK

# 3. Update paths in configs
# Change C:\Apps\... to /mnt/c/Apps/... in Docker configs

# 4. Test Ollama integration
ollama run llama2 "Test from WSL2"

# 5. Verify Docker access
docker run --rm -v /home/<user>/lm-knowledge-fabric:/app alpine ls -la /app
```

## Troubleshooting

### Common Issues

**Issue**: Slow file access
- **Solution**: Move from `/mnt/c/...` to `/home/<user>/...`

**Issue**: Docker can't access WSL2 files
- **Solution**: Use WSL2 path directly: `-v /home/<user>/path:/app`

**Issue**: Ollama not responding
- **Check**: `systemctl status ollama` or restart service

**Issue**: Git line ending problems
- **Solution**: Set `git config core.autocrlf input` in WSL2

**Issue**: Windows apps can't open WSL2 files
- **Solution**: Copy to Windows path or use cloud sync

## Next Steps

1. **Clone repository to WSL2**: `/home/<user>/lm-knowledge-fabric`
2. **Set up cloud sync**: Google Drive ↔ WSL2 bridge
3. **Configure Docker volumes**: Point to WSL2 paths
4. **Test Ollama integration**: Run local LLM queries
5. **Establish daily sync workflow**: Git + cloud + JSON-LD updates

This optimized synthesis respects your existing VIBE 3.0 architecture while leveraging WSL2 performance for the knowledge fabric system.
