# Complete Package List

This document lists all 90+ modern tools and applications available in this flake.

## 📝 Editors & IDEs (7)
- **vscode** - Visual Studio Code
- **vscode-insiders** - Visual Studio Code Insiders
- **neovim** - Hyperextensible Vim-based text editor
- **helix** - Post-modern modal text editor
- **jetbrains-idea** - IntelliJ IDEA Community Edition
- **sublime** - Sublime Text 4

## 🖥️ Terminal Emulators (3)
- **kitty** - GPU-based terminal emulator
- **alacritty** - GPU-accelerated terminal emulator
- **wezterm** - GPU-accelerated cross-platform terminal emulator

## 🎨 Shell Enhancements (2)
- **starship** - Minimal, blazing-fast prompt
- **zoxide** - Smarter cd command

## 📁 File & Search Tools (7)
- **bat** - Cat clone with syntax highlighting
- **eza** - Modern replacement for ls
- **ripgrep** - Fast recursive search
- **fd** - Simple, fast alternative to find
- **fzf** - Command-line fuzzy finder
- **ag** - The Silver Searcher
- **lf** - Terminal file manager
- **ranger** - Console file manager

## 🔧 Git Tools (3)
- **lazygit** - Simple terminal UI for git
- **git-delta** - Syntax-highlighting pager for git
- **gh** - GitHub CLI tool

## 📊 System Monitoring (7)
- **btop** - Resource monitor with better UI
- **bottom** - Graphical process/system monitor
- **htop** - Interactive process viewer
- **procs** - Modern replacement for ps
- **dust** - More intuitive version of du
- **duf** - Disk usage/free utility
- **ncdu** - Disk usage analyzer

## 🐳 Container Tools (5)
- **podman** - Daemonless container engine
- **docker** - Container platform
- **docker-compose** - Multi-container applications
- **dive** - Tool for exploring docker images
- **lazydocker** - Terminal UI for docker

## ☸️ Cloud & DevOps Tools (4)
- **kubectl** - Kubernetes command-line tool
- **terraform** - Infrastructure as Code
- **helm** - Kubernetes package manager
- **k9s** - Kubernetes CLI and TUI

## 🗂️ Multiplexers (2)
- **tmux** - Terminal multiplexer
- **zellij** - Terminal workspace

## 🌐 Network Tools (3)
- **httpie** - User-friendly HTTP client
- **curlie** - curl frontend with httpie syntax
- **bandwhich** - Terminal bandwidth utilization

## 💾 CLI Utilities (7)
- **jq** - Command-line JSON processor
- **yq** - Command-line YAML processor
- **fx** - Terminal JSON viewer
- **dasel** - Query and modify data structures
- **glow** - Markdown renderer for terminal
- **tldr** - Simplified man pages
- **mdbook** - Create books from markdown

## 💻 Programming Languages (5)
- **nodejs** - JavaScript runtime
- **python3** - Python programming language
- **go** - Go programming language
- **rustc** - Rust compiler
- **cargo** - Rust package manager

## 🗄️ Database Tools (3)
- **postgresql** - Object-relational database
- **redis** - In-memory data structure store
- **mongodb** - NoSQL database

## ✂️ Text Processing (4)
- **sd** - Intuitive find & replace CLI
- **choose** - Alternative to cut and awk
- **xsv** - Fast CSV command line toolkit

## 📦 Archive Tools (1)
- **ouch** - Painless compression/decompression

## 🔒 Security Tools (2)
- **age** - Simple, modern file encryption
- **sops** - Secrets management tool

## ⚙️ Process & Task Management (5)
- **just** - Save and run project commands
- **watchexec** - Execute commands on file changes
- **entr** - Run commands when files change
- **hyperfine** - Command-line benchmarking
- **tokei** - Count lines of code

## 🌍 Browsers (3)
- **firefox** - Mozilla Firefox
- **chromium** - Open-source web browser
- **brave** - Privacy-focused browser

## 💬 Communication (2)
- **slack** - Team communication platform
- **discord** - Voice, video, and text communication

## 🎥 Media Tools (2)
- **vlc** - Multimedia player
- **obs-studio** - Video recording and streaming

## 🎨 Graphics & Design (3)
- **gimp** - GNU Image Manipulation Program
- **inkscape** - Vector graphics editor
- **blender** - 3D creation suite

## 📄 Office Suite (1)
- **libreoffice** - Free office suite

## 📝 Note Taking (2)
- **obsidian** - Knowledge base on Markdown files
- **logseq** - Privacy-first knowledge base

## 🔐 Password Managers (1)
- **bitwarden** - Open source password manager

## 🔄 File Sync (1)
- **syncthing** - Continuous file synchronization

## 💻 Virtualization (1)
- **virt-manager** - Virtual machine manager

## 🧹 System Utilities (1)
- **bleachbit** - System cleaner and privacy tool

## 🔨 API Development (2)
- **insomnia** - API client and design platform
- **postman** - API platform

---

**Total: 90+ packages** spanning all major categories of modern development tools and applications.

## Usage

All packages can be used with:

```bash
# Run directly
nix run github:elbasel-404/flakes#<package-name>

# Install to profile
nix profile install github:elbasel-404/flakes#<package-name>

# Use in development shell
nix shell github:elbasel-404/flakes#<package-name>

# Use the complete modern shell with all tools
nix develop github:elbasel-404/flakes#modern
```

See [MODERN_TOOLS.md](./MODERN_TOOLS.md) for detailed usage information.
