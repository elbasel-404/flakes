# Modern Tools Guide

This guide provides detailed information about the modern development tools and applications available in this flake.

## Table of Contents

- [Quick Start](#quick-start)
- [VS Code Insiders](#vs-code-insiders)
- [Terminal Emulators](#terminal-emulators)
- [Modern Shell Tools](#modern-shell-tools)
- [Development Tools](#development-tools)
- [Container Tools](#container-tools)
- [Cloud & DevOps](#cloud--devops)
- [Applications](#applications)
- [Usage Examples](#usage-examples)

## Quick Start

### Run a Single Tool

```bash
# Launch VS Code Insiders
nix run github:elbasel-404/flakes#vscode-insiders

# Launch Kitty terminal
nix run github:elbasel-404/flakes#kitty

# Launch any other tool
nix run github:elbasel-404/flakes#<package-name>
```

### Enter Development Shell

```bash
# Full modern environment
nix develop github:elbasel-404/flakes#modern

# Default development environment
nix develop github:elbasel-404/flakes
```

### Install Permanently

```bash
# Install a tool to your profile
nix profile install github:elbasel-404/flakes#vscode-insiders

# List installed packages
nix profile list

# Remove a package
nix profile remove <index>
```

## VS Code Insiders

Visual Studio Code Insiders is the preview version of VS Code with the latest features.

### Usage

```bash
# Run directly
nix run github:elbasel-404/flakes#vscode-insiders

# Install to profile
nix profile install github:elbasel-404/flakes#vscode-insiders

# Use in a project
nix shell github:elbasel-404/flakes#vscode-insiders
```

### Integration with Projects

Add to your project's `flake.nix`:

```nix
{
  inputs.flakes-lib.url = "github:elbasel-404/flakes";
  
  outputs = { self, nixpkgs, flakes-lib }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          flakes-lib.packages.${system}.vscode-insiders
        ];
      };
    };
}
```

## Terminal Emulators

Modern, GPU-accelerated terminal emulators.

### Kitty

Fast, feature-rich, GPU-based terminal emulator.

```bash
nix run github:elbasel-404/flakes#kitty
```

**Features:**
- GPU acceleration
- Image support
- Ligature support
- Highly configurable

### Alacritty

Cross-platform, GPU-accelerated terminal emulator.

```bash
nix run github:elbasel-404/flakes#alacritty
```

**Features:**
- Minimal configuration
- Very fast
- Cross-platform

### WezTerm

GPU-accelerated cross-platform terminal emulator with multiplexing.

```bash
nix run github:elbasel-404/flakes#wezterm
```

**Features:**
- Built-in multiplexer
- Rich configuration (Lua)
- Image protocol support

## Modern Shell Tools

### Starship

Minimal, blazing-fast, and infinitely customizable prompt.

```bash
nix shell github:elbasel-404/flakes#starship
eval "$(starship init bash)"  # or zsh, fish, etc.
```

### Zoxide

Smarter cd command that learns your habits.

```bash
nix shell github:elbasel-404/flakes#zoxide
eval "$(zoxide init bash)"  # or zsh, fish, etc.
z <partial-directory-name>  # Jump to directory
```

### Bat

Cat clone with syntax highlighting and Git integration.

```bash
nix run github:elbasel-404/flakes#bat -- README.md
bat --style=numbers,changes myfile.rs
```

### Eza

Modern replacement for ls with better defaults.

```bash
nix run github:elbasel-404/flakes#eza
eza --long --header --git  # Show detailed list with git status
eza --tree --level=2       # Tree view
```

### Ripgrep

Recursively search directories for regex patterns (faster than grep).

```bash
nix shell github:elbasel-404/flakes#ripgrep
rg "pattern" /path/to/search
rg -i "case-insensitive"
```

### fd

Simple, fast alternative to find.

```bash
nix shell github:elbasel-404/flakes#fd
fd pattern                  # Find files matching pattern
fd -e js                   # Find all .js files
fd -H hidden              # Include hidden files
```

### fzf

Command-line fuzzy finder.

```bash
nix shell github:elbasel-404/flakes#fzf
fzf                        # Interactive file finder
vim $(fzf)                 # Open file in vim
git checkout $(git branch | fzf)  # Fuzzy branch selection
```

## Development Tools

### LazyGit

Simple terminal UI for git commands.

```bash
nix run github:elbasel-404/flakes#lazygit
```

**Features:**
- Intuitive interface
- Stage, commit, push/pull
- Branch management
- Conflict resolution

### Git Delta

Syntax-highlighting pager for git, diff, and grep output.

```bash
nix shell github:elbasel-404/flakes#git-delta
git diff | delta           # Colorize diff output
```

Configure in git:
```bash
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
```

### GitHub CLI (gh)

GitHub on the command line.

```bash
nix shell github:elbasel-404/flakes#gh
gh repo clone owner/repo
gh pr list
gh issue create
```

### btop / bottom

Modern system monitors.

```bash
nix run github:elbasel-404/flakes#btop
nix run github:elbasel-404/flakes#bottom
```

### Just

Handy way to save and run project-specific commands.

```bash
nix shell github:elbasel-404/flakes#just
```

Create a `justfile`:
```
# List recipes
default:
    @just --list

# Build the project
build:
    cargo build --release

# Run tests
test:
    cargo test
```

### Watchexec

Execute commands when files change.

```bash
nix shell github:elbasel-404/flakes#watchexec
watchexec -e rs cargo test  # Run tests when .rs files change
```

## Container Tools

### Docker

Container platform.

```bash
nix shell github:elbasel-404/flakes#docker
docker run hello-world
```

### Podman

Daemonless container engine.

```bash
nix shell github:elbasel-404/flakes#podman
podman run hello-world
```

### LazyDocker

Terminal UI for docker and docker-compose.

```bash
nix run github:elbasel-404/flakes#lazydocker
```

### Dive

Tool for exploring docker image layers.

```bash
nix shell github:elbasel-404/flakes#dive
dive image:tag
```

## Cloud & DevOps

### kubectl

Kubernetes command-line tool.

```bash
nix shell github:elbasel-404/flakes#kubectl
kubectl get pods
kubectl apply -f deployment.yaml
```

### Terraform

Infrastructure as Code tool.

```bash
nix shell github:elbasel-404/flakes#terraform
terraform init
terraform plan
terraform apply
```

### Helm

Kubernetes package manager.

```bash
nix shell github:elbasel-404/flakes#helm
helm install myapp ./chart
helm list
```

### k9s

Kubernetes CLI and TUI.

```bash
nix run github:elbasel-404/flakes#k9s
```

**Features:**
- Interactive cluster management
- Pod logs viewing
- Resource monitoring
- Port forwarding

## Applications

### Browsers

```bash
# Firefox
nix run github:elbasel-404/flakes#firefox

# Chromium
nix run github:elbasel-404/flakes#chromium

# Brave
nix run github:elbasel-404/flakes#brave
```

### Communication

```bash
# Slack
nix run github:elbasel-404/flakes#slack

# Discord
nix run github:elbasel-404/flakes#discord
```

### Note Taking

```bash
# Obsidian
nix run github:elbasel-404/flakes#obsidian

# Logseq
nix run github:elbasel-404/flakes#logseq
```

### Office Suite

```bash
# LibreOffice
nix run github:elbasel-404/flakes#libreoffice
```

## Usage Examples

### Example 1: Web Development Environment

```nix
{
  inputs.flakes-lib.url = "github:elbasel-404/flakes";
  
  outputs = { self, nixpkgs, flakes-lib, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = nixpkgs.legacyPackages.${system}.mkShell {
        buildInputs = with flakes-lib.packages.${system}; [
          vscode-insiders
          nodejs
          firefox
          chromium
          httpie
          jq
          gh
          lazygit
        ];
      };
    });
}
```

### Example 2: DevOps Environment

```nix
{
  inputs.flakes-lib.url = "github:elbasel-404/flakes";
  
  outputs = { self, nixpkgs, flakes-lib, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = nixpkgs.legacyPackages.${system}.mkShell {
        buildInputs = with flakes-lib.packages.${system}; [
          vscode-insiders
          docker
          kubectl
          terraform
          helm
          k9s
          lazydocker
          jq
          yq
        ];
      };
    });
}
```

### Example 3: Minimal CLI Tools

```nix
{
  inputs.flakes-lib.url = "github:elbasel-404/flakes";
  
  outputs = { self, nixpkgs, flakes-lib, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = nixpkgs.legacyPackages.${system}.mkShell {
        buildInputs = with flakes-lib.packages.${system}; [
          bat
          eza
          ripgrep
          fd
          fzf
          lazygit
          btop
        ];
      };
    });
}
```

### Example 4: Using in NixOS Configuration

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakes-lib.url = "github:elbasel-404/flakes";
  };

  outputs = { self, nixpkgs, flakes-lib }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        flakes-lib.nixosModules.default
        {
          modernTools = {
            enable = true;
            editors.enable = true;
            terminals.enable = true;
            shellTools.enable = true;
            devTools.enable = true;
          };
        }
      ];
    };
  };
}
```

## Tips and Tricks

### Combining Multiple Tools

```bash
# Use fd with fzf for better file finding
nix shell github:elbasel-404/flakes#fd github:elbasel-404/flakes#fzf
fd | fzf | xargs bat

# Use ripgrep with bat for better search
nix shell github:elbasel-404/flakes#ripgrep github:elbasel-404/flakes#bat
rg -l "pattern" | xargs bat
```

### Creating Aliases

Add to your shell config:

```bash
# Use modern tools as default
alias ls='eza'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias cd='z'  # with zoxide
```

### Shell Integration

Add to your `.bashrc` or `.zshrc`:

```bash
# Enter modern environment automatically
if [ -z "$IN_NIX_SHELL" ]; then
  eval "$(nix develop github:elbasel-404/flakes#modern --command echo 'export IN_NIX_SHELL=1')"
fi
```

## Troubleshooting

### Tool Not Found

If a tool isn't in your PATH after entering a shell:

```bash
# Check what's available
nix flake show github:elbasel-404/flakes

# Try running directly
nix run github:elbasel-404/flakes#<tool-name>
```

### Version Issues

To use a specific version or update:

```bash
# Update the flake
nix flake update github:elbasel-404/flakes

# Lock to a specific revision
nix run github:elbasel-404/flakes/<commit-hash>#<tool-name>
```

## Contributing

Found a modern tool that should be included? Please open an issue or PR!
