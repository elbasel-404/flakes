# Example: Using string manipulation utilities from the flakes library
{ flakes-lib }:

let
  inherit (flakes-lib.strings) 
    capitalize toUpper toLower 
    split join replace
    hasPrefix hasSuffix;
in
{
  # Capitalize a string
  example1 = capitalize "hello world";  # => "Hello world"

  # Convert to uppercase
  example2 = toUpper "hello";  # => "HELLO"

  # Split and join
  example3 = 
    let
      parts = split "," "apple,banana,cherry";  # => ["apple" "banana" "cherry"]
    in
      join " | " parts;  # => "apple | banana | cherry"

  # Replace patterns
  example4 = replace "old" "new" "old text with old words";  # => "new text with new words"

  # Check prefixes and suffixes
  example5 = hasPrefix "hello" "hello world";  # => true
  example6 = hasSuffix ".nix" "file.nix";  # => true
}
