# Example: Using modern development tools from the flakes library
#
# This example demonstrates how to use the modern tools provided by this flake
# in your own projects. You can copy and adapt this for your needs.

{
  description = "Example: Modern Development Tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakes-lib.url = "github:elbasel-404/flakes";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flakes-lib, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Example 1: Create a development shell with specific modern tools
        devShells.minimal = pkgs.mkShell {
          name = "minimal-modern-shell";
          buildInputs = with flakes-lib.packages.${system}; [
            # Just the essentials
            vscode-insiders
            neovim
            bat
            eza
            ripgrep
            fzf
            lazygit
          ];
          shellHook = ''
            echo "Minimal modern development environment loaded!"
          '';
        };

        # Example 2: Full-featured development environment
        devShells.full = pkgs.mkShell {
          name = "full-modern-shell";
          buildInputs = with flakes-lib.packages.${system}; [
            # Editors
            vscode-insiders
            neovim
            helix
            
            # Terminal tools
            kitty
            alacritty
            starship
            zoxide
            
            # File utilities
            bat
            eza
            ripgrep
            fd
            fzf
            
            # Development tools
            lazygit
            git-delta
            gh
            just
            watchexec
            
            # Languages
            nodejs
            python3
            go
            rustc
            cargo
            
            # Containers
            docker
            docker-compose
            lazydocker
            
            # Cloud tools
            kubectl
            terraform
            helm
            
            # Monitoring
            btop
            bottom
            htop
            
            # Utilities
            jq
            yq
            glow
            tldr
          ];
          shellHook = ''
            echo "🚀 Full Modern Development Environment!"
            echo "All tools ready to use!"
          '';
        };

        # Example 3: Specialized environment for web development
        devShells.web = pkgs.mkShell {
          name = "web-dev-shell";
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
          shellHook = ''
            echo "🌐 Web Development Environment"
            echo "Tools: VS Code Insiders, Node.js, Browsers, HTTP tools"
          '';
        };

        # Example 4: Cloud/DevOps focused environment
        devShells.cloud = pkgs.mkShell {
          name = "cloud-devops-shell";
          buildInputs = with flakes-lib.packages.${system}; [
            vscode-insiders
            docker
            docker-compose
            kubectl
            terraform
            helm
            k9s
            lazydocker
            jq
            yq
          ];
          shellHook = ''
            echo "☸️  Cloud & DevOps Environment"
            echo "Tools: Docker, Kubernetes, Terraform, Helm"
          '';
        };

        # Example 5: Data science environment
        devShells.datascience = pkgs.mkShell {
          name = "datascience-shell";
          buildInputs = with flakes-lib.packages.${system}; [
            vscode-insiders
            python3
            jupyter
            jq
            xsv
          ] ++ (with pkgs; [
            python3Packages.pandas
            python3Packages.numpy
            python3Packages.matplotlib
          ]);
          shellHook = ''
            echo "📊 Data Science Environment"
            echo "Tools: Python, Jupyter, Pandas, NumPy"
          '';
        };

        # Example 6: Using packages directly
        packages = {
          # Create a wrapper script that launches VS Code Insiders with extensions
          my-vscode = pkgs.writeShellScriptBin "my-vscode" ''
            ${flakes-lib.packages.${system}.vscode-insiders}/bin/code-insiders "$@"
          '';

          # Create a combined tool launcher
          dev-tools = pkgs.writeShellScriptBin "dev-tools" ''
            echo "Available Development Tools:"
            echo "  1. VS Code Insiders - code-insiders"
            echo "  2. Neovim - nvim"
            echo "  3. LazyGit - lazygit"
            echo "  4. Btop - btop"
            echo "  5. LazyDocker - lazydocker"
            echo ""
            echo "All tools are in your PATH!"
          '';
        };
      }
    );
}
