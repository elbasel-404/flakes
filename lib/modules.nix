{ lib }:

{
  # Create a simple NixOS module
  # Example: mkModule { options = ...; config = ...; }
  mkModule = { options ? {}, config ? {}, ... }@args:
    { lib, config, pkgs, ... }: {
      inherit options config;
    };

  # Create an option with a default value
  # Example: mkOption { type = lib.types.str; default = "value"; description = "..."; }
  mkOption = { type, default ? null, description ? "", example ? null, ... }@args:
    lib.mkOption ({
      inherit type description;
    } // (if default != null then { inherit default; } else {})
      // (if example != null then { inherit example; } else {}));

  # Create a boolean option with default false
  # Example: mkEnableOption "feature"
  mkEnableOption = feature:
    lib.mkEnableOption feature;

  # Create a string option
  # Example: mkStrOption { default = "value"; description = "..."; }
  mkStrOption = { default ? "", description ? "", ... }@args:
    lib.mkOption {
      type = lib.types.str;
      inherit default description;
    };

  # Create a list option
  # Example: mkListOption { default = []; description = "..."; }
  mkListOption = { type ? lib.types.str, default ? [], description ? "", ... }@args:
    lib.mkOption {
      type = lib.types.listOf type;
      inherit default description;
    };

  # Create an attribute set option
  # Example: mkAttrsOption { default = {}; description = "..."; }
  mkAttrsOption = { type ? lib.types.str, default ? {}, description ? "", ... }@args:
    lib.mkOption {
      type = lib.types.attrsOf type;
      inherit default description;
    };

  # Create a package option
  # Example: mkPackageOption pkgs.hello { description = "..."; }
  mkPackageOption = defaultPackage: { description ? "", ... }@args:
    lib.mkOption {
      type = lib.types.package;
      default = defaultPackage;
      inherit description;
    };

  # Create a nullable option
  # Example: mkNullableOption lib.types.str { description = "..."; }
  mkNullableOption = type: { default ? null, description ? "", ... }@args:
    lib.mkOption {
      type = lib.types.nullOr type;
      inherit default description;
    };

  # Merge multiple modules
  # Example: mergeModules [module1 module2]
  mergeModules = modules:
    { lib, config, pkgs, ... }:
    lib.foldl' (acc: mod: lib.recursiveUpdate acc mod) {} 
      (map (m: m { inherit lib config pkgs; }) modules);

  # Create a submodule
  # Example: mkSubmodule { options = ...; }
  mkSubmodule = { options, ... }@args:
    lib.types.submodule {
      inherit options;
    };

  # Apply module to configuration
  # Example: applyModule module config
  applyModule = module: config:
    let
      evaluated = lib.evalModules {
        modules = [ module config ];
      };
    in
      evaluated.config;

  # Create a module with conditional config
  # Example: mkConditionalModule { condition = config.enable; config = { ... }; }
  mkConditionalModule = { condition, config, ... }:
    lib.mkIf condition config;

  # Create module assertions
  # Example: mkAssertion { assertion = condition; message = "error message"; }
  mkAssertion = { assertion, message }:
    {
      assertions = [
        { inherit assertion message; }
      ];
    };
}
