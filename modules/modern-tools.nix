{ lib, config, pkgs, ... }:

with lib;

{
  options.modernTools = {
    enable = mkEnableOption "modern development tools and applications";

    editors = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Install modern editors (VS Code Insiders, Neovim, Helix)";
      };
    };

    terminals = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Install modern terminal emulators (Kitty, Alacritty, WezTerm)";
      };
    };

    shellTools = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Install modern shell tools (Starship, Zoxide, Bat, Eza, etc.)";
      };
    };

    devTools = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Install development utilities (Git tools, monitoring, etc.)";
      };
    };

    containers = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Install container tools (Docker, Podman, etc.)";
      };
    };

    cloud = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Install cloud/DevOps tools (kubectl, Terraform, Helm, etc.)";
      };
    };

    applications = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Install desktop applications (browsers, communication, office, etc.)";
      };
    };

    languages = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Install programming languages (Node.js, Python, Go, Rust)";
      };
    };
  };

  config = mkIf config.modernTools.enable {
    environment.systemPackages = with pkgs; 
      # Editors
      (optionals config.modernTools.editors.enable [
        vscode
        neovim
        helix
      ])
      # Terminal emulators
      ++ (optionals config.modernTools.terminals.enable [
        kitty
        alacritty
        wezterm
      ])
      # Shell tools
      ++ (optionals config.modernTools.shellTools.enable [
        starship
        zoxide
        bat
        eza
        ripgrep
        fd
        fzf
        jq
        yq
        glow
        tealdeer
        duf
        dust
        ncdu
      ])
      # Development tools
      ++ (optionals config.modernTools.devTools.enable [
        lazygit
        delta
        gh
        btop
        bottom
        htop
        procs
        just
        watchexec
        entr
        hyperfine
        tokei
        mdbook
      ])
      # Container tools
      ++ (optionals config.modernTools.containers.enable [
        docker
        docker-compose
        podman
        dive
        lazydocker
      ])
      # Cloud/DevOps tools
      ++ (optionals config.modernTools.cloud.enable [
        kubectl
        terraform
        kubernetes-helm
        k9s
      ])
      # Desktop applications
      ++ (optionals config.modernTools.applications.enable [
        firefox
        chromium
        brave
        slack
        discord
        vlc
        obs-studio
        gimp
        inkscape
        libreoffice
        obsidian
        logseq
        bitwarden
        syncthing
        virt-manager
      ])
      # Programming languages
      ++ (optionals config.modernTools.languages.enable [
        nodejs
        python3
        go
        rustc
        cargo
      ]);

    # Enable Docker service if containers are enabled
    virtualisation.docker.enable = mkIf config.modernTools.containers.enable true;

    # Enable Podman if containers are enabled
    virtualisation.podman.enable = mkIf config.modernTools.containers.enable true;
  };
}
