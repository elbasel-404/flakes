# Development Shell Template

A template for creating development environments with Nix flakes.

## Usage

1. Initialize with this template:
   ```bash
   nix flake init -t github:elbasel-404/flakes#devshell
   ```

2. Edit `flake.nix` to add your development tools

3. Enter the development shell:
   ```bash
   nix develop
   ```

## What's Included

- flake-utils for cross-platform support
- Pre-configured development shell
- Shell hook with welcome message

## Customization

Add your tools to the `buildInputs` list:

```nix
buildInputs = with pkgs; [
  # Programming languages
  nodejs
  python3
  go
  rustc
  
  # Build tools
  cmake
  gcc
  
  # Development tools
  git
  vim
  tmux
];
```

## Tips

- Use `direnv` with `use flake` for automatic shell activation
- Add project-specific scripts to `shellHook`
- Set environment variables in the shell
