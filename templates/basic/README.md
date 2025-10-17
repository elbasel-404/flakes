# Basic Flake Template

A minimal flake template to get started quickly.

## Usage

1. Initialize with this template:
   ```bash
   nix flake init -t github:elbasel-404/flakes#basic
   ```

2. Edit `flake.nix` to customize your project

3. Build the default package:
   ```bash
   nix build
   ```

4. Enter the development shell:
   ```bash
   nix develop
   ```

## What's Included

- Basic flake structure with nixpkgs input
- A default package (hello)
- A development shell

## Next Steps

- Add more packages to the `packages` output
- Customize the development shell with your tools
- Add more inputs as needed
