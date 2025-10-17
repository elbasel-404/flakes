# Comprehensive Guide to the Flakes Library

This guide provides detailed explanations of how each component of the flakes library works, including the underlying principles and advanced usage patterns.

## Table of Contents

1. [Understanding Nix Flakes](#understanding-nix-flakes)
2. [Library Architecture](#library-architecture)
3. [String Utilities Deep Dive](#string-utilities-deep-dive)
4. [List Operations Explained](#list-operations-explained)
5. [Attribute Set Manipulation](#attribute-set-manipulation)
6. [File System Utilities](#file-system-utilities)
7. [Package Builders](#package-builders)
8. [Module System Helpers](#module-system-helpers)
9. [Advanced Patterns](#advanced-patterns)
10. [Best Practices](#best-practices)

## Understanding Nix Flakes

### What are Flakes?

Flakes are a modern approach to Nix package management that provides:

- **Reproducibility**: Lock files ensure consistent builds
- **Composability**: Easy to combine multiple flakes
- **Standardization**: Uniform structure across projects
- **Hermetic Evaluation**: Pure evaluation by default

### Basic Flake Structure

```nix
{
  description = "Project description";
  
  inputs = {
    # Dependencies go here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  
  outputs = { self, nixpkgs }: {
    # Outputs: packages, devShells, nixosModules, etc.
  };
}
```

### Key Concepts

1. **Inputs**: External dependencies (other flakes, git repos)
2. **Outputs**: What your flake provides (packages, shells, modules)
3. **Lock File**: Records exact versions of all inputs
4. **System**: Platform-specific builds (x86_64-linux, aarch64-darwin, etc.)

## Library Architecture

### How the Library is Organized

```
flakes/
├── flake.nix          # Main flake definition
├── lib/               # Library functions
│   ├── default.nix    # Main entry point
│   ├── strings.nix    # String utilities
│   ├── lists.nix      # List utilities
│   ├── attrsets.nix   # Attribute set utilities
│   ├── filesystem.nix # File system utilities
│   ├── builders.nix   # Package builders
│   └── modules.nix    # Module helpers
├── modules/           # NixOS modules
├── templates/         # Flake templates
└── examples/          # Usage examples
```

### Design Principles

1. **Composability**: Functions can be combined easily
2. **Purity**: No side effects, predictable behavior
3. **Type Safety**: Leverage Nix's type system
4. **Documentation**: Every function is documented with examples
5. **Minimal Dependencies**: Uses nixpkgs.lib as the foundation

## String Utilities Deep Dive

### How String Functions Work

Nix strings are immutable, so operations create new strings rather than modifying existing ones.

#### `capitalize` Implementation

```nix
capitalize = str:
  if str == "" then ""
  else lib.toUpper (lib.substring 0 1 str) + lib.substring 1 (lib.stringLength str) str;
```

**How it works:**
1. Check if string is empty
2. Take first character and convert to uppercase
3. Concatenate with rest of string
4. Return new string

#### `replace` Implementation

```nix
replace = pattern: replacement: str:
  lib.concatStringsSep replacement (lib.splitString pattern str);
```

**How it works:**
1. Split string by pattern (creates list)
2. Join list elements with replacement string
3. Result: all occurrences replaced

### Use Cases

- **Configuration Generation**: Transform template strings
- **Path Manipulation**: Adjust file paths programmatically
- **Data Processing**: Clean and transform text data
- **Naming Conventions**: Convert between camelCase, kebab-case, etc.

## List Operations Explained

### Functional Programming Patterns

Lists in Nix are immutable linked lists, making them ideal for functional operations.

#### `map` - Transform Every Element

```nix
map = fn: list: lib.map fn list;
```

**Example:**
```nix
map (x: x * 2) [1 2 3]  # => [2 4 6]
```

**How it works:**
- Applies function to each element
- Returns new list with transformed values
- Original list unchanged

#### `filter` - Select Elements

```nix
filter = predicate: list: lib.filter predicate list;
```

**Example:**
```nix
filter (x: x > 5) [1 3 5 7 9]  # => [7 9]
```

**How it works:**
- Tests each element with predicate function
- Keeps elements where predicate returns true
- Returns new list with selected elements

#### `foldl` - Reduce from Left

```nix
foldl = fn: initial: list: lib.foldl fn initial list;
```

**Example:**
```nix
foldl (acc: x: acc + x) 0 [1 2 3 4]  # => 10
```

**How it works:**
1. Start with initial value (accumulator)
2. Process each element left-to-right
3. Update accumulator with fn(accumulator, element)
4. Return final accumulator value

#### `groupBy` - Categorize Elements

```nix
groupBy = keyFn: list:
  lib.foldl (acc: elem:
    let key = keyFn elem;
    in acc // { ${key} = (acc.${key} or []) ++ [elem]; }
  ) {} list;
```

**Example:**
```nix
groupBy (x: if x % 2 == 0 then "even" else "odd") [1 2 3 4]
# => { even = [2 4]; odd = [1 3]; }
```

**How it works:**
1. Initialize empty attribute set
2. For each element, compute key with keyFn
3. Append element to list at that key
4. Return attribute set with all groups

### Performance Considerations

- Lists are linked lists: O(n) for length, O(1) for head
- Prepending (cons) is O(1), appending is O(n)
- Use `foldl` for left-to-right accumulation
- Use `foldr` for right-to-left (better for building lists)

## Attribute Set Manipulation

### Understanding Attribute Sets

Attribute sets are Nix's primary data structure, similar to dictionaries or maps in other languages.

#### Lazy Evaluation

Attribute sets are lazily evaluated:

```nix
{
  a = 1;
  b = throw "error";  # Not evaluated unless b is accessed
}
```

#### `mapAttrs` - Transform Values

```nix
mapAttrs = fn: attrset: lib.mapAttrs fn attrset;
```

**Example:**
```nix
mapAttrs (name: value: value * 2) { a = 1; b = 2; }
# => { a = 2; b = 4; }
```

**How it works:**
- Function receives both name and value
- Returns new attribute set with transformed values
- Keys remain the same

#### `deepMerge` - Recursive Merge

```nix
deepMerge = left: right: lib.recursiveUpdate left right;
```

**Example:**
```nix
deepMerge 
  { a = { x = 1; y = 2; }; }
  { a = { y = 3; z = 4; }; }
# => { a = { x = 1; y = 3; z = 4; }; }
```

**How it works:**
1. Recursively traverse both attribute sets
2. For nested attributes, merge recursively
3. Right values override left values at each level

#### `flatten` - Convert to Dot Notation

```nix
flatten = attrset:
  lib.foldl (acc: { name, value }:
    if lib.isAttrs value && !lib.isDerivation value
    then acc // (lib.mapAttrs' (n: v: { name = "${name}.${n}"; value = v; }) (flatten value))
    else acc // { ${name} = value; }
  ) {} (toList attrset);
```

**Example:**
```nix
flatten { a = { b = { c = 1; }; }; d = 2; }
# => { "a.b.c" = 1; d = 2; }
```

**How it works:**
1. Convert attribute set to list of name-value pairs
2. For each pair, check if value is an attribute set
3. If yes, recursively flatten and prefix keys
4. If no, add to result with current key

### Common Patterns

#### Configuration Merging

```nix
configs = [ config1 config2 config3 ];
finalConfig = lib.foldl deepMerge {} configs;
```

#### Selective Attribute Access

```nix
publicAPI = selectAttrs ["function1" "function2"] allFunctions;
```

#### Conditional Attributes

```nix
{
  always = "present";
} // (if condition then { optional = "value"; } else {})
```

## File System Utilities

### Working with Paths

Nix has special support for paths, which are first-class values.

#### `listNixFiles` Implementation

```nix
listNixFiles = dir:
  lib.filter (path: lib.hasSuffix ".nix" (toString path))
    (lib.filesystem.listFilesRecursive dir);
```

**How it works:**
1. Recursively list all files in directory
2. Filter to only .nix files by checking suffix
3. Return list of paths

#### `importAll` Implementation

```nix
importAll = dir:
  let
    files = listNixFiles dir;
    getName = path:
      let
        base = baseNameOf path;
        name = lib.removeSuffix ".nix" base;
      in
        name;
  in
    lib.listToAttrs (lib.map (file: {
      name = getName file;
      value = import file;
    }) files);
```

**How it works:**
1. Get all .nix files in directory
2. For each file, extract name without .nix extension
3. Import the file and create name-value pair
4. Convert list to attribute set

### Use Cases

#### Auto-importing Modules

```nix
modules = lib.filesystem.importAll ./modules;
# Automatically imports all .nix files from ./modules
```

#### Directory-based Configuration

```nix
services = lib.filesystem.importAll ./services;
nixosConfiguration = {
  imports = lib.attrValues services;
};
```

## Package Builders

### Understanding Derivations

A derivation is Nix's fundamental building block - a description of how to build something.

#### `mkShellScript` Implementation

```nix
mkShellScript = name: text: pkgs:
  pkgs.writeShellScriptBin name text;
```

**What it does:**
- Creates a package containing a shell script
- Script is placed in `bin/` directory
- Package can be added to `environment.systemPackages` or `buildInputs`

**Example:**
```nix
myScript = lib.builders.mkShellScript "greet" ''
  echo "Hello, $1!"
'' pkgs;

# Use in a shell:
devShell = pkgs.mkShell {
  buildInputs = [ myScript ];
};
```

#### `mkCustomPackage` Implementation

```nix
mkCustomPackage = { name, src, buildPhase ? "", installPhase ? "", ... }@args: pkgs:
  pkgs.stdenv.mkDerivation ({
    inherit name src;
    buildPhase = buildPhase;
    installPhase = installPhase;
  } // args);
```

**How it works:**
1. Takes package parameters (name, src, phases)
2. Creates a derivation using stdenv
3. Allows custom build and install phases
4. Merges additional arguments

**Build Phases:**
- `unpackPhase`: Extract source
- `patchPhase`: Apply patches
- `configurePhase`: Run ./configure
- `buildPhase`: Compile code
- `installPhase`: Copy outputs to $out

#### `wrapPackage` Implementation

```nix
wrapPackage = pkg: env: pkgs:
  pkgs.symlinkJoin {
    name = "${pkg.name}-wrapped";
    paths = [ pkg ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/* \
        ${lib.concatStringsSep " \\\n  " (lib.mapAttrsToList (k: v: "--set ${k} ${v}") env)}
    '';
  };
```

**How it works:**
1. Creates a new derivation that combines the original package
2. Uses `makeWrapper` to wrap executables
3. Sets environment variables when programs run
4. Useful for adding runtime dependencies or configuration

### Advanced Builder Patterns

#### Conditional Dependencies

```nix
mkPackage = { enableFeature ? false }: pkgs:
  mkCustomPackage {
    name = "mypackage";
    buildInputs = with pkgs; [
      essentialDep
    ] ++ lib.optional enableFeature optionalDep;
  } pkgs;
```

#### Multi-output Packages

```nix
outputs = [ "out" "dev" "doc" ];
# Separate outputs for runtime, development files, and documentation
```

## Module System Helpers

### NixOS Module Structure

A NixOS module defines:
1. **Options**: What can be configured
2. **Config**: How configuration is applied

#### Basic Module Pattern

```nix
{ lib, config, pkgs, ... }:

{
  options = {
    services.myservice.enable = lib.mkEnableOption "my service";
  };

  config = lib.mkIf config.services.myservice.enable {
    systemd.services.myservice = { ... };
  };
}
```

#### `mkOption` Variations

```nix
# String option
lib.modules.mkStrOption {
  default = "default value";
  description = "A string option";
}

# List option
lib.modules.mkListOption {
  type = lib.types.str;
  default = [];
  description = "A list of strings";
}

# Package option
lib.modules.mkPackageOption pkgs.hello {
  description = "The hello package to use";
}
```

#### Type System

Common types:
- `types.bool`: Boolean
- `types.int`: Integer
- `types.str`: String
- `types.path`: File system path
- `types.package`: Nix package
- `types.listOf T`: List of type T
- `types.attrsOf T`: Attribute set with values of type T
- `types.submodule`: Nested module

#### Conditional Configuration

```nix
config = lib.mkIf config.myservice.enable {
  # Only applied when myservice.enable = true
};
```

#### Assertions

```nix
config = {
  assertions = [
    {
      assertion = config.myservice.enable -> config.database.enable;
      message = "myservice requires database to be enabled";
    }
  ];
};
```

### Advanced Module Patterns

#### Module with Dependencies

```nix
{ lib, config, pkgs, ... }:

{
  options.myservice = {
    enable = lib.mkEnableOption "my service";
    port = lib.mkOption {
      type = lib.types.int;
      default = 8080;
    };
  };

  config = lib.mkIf config.myservice.enable {
    # Ensure prerequisite services are enabled
    services.postgresql.enable = true;
    
    # Configure the service
    systemd.services.myservice = {
      wantedBy = [ "multi-user.target" ];
      after = [ "postgresql.service" ];
      serviceConfig = {
        ExecStart = "${pkgs.mypackage}/bin/myservice --port ${toString config.myservice.port}";
      };
    };
  };
}
```

## Advanced Patterns

### Composition Patterns

#### Function Composition

```nix
compose = f: g: x: f (g x);

toUpperFirst = compose (lib.strings.toUpper) (lib.strings.head);
```

#### Pipeline Pattern

```nix
pipe = fns: initial: lib.foldl (acc: fn: fn acc) initial fns;

result = pipe [
  (filter (x: x > 0))
  (map (x: x * 2))
  (foldl (acc: x: acc + x) 0)
] myList;
```

### Lazy Evaluation Tricks

#### Recursive Attribute Sets

```nix
rec {
  a = 1;
  b = a + 1;  # Can reference 'a'
  c = b + 1;  # Can reference 'b'
}
```

#### Fixed Point Combinators

```nix
fix = f: let x = f x; in x;

myPackages = fix (self: {
  a = pkgs.hello;
  b = self.a.override { ... };  # Can reference self.a
});
```

### Override Patterns

#### Package Overrides

```nix
myPkg = pkgs.hello.override {
  stdenv = pkgs.gcc11Stdenv;  # Use different compiler
};
```

#### Overlay Pattern

```nix
overlay = final: prev: {
  myPkg = prev.hello.overrideAttrs (old: {
    patches = old.patches ++ [ ./my-patch.diff ];
  });
};
```

## Best Practices

### 1. Pure Functions

Always write pure functions - no side effects:

```nix
# Good: Pure function
double = x: x * 2;

# Bad: Would have side effects if Nix allowed
# impure = x: builtins.readFile "/tmp/data";  # Don't do this
```

### 2. Descriptive Names

Use clear, descriptive names:

```nix
# Good
convertCamelCaseToKebabCase = str: ...;

# Bad
cvt = s: ...;
```

### 3. Type Annotations in Comments

Document expected types:

```nix
# processItems :: [Item] -> [ProcessedItem]
processItems = items: ...;
```

### 4. Error Messages

Provide helpful error messages:

```nix
mkPackage = name: src:
  assert lib.assertMsg (name != "") "Package name cannot be empty";
  assert lib.assertMsg (builtins.pathExists src) "Source path must exist";
  ...;
```

### 5. Default Arguments

Provide sensible defaults:

```nix
mkConfig = { 
  port ? 8080,
  host ? "localhost",
  debug ? false
}: ...;
```

### 6. Documentation

Document every public function:

```nix
# Convert a string to uppercase
# Type: string -> string
# Example: toUpper "hello" => "HELLO"
toUpper = str: lib.toUpper str;
```

### 7. Testing

Test your functions:

```nix
assert lib.strings.capitalize "hello" == "Hello";
assert lib.lists.sum [1 2 3] == 6;
```

### 8. Modularity

Keep functions small and focused:

```nix
# Good: Small, focused functions
isEven = x: x % 2 == 0;
filterEven = filter isEven;

# Better than: One large function doing everything
```

### 9. Use Existing Libraries

Don't reinvent the wheel:

```nix
# Good: Use nixpkgs.lib
capitalize = str: lib.toUpper (lib.substring 0 1 str) + ...;

# Bad: Reimplement from scratch
```

### 10. Performance Awareness

Be aware of performance implications:

```nix
# Efficient: Prepend to list (O(1))
list = [ newItem ] ++ existingList;

# Inefficient: Append to list (O(n))
list = existingList ++ [ newItem ];  # Avoid in loops
```

## Conclusion

This flakes library provides a comprehensive set of tools for working with Nix. By understanding the underlying principles and patterns, you can:

1. Write more maintainable Nix code
2. Leverage functional programming patterns
3. Build complex systems from simple, composable parts
4. Create reusable modules and packages
5. Follow best practices for Nix development

For more examples and specific use cases, refer to the [examples/](./examples/) directory and the [README.md](./README.md).

## Additional Resources

- [Nix Pills](https://nixos.org/guides/nix-pills/) - Learn Nix deeply
- [Nixpkgs Manual](https://nixos.org/manual/nixpkgs/stable/) - Reference for nixpkgs
- [NixOS Manual](https://nixos.org/manual/nixos/stable/) - NixOS-specific docs
- [Nix Flakes RFC](https://github.com/NixOS/rfcs/pull/49) - Original flakes proposal
