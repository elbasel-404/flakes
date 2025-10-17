{
  description = "Modern development environment with VS Code Insiders and modern tools";

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
          name = "modern-dev-environment";
          
          buildInputs = with pkgs; [
            # Editors
            vscode
            neovim
            helix

            # Terminal emulators
            kitty
            alacritty

            # Shell enhancements
            starship
            zoxide
            
            # File utilities
            bat
            eza
            ripgrep
            fd
            fzf
            
            # Git tools
            lazygit
            delta
            gh
            
            # System monitoring
            btop
            bottom
            htop
            procs
            
            # Container tools
            docker
            docker-compose
            podman
            dive
            lazydocker
            
            # Cloud tools
            kubectl
            terraform
            kubernetes-helm
            k9s
            
            # File managers & multiplexers
            ranger
            lf
            tmux
            zellij
            
            # Network tools
            httpie
            curlie
            
            # CLI utilities
            jq
            yq
            glow
            tealdeer
            duf
            dust
            ncdu
          ];
          
          shellHook = ''
            echo "🚀 Modern Development Environment Loaded!"
            echo ""
            echo "📝 Editors: code, nvim, hx"
            echo "🖥️  Terminals: kitty, alacritty"
            echo "🎨 Shell: starship (prompt), zoxide (smart cd)"
            echo "📁 Files: bat, eza, rg, fd, fzf"
            echo "🔧 Git: lazygit, delta, gh"
            echo "📊 Monitor: btop, bottom, htop, procs"
            echo "🐳 Containers: docker, podman, dive, lazydocker"
            echo "☸️  Cloud: kubectl, terraform, helm, k9s"
            echo "🗂️  Managers: ranger, lf, tmux, zellij"
            echo "🌐 Network: httpie, curlie"
            echo "💾 Utils: jq, yq, glow, tldr, duf, dust, ncdu"
            echo ""
            echo "💡 Tip: Run 'tldr <command>' for quick help!"
          '';
        };

        packages.default = pkgs.writeShellScriptBin "modern-tools-info" ''
          echo "Modern Development Tools Template"
          echo "=================================="
          echo ""
          echo "This environment includes:"
          echo "  - Modern editors (VS Code, Neovim, Helix)"
          echo "  - Advanced CLI tools for development"
          echo "  - Container and cloud tools"
          echo "  - System monitoring utilities"
          echo ""
          echo "Run 'nix develop' to enter the environment"
        '';
      }
    );
}
