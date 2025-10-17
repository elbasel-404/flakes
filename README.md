# Flakes Library

A modern, comprehensive Nix flakes library providing reusable functions, patterns, and templates for Nix development.

## 🚀 Features

- **Rich Library Functions**: String manipulation, list operations, attribute set utilities, filesystem helpers, and more
- **Package Builders**: Simplified helpers for creating packages, scripts, Docker images, and systemd services
- **Module System**: Utilities for creating NixOS modules with less boilerplate
- **Templates**: Quick-start templates for common use cases
- **Modern Development Tools**: Pre-configured packages for VS Code Insiders and popular modern CLI tools
- **Type-Safe**: Leverages Nix's type system for safer configurations
- **Well Documented**: Each function comes with examples and clear documentation

## 📦 Installation

Add this flake as an input to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakes-lib.url = "github:elbasel-404/flakes";
  };

  outputs = { self, nixpkgs, flakes-lib }: {
    # Use the library here
  };
}
```

## 🛠️ Modern Development Tools & Applications

This flake provides easy access to modern development tools and applications. Use them directly with:

```bash
# Run VS Code Insiders
nix run github:elbasel-404/flakes#vscode-insiders

# Enter a shell with all modern tools
nix develop github:elbasel-404/flakes#modern

# Install a specific tool
nix profile install github:elbasel-404/flakes#kitty
```

### Available Packages

#### Editors & IDEs
- **vscode-insiders** - Visual Studio Code Insiders (latest development version)
- **neovim** - Hyperextensible Vim-based text editor
- **helix** - A post-modern modal text editor

#### Terminal Emulators
- **kitty** - GPU-based terminal emulator
- **alacritty** - Cross-platform, GPU-accelerated terminal emulator
- **wezterm** - GPU-accelerated cross-platform terminal emulator

#### Modern Shell Tools
- **starship** - Minimal, blazing-fast, and infinitely customizable prompt
- **zoxide** - Smarter cd command, inspired by z and autojump
- **bat** - Cat clone with syntax highlighting and Git integration
- **eza** - Modern replacement for ls
- **ripgrep** - Recursively search directories for a regex pattern
- **fd** - Simple, fast alternative to find
- **fzf** - Command-line fuzzy finder

#### Git Tools
- **lazygit** - Simple terminal UI for git commands
- **git-delta** - Syntax-highlighting pager for git, diff, and grep output
- **gh** - GitHub CLI tool

#### Container Tools
- **podman** - Daemonless container engine
- **docker** - Container platform
- **docker-compose** - Define and run multi-container applications
- **dive** - Tool for exploring docker images
- **lazydocker** - Terminal UI for docker and docker-compose

#### Cloud & DevOps Tools
- **kubectl** - Kubernetes command-line tool
- **terraform** - Infrastructure as Code tool
- **helm** - Kubernetes package manager
- **k9s** - Kubernetes CLI and TUI

#### System Monitoring
- **btop** - Resource monitor with better UI
- **bottom** - Graphical process/system monitor
- **htop** - Interactive process viewer
- **procs** - Modern replacement for ps
- **dust** - More intuitive version of du
- **duf** - Disk usage/free utility

#### File Managers & Multiplexers
- **ranger** - Console file manager with VI key bindings
- **lf** - Terminal file manager
- **tmux** - Terminal multiplexer
- **zellij** - Terminal workspace with batteries included

#### Network Tools
- **httpie** - User-friendly HTTP client
- **curlie** - curl frontend with httpie-like syntax
- **bandwhich** - Terminal bandwidth utilization tool

#### CLI Utilities
- **jq** - Command-line JSON processor
- **yq** - Command-line YAML processor
- **glow** - Markdown renderer for the terminal
- **tldr** - Simplified and community-driven man pages
- **ncdu** - Disk usage analyzer with ncurses interface
- **fx** - Terminal JSON viewer
- **dasel** - Query and modify data structures using selector strings

#### Programming Languages
- **nodejs** - JavaScript runtime
- **python3** - Python programming language
- **go** - Go programming language
- **rustc** - Rust compiler
- **cargo** - Rust package manager

#### Database Tools
- **postgresql** - Powerful, open source object-relational database
- **redis** - In-memory data structure store
- **mongodb** - NoSQL database

#### Text Processing
- **sd** - Intuitive find & replace CLI (sed alternative)
- **choose** - Human-friendly alternative to cut and awk
- **xsv** - Fast CSV command line toolkit
- **ag** - The Silver Searcher (code search tool)

#### Archive Tools
- **ouch** - Painless compression and decompression

#### Security Tools
- **age** - Simple, modern file encryption
- **sops** - Secrets management tool

#### Process & Task Management
- **just** - Handy way to save and run project-specific commands
- **watchexec** - Execute commands in response to file modifications
- **entr** - Run arbitrary commands when files change
- **hyperfine** - Command-line benchmarking tool
- **tokei** - Count lines of code quickly

#### Documentation
- **mdbook** - Create books from markdown files

#### API Development
- **insomnia** - API client and design platform
- **postman** - API platform for building and using APIs

#### IDEs & Editors
- **jetbrains-idea** - IntelliJ IDEA Community Edition
- **sublime** - Sophisticated text editor for code

#### Communication
- **slack** - Team communication platform
- **discord** - Voice, video, and text communication

#### Browsers
- **firefox** - Mozilla Firefox web browser
- **chromium** - Open-source web browser
- **brave** - Privacy-focused web browser

#### Media Tools
- **vlc** - Cross-platform multimedia player
- **obs-studio** - Free and open source video recording and live streaming

#### Graphics & Design
- **gimp** - GNU Image Manipulation Program
- **inkscape** - Vector graphics editor
- **blender** - 3D creation suite

#### Office Suite
- **libreoffice** - Free office suite

#### Note Taking
- **obsidian** - Knowledge base that works on local Markdown files
- **logseq** - Privacy-first, open-source knowledge base

#### Password Managers
- **bitwarden** - Open source password manager

#### File Sync & Backup
- **syncthing** - Continuous file synchronization

#### Virtualization
- **virt-manager** - Virtual machine manager

#### System Utilities
- **bleachbit** - System cleaner and privacy tool

## 🎯 Quick Start

### Using Modern Development Shell

Enter a fully-equipped modern development environment with a single command:

```bash
nix develop github:elbasel-404/flakes#modern
```

This gives you immediate access to:
- 🚀 Modern editors (VS Code, Neovim, Helix)
- 📁 Advanced file tools (bat, eza, ripgrep, fd, fzf)
- 🔧 Git utilities (lazygit, delta, gh)
- 📊 System monitoring (btop, bottom, htop, procs)
- 🐳 Container tools (Docker, Podman, Dive, Lazydocker)
- ☸️  Cloud tools (kubectl, Terraform, Helm, k9s)
- 🌐 Network utilities (httpie, curlie)
- 💾 CLI tools (jq, yq, glow, tldr, duf, dust, ncdu)

### Using Library Functions

```nix
{
  inputs.flakes-lib.url = "github:elbasel-404/flakes";

  outputs = { self, nixpkgs, flakes-lib }:
    let
      lib = flakes-lib.lib;
      
      # String manipulation
      greeting = lib.strings.capitalize "hello world";  # "Hello world"
      
      # List operations
      doubled = lib.lists.map (x: x * 2) [1 2 3];  # [2 4 6]
      
      # Attribute set utilities
      merged = lib.attrsets.merge { a = 1; } { b = 2; };  # { a = 1; b = 2; }
    in
    { };
}
```

### Using Templates

Initialize a new project with one of our templates:

```bash
# Basic flake
nix flake init -t github:elbasel-404/flakes#basic

