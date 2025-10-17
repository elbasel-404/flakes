# Example: Using attribute set utilities from the flakes library
{ flakes-lib }:

let
  inherit (flakes-lib.attrsets)
    keys values hasAttr getAttr
    mapAttrs filterAttrs merge deepMerge
    toList fromList removeAttrs selectAttrs;
in
{
  # Get keys and values
  example1 = {
    allKeys = keys { a = 1; b = 2; c = 3; };  # => ["a" "b" "c"]
    allValues = values { a = 1; b = 2; c = 3; };  # => [1 2 3]
  };

  # Check and get attributes
  example2 = {
    exists = hasAttr "a" { a = 1; b = 2; };  # => true
    value = getAttr "x" 0 { y = 1; };  # => 0 (default value)
  };

  # Map over attribute set
  example3 = mapAttrs (name: value: value * 2) { a = 1; b = 2; };
  # => { a = 2; b = 4; }

  # Filter attribute set
  example4 = filterAttrs (name: value: value > 1) { a = 1; b = 2; c = 3; };
  # => { b = 2; c = 3; }

  # Merge attribute sets
  example5 = merge { a = 1; b = 2; } { b = 3; c = 4; };
  # => { a = 1; b = 3; c = 4; }

  # Deep merge (recursive)
  example6 = deepMerge 
    { a = { x = 1; y = 2; }; }
    { a = { y = 3; z = 4; }; };
  # => { a = { x = 1; y = 3; z = 4; }; }

  # Convert between list and attribute set
  example7 = {
    asList = toList { a = 1; b = 2; };
    # => [{ name = "a"; value = 1; } { name = "b"; value = 2; }]
    
    asAttrs = fromList [{ name = "a"; value = 1; } { name = "b"; value = 2; }];
    # => { a = 1; b = 2; }
  };

  # Select and remove attributes
  example8 = {
    selected = selectAttrs ["a" "c"] { a = 1; b = 2; c = 3; };  # => { a = 1; c = 3; }
    removed = removeAttrs ["b"] { a = 1; b = 2; c = 3; };  # => { a = 1; c = 3; }
  };
}
