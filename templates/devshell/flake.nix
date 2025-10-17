{
  description = "A development shell template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "dev-environment";
          
          buildInputs = with pkgs; [
            # Add your development tools here
            git
            curl
            # Example: nodejs, python3, go, rust
          ];
          
          shellHook = ''
            echo "Welcome to the development environment!"
            echo "Available tools: git, curl"
          '';
        };
      }
    );
}
