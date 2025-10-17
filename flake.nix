{
  description = "A modern Nix flakes library with reusable functions and patterns";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      # Library functions available to all systems
      lib = import ./lib { inherit (nixpkgs) lib; };
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Development shells
        devShells = {
          default = pkgs.mkShell {
            name = "flakes-dev";
            buildInputs = with pkgs; [
              nixpkgs-fmt
              nil
            ];
            shellHook = ''
              echo "Welcome to the Flakes library development environment!"
              echo "Available commands:"
              echo "  - nixpkgs-fmt: Format Nix files"
              echo "  - nil: Nix Language Server"
            '';
          };
        };

        # Example packages
        packages = {
          # A simple example package
          hello-flake = pkgs.writeShellScriptBin "hello-flake" ''
            echo "Hello from the flakes library!"
          '';
        };

        # Default package
        defaultPackage = self.packages.${system}.hello-flake;
      }
    ) // {
      # System-agnostic outputs
      lib = lib;
      
      # NixOS modules
      nixosModules = {
        default = import ./modules/default.nix;
      };

      # Overlay for packages
      overlays = {
        default = final: prev: {
          flakes-lib = lib;
        };
      };

      # Templates for quick-start
      templates = {
        basic = {
          path = ./templates/basic;
          description = "A basic flake template";
        };
        devshell = {
          path = ./templates/devshell;
          description = "A development shell template";
        };
        package = {
          path = ./templates/package;
          description = "A package template";
        };
      };
    };
}