# Development shell
nix flake init -t github:elbasel-404/flakes#devshell

# Package template
nix flake init -t github:elbasel-404/flakes#package

# Modern tools environment (includes VS Code Insiders and modern CLI tools)
nix flake init -t github:elbasel-404/flakes#modern-tools
```

### Using the Overlay

Add the overlay to access library functions in your packages:

```nix
{
  outputs = { self, nixpkgs, flakes-lib }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ flakes-lib.overlays.default ];
      };
    in
    {
      packages.${system}.default = pkgs.hello;
    };
}
```

### Using the NixOS Module

Enable modern tools system-wide on NixOS:

```nix
{
  imports = [
    flakes-lib.nixosModules.default
  ];

  # Enable all modern development tools
  modernTools = {
    enable = true;
    editors.enable = true;        # VS Code, Neovim, Helix
    terminals.enable = true;      # Kitty, Alacritty, WezTerm
    shellTools.enable = true;     # Starship, Bat, Eza, Ripgrep, etc.
    devTools.enable = true;       # Git tools, monitoring, etc.
    containers.enable = true;     # Docker, Podman, Dive, etc.
    cloud.enable = true;          # kubectl, Terraform, Helm, etc.
    applications.enable = true;   # Browsers, communication, office, etc.
    languages.enable = true;      # Node.js, Python, Go, Rust
  };
}
```

You can selectively enable only the categories you need:

```nix
modernTools = {
  enable = true;
  editors.enable = true;
  shellTools.enable = true;
  devTools.enable = true;
  # Leave containers, cloud, applications, and languages disabled
};
```

## 📚 Library Reference

### Strings (`lib.strings`)

String manipulation utilities:

- `toUpper` / `toLower` - Convert case
- `capitalize` - Capitalize first letter
- `hasPrefix` / `hasSuffix` - Check string boundaries
- `trim` - Remove whitespace
- `split` / `join` - Split and join strings
- `replace` - Replace patterns

**Example:**
```nix
lib.strings.split "," "a,b,c"  # => ["a" "b" "c"]
lib.strings.capitalize "hello"  # => "Hello"
```

### Lists (`lib.lists`)

List manipulation utilities:

- `head` / `tail` / `last` - Access list elements
- `filter` / `map` - Transform lists
- `foldl` / `foldr` - Reduce lists
- `unique` / `sort` - Organize lists
- `partition` / `groupBy` - Categorize lists
- `flatten` - Flatten nested lists

**Example:**
```nix
lib.lists.filter (x: x > 5) [1 3 5 7 9]  # => [7 9]
lib.lists.groupBy (x: if x < 5 then "small" else "large") [1 7 3 9]
# => { small = [1 3]; large = [7 9]; }
```

### Attribute Sets (`lib.attrsets`)

Attribute set manipulation utilities:

- `keys` / `values` - Extract keys and values
- `hasAttr` / `getAttr` - Access attributes
- `mapAttrs` / `filterAttrs` - Transform attribute sets
- `merge` / `deepMerge` - Merge attribute sets
- `toList` / `fromList` - Convert between lists and attribute sets
- `selectAttrs` / `removeAttrs` - Select or remove attributes

**Example:**
```nix
lib.attrsets.merge { a = 1; } { b = 2; }  # => { a = 1; b = 2; }
lib.attrsets.filterAttrs (n: v: v > 1) { a = 1; b = 2; c = 3; }
# => { b = 2; c = 3; }
```

### File System (`lib.filesystem`)

File system utilities:

- `listFiles` / `listNixFiles` - List files in directories
- `importAll` - Import all Nix files from a directory
- `baseName` / `dirName` - Path manipulation
- `extension` / `removeExtension` - File extension handling
- `joinPath` / `normalizePath` - Path composition

**Example:**
```nix
lib.filesystem.listNixFiles ./src  # => [./src/a.nix ./src/b.nix]
lib.filesystem.importAll ./modules  # => { module1 = ...; module2 = ...; }
```

### Builders (`lib.builders`)

Package building helpers:

- `mkShellScript` - Create shell script packages
- `mkPythonScript` - Create Python script packages
- `mkDevShell` - Create development shells
- `mkCustomPackage` - Custom package builder
- `wrapPackage` - Wrap packages with environment variables
- `mkDockerImage` - Build Docker images
- `mkSystemdService` - Create systemd services

**Example:**
```nix
lib.builders.mkShellScript "hello" "echo 'Hello!'" pkgs
lib.builders.mkDevShell [pkgs.go pkgs.nodejs] pkgs
```

### Modules (`lib.modules`)

NixOS module system helpers:

- `mkModule` - Create modules
- `mkOption` / `mkEnableOption` - Define options
- `mkStrOption` / `mkListOption` / `mkAttrsOption` - Typed options
- `mkPackageOption` - Package options
- `mkSubmodule` - Create submodules
- `mkConditionalModule` - Conditional configuration

**Example:**
```nix
lib.modules.mkEnableOption "my-feature"
lib.modules.mkStrOption { default = "value"; description = "..."; }
```

## 🔧 Development

Enter the development environment:

```bash
nix develop
```

This provides tools like `nixpkgs-fmt` for formatting and `nil` for language server support.

## 📖 Examples

See the [examples/](./examples/) directory for comprehensive examples:

- [simple-package.nix](./examples/simple-package.nix) - Creating packages
- [string-manipulation.nix](./examples/string-manipulation.nix) - String utilities
- [list-operations.nix](./examples/list-operations.nix) - List utilities
- [attrset-operations.nix](./examples/attrset-operations.nix) - Attribute set utilities
- [modern-tools.nix](./examples/modern-tools.nix) - Using modern development tools and creating specialized environments

## 📄 License

MIT License - See LICENSE file for details

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues.

## 📚 Further Reading

- [PACKAGE_LIST.md](./PACKAGE_LIST.md) - Complete list of all 90+ available packages organized by category
- [MODERN_TOOLS.md](./MODERN_TOOLS.md) - Complete guide to modern development tools and applications
- [GUIDE.md](./GUIDE.md) - Detailed guide on how each component works
- [Nix Flakes Documentation](https://nixos.wiki/wiki/Flakes)
- [Nix Language Basics](https://nixos.org/manual/nix/stable/language/)

## 🌟 Features Overview

### Why Use This Library?

1. **Reduce Boilerplate**: Common patterns packaged as reusable functions
2. **Type Safety**: Leverages Nix's type system for better error messages
3. **Consistency**: Standardized approach to common tasks
4. **Learning Resource**: Well-documented examples for learning Nix
5. **Production Ready**: Battle-tested patterns from real-world usage

### Use Cases

- **Package Development**: Simplified package building and wrapping
- **NixOS Configuration**: Streamlined module creation
- **Development Environments**: Quick setup of dev shells
- **CI/CD**: Consistent build patterns
- **Infrastructure as Code**: Reusable patterns for system configuration