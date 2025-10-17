{
  description = "A package template";

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
        packages = {
          default = self.packages.${system}.mypackage;
          
          mypackage = pkgs.stdenv.mkDerivation {
            pname = "mypackage";
            version = "0.1.0";
            
            src = ./.;
            
            buildPhase = ''
              # Add your build steps here
              echo "Building..."
            '';
            
            installPhase = ''
              mkdir -p $out/bin
              # Install your package here
              # Example: cp myapp $out/bin/
            '';
          };
        };
        
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Add build dependencies here
          ];
        };
      }
    );
}
