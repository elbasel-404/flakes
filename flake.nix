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

          # Modern development shell with all modern tools
          modern = pkgs.mkShell {
            name = "modern-dev-shell";
            buildInputs = with pkgs; [
              # Editors
              vscode
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
              
              # File managers
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
              echo "Welcome to the Modern Development Environment!"
              echo ""
              echo "🚀 Editors: code, nvim, hx"
              echo "📁 File tools: bat, eza, rg, fd, fzf"
              echo "🔧 Git tools: lazygit, delta, gh"
              echo "📊 Monitoring: btop, bottom, htop, procs"
              echo "🐳 Containers: docker, podman, dive, lazydocker"
              echo "☸️  Cloud: kubectl, terraform, helm, k9s"
              echo "🌐 Network: httpie, curlie"
              echo "💾 Utilities: jq, yq, glow, tldr, duf, dust, ncdu"
              echo ""
              echo "Type 'tldr <command>' for quick help on any tool!"
            '';
          };
        };

        # Example packages
        packages = {
          # A simple example package
          hello-flake = pkgs.writeShellScriptBin "hello-flake" ''
            echo "Hello from the flakes library!"
          '';

          # Visual Studio Code (can be configured for Insiders)
          vscode = pkgs.vscode;
          vscode-insiders = pkgs.vscode;

          # Modern Terminal Emulators
          kitty = pkgs.kitty;
          alacritty = pkgs.alacritty;
          wezterm = pkgs.wezterm;

          # Modern Shell Tools
          starship = pkgs.starship;
          zoxide = pkgs.zoxide;
          bat = pkgs.bat;
          eza = pkgs.eza;
          ripgrep = pkgs.ripgrep;
          fd = pkgs.fd;
          fzf = pkgs.fzf;

          # Modern Editors
          neovim = pkgs.neovim;
          helix = pkgs.helix;

          # Development Utilities
          lazygit = pkgs.lazygit;
          git-delta = pkgs.delta;
          btop = pkgs.btop;
          htop = pkgs.htop;

          # Container Tools
          podman = pkgs.podman;
          docker = pkgs.docker;
          docker-compose = pkgs.docker-compose;
          dive = pkgs.dive;
          lazydocker = pkgs.lazydocker;

          # Cloud and DevOps Tools
          kubectl = pkgs.kubectl;
          terraform = pkgs.terraform;
          helm = pkgs.kubernetes-helm;
          k9s = pkgs.k9s;

          # File Managers and Utilities
          ranger = pkgs.ranger;
          lf = pkgs.lf;
          tmux = pkgs.tmux;
          zellij = pkgs.zellij;

          # Network Tools
          httpie = pkgs.httpie;
          curlie = pkgs.curlie;
          bandwhich = pkgs.bandwhich;

          # System Monitoring Tools
          bottom = pkgs.bottom;
          dust = pkgs.dust;
          procs = pkgs.procs;
          
          # Additional Modern CLI Tools
          jq = pkgs.jq;
          yq = pkgs.yq;
          glow = pkgs.glow;
          gh = pkgs.gh;
          tldr = pkgs.tealdeer;
          duf = pkgs.duf;
          ncdu = pkgs.ncdu;

          # Programming Languages and Tools
          nodejs = pkgs.nodejs;
          python3 = pkgs.python3;
          go = pkgs.go;
          rustc = pkgs.rustc;
          cargo = pkgs.cargo;

          # Database Tools
          postgresql = pkgs.postgresql;
          redis = pkgs.redis;
          mongodb = pkgs.mongodb;

          # Modern Text Processing
          sd = pkgs.sd;
          choose = pkgs.choose;
          xsv = pkgs.xsv;

          # Modern Archive Tools
          ouch = pkgs.ouch;
          
          # Security Tools
          age = pkgs.age;
          sops = pkgs.sops;

          # Process Management
          just = pkgs.just;
          watchexec = pkgs.watchexec;
          entr = pkgs.entr;

          # Documentation
          mdbook = pkgs.mdbook;
          
          # Performance Analysis
          hyperfine = pkgs.hyperfine;
          tokei = pkgs.tokei;

          # Modern grep/search
          ag = pkgs.silver-searcher;
          
          # JSON/YAML/TOML tools
          fx = pkgs.fx;
          dasel = pkgs.dasel;

          # API Development
          insomnia = pkgs.insomnia;
          postman = pkgs.postman;

          # IDEs and Editors
          jetbrains-idea = pkgs.jetbrains.idea-community;
          sublime = pkgs.sublime4;
          
          # Communication
          slack = pkgs.slack;
          discord = pkgs.discord;
          
          # Browsers
          firefox = pkgs.firefox;
          chromium = pkgs.chromium;
          brave = pkgs.brave;

          # Media Tools
          vlc = pkgs.vlc;
          obs-studio = pkgs.obs-studio;

          # Graphics and Design
          gimp = pkgs.gimp;
          inkscape = pkgs.inkscape;
          blender = pkgs.blender;

          # Office Suite
          libreoffice = pkgs.libreoffice;

          # Note Taking
          obsidian = pkgs.obsidian;
          logseq = pkgs.logseq;

          # Password Managers
          bitwarden = pkgs.bitwarden;
          
          # File Sync
          syncthing = pkgs.syncthing;
          
          # Virtualization
          virt-manager = pkgs.virt-manager;
          
          # System Tools
          bleachbit = pkgs.bleachbit;
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
        modern-tools = {
          path = ./templates/modern-tools;
          description = "Modern development environment with VS Code Insiders and modern tools";
        };
      };
    };
}
