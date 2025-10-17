{ lib }:

{
  # String manipulation utilities
  strings = import ./strings.nix { inherit lib; };
  
  # List manipulation utilities
  lists = import ./lists.nix { inherit lib; };
  
  # Attribute set utilities
  attrsets = import ./attrsets.nix { inherit lib; };
  
  # File system utilities
  filesystem = import ./filesystem.nix { inherit lib; };
  
  # Package building helpers
  builders = import ./builders.nix { inherit lib; };
  
  # Module system helpers
  modules = import ./modules.nix { inherit lib; };
}
