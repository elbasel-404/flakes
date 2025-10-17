{ lib }:

{
  # Get all attribute names from a set
  # Example: keys { a = 1; b = 2; } => ["a" "b"]
  keys = attrset: lib.attrNames attrset;

  # Get all values from a set
  # Example: values { a = 1; b = 2; } => [1 2]
  values = attrset: lib.attrValues attrset;

  # Check if attribute exists in set
  # Example: hasAttr "a" { a = 1; } => true
  hasAttr = name: attrset: lib.hasAttr name attrset;

  # Get attribute with default value if not present
  # Example: getAttr "a" 0 { b = 1; } => 0
  getAttr = name: default: attrset: attrset.${name} or default;

  # Map function over attribute values
  # Example: mapAttrs (n: v: v * 2) { a = 1; b = 2; } => { a = 2; b = 4; }
  mapAttrs = fn: attrset: lib.mapAttrs fn attrset;

  # Filter attribute set by predicate on name and value
  # Example: filterAttrs (n: v: v > 1) { a = 1; b = 2; c = 3; } => { b = 2; c = 3; }
  filterAttrs = predicate: attrset: lib.filterAttrs predicate attrset;

  # Merge two attribute sets (right overrides left)
  # Example: merge { a = 1; } { b = 2; } => { a = 1; b = 2; }
  merge = left: right: left // right;

  # Deep merge two attribute sets recursively
  # Example: deepMerge { a = { b = 1; }; } { a = { c = 2; }; } => { a = { b = 1; c = 2; }; }
  deepMerge = left: right: lib.recursiveUpdate left right;

  # Convert attribute set to list of name-value pairs
  # Example: toList { a = 1; b = 2; } => [{ name = "a"; value = 1; } { name = "b"; value = 2; }]
  toList = attrset: lib.mapAttrsToList (name: value: { inherit name value; }) attrset;

  # Convert list of name-value pairs to attribute set
  # Example: fromList [{ name = "a"; value = 1; }] => { a = 1; }
  fromList = list: lib.listToAttrs list;

  # Remove attributes from set
  # Example: removeAttrs ["a"] { a = 1; b = 2; } => { b = 2; }
  removeAttrs = names: attrset: lib.removeAttrs attrset names;

  # Select only specified attributes from set
  # Example: selectAttrs ["a"] { a = 1; b = 2; } => { a = 1; }
  selectAttrs = names: attrset: lib.getAttrs names attrset;

  # Rename attributes in a set
  # Example: renameAttrs { old = "new"; } { old = 1; } => { new = 1; }
  renameAttrs = mapping: attrset:
    lib.mapAttrs' (name: value:
      { name = mapping.${name} or name; value = value; }
    ) attrset;

  # Check if attribute set is empty
  # Example: isEmpty {} => true
  isEmpty = attrset: lib.length (lib.attrNames attrset) == 0;

  # Collect values from nested attribute sets by path
  # Example: collect ["a" "b"] { x = { a = { b = 1; }; }; y = { a = { b = 2; }; }; } => [1 2]
  collect = path: attrset:
    let
      getValue = attrs: lib.foldl (acc: key: acc.${key} or null) attrs path;
    in
      lib.filter (x: x != null) (lib.map getValue (lib.attrValues attrset));

  # Flatten nested attribute set with dot notation
  # Example: flatten { a = { b = 1; }; c = 2; } => { "a.b" = 1; c = 2; }
  flatten = attrset:
    lib.foldl (acc: { name, value }:
      if lib.isAttrs value && !lib.isDerivation value
      then acc // (lib.mapAttrs' (n: v: { name = "${name}.${n}"; value = v; }) (flatten value))
      else acc // { ${name} = value; }
    ) {} (toList attrset);
}
