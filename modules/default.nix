{ lib, config, pkgs, ... }:

{
  imports = [
    ./modern-tools.nix
  ];

  # Example NixOS module from the flakes library
  # This can be imported in NixOS configuration
  
  options = {
    flakes-lib = {
      enable = lib.mkEnableOption "flakes library example module";
      
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.hello;
        description = "Package to use for the flakes library";
      };
    };
  };

  config = lib.mkIf config.flakes-lib.enable {
    environment.systemPackages = [ config.flakes-lib.package ];
  };
}
