# Flakes Library

A modern, comprehensive Nix flakes library providing reusable functions, patterns, and templates for Nix development.

## 🚀 Features

- **Rich Library Functions**: String manipulation, list operations, attribute set utilities, filesystem helpers, and more
- **Package Builders**: Simplified helpers for creating packages, scripts, Docker images, and systemd services
- **Module System**: Utilities for creating NixOS modules with less boilerplate
- **Templates**: Quick-start templates for common use cases
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

## 🎯 Quick Start

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

## 📄 License

MIT License - See LICENSE file for details

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues.

## 📚 Further Reading

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