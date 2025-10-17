# Package Template

A template for building packages with Nix flakes.

## Usage

1. Initialize with this template:
   ```bash
   nix flake init -t github:elbasel-404/flakes#package
   ```

2. Edit `flake.nix` to define your package build

3. Build your package:
   ```bash
   nix build
   ```

4. Run your package:
   ```bash
   ./result/bin/mypackage
   ```

## What's Included

- Package definition with stdenv.mkDerivation
- Development shell with build dependencies
- Cross-platform support with flake-utils

## Building Packages

Customize the build phases:

```nix
mypackage = pkgs.stdenv.mkDerivation {
  pname = "mypackage";
  version = "0.1.0";
  
  src = ./.;
  
  nativeBuildInputs = [ pkgs.cmake ];
  buildInputs = [ pkgs.openssl ];
  
  buildPhase = ''
    # Your build commands
    make
  '';
  
  installPhase = ''
    mkdir -p $out/bin
    cp myapp $out/bin/
  '';
};
```

## Common Build Phases

- `unpackPhase`: Extract source files
- `patchPhase`: Apply patches
- `configurePhase`: Run configuration (./configure)
- `buildPhase`: Compile the code
- `checkPhase`: Run tests
- `installPhase`: Install to $out
- `fixupPhase`: Automatic fixes (strip, patchelf)

## Tips

- Use `nix develop` to get a shell with build dependencies
- Add tests in `checkPhase`
- Use `meta` attributes to describe your package
