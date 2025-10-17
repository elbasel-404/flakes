{ lib }:

{
  # Convert a string to uppercase
  # Example: toUpper "hello" => "HELLO"
  toUpper = str: lib.toUpper str;

  # Convert a string to lowercase  
  # Example: toLower "HELLO" => "hello"
  toLower = str: lib.toLower str;

  # Capitalize first letter of a string
  # Example: capitalize "hello" => "Hello"
  capitalize = str:
    if str == "" then ""
    else lib.toUpper (lib.substring 0 1 str) + lib.substring 1 (lib.stringLength str) str;

  # Check if string starts with a prefix
  # Example: hasPrefix "hello" "hello world" => true
  hasPrefix = prefix: str: lib.hasPrefix prefix str;

  # Check if string ends with a suffix
  # Example: hasSuffix "world" "hello world" => true
  hasSuffix = suffix: str: lib.hasSuffix suffix str;

  # Remove whitespace from both ends of a string
  # Example: trim "  hello  " => "hello"
  trim = str: lib.removeSuffix " " (lib.removePrefix " " str);

  # Split string by delimiter
  # Example: split "," "a,b,c" => ["a" "b" "c"]
  split = delimiter: str: lib.splitString delimiter str;

  # Join list of strings with delimiter
  # Example: join "," ["a" "b" "c"] => "a,b,c"
  join = delimiter: list: lib.concatStringsSep delimiter list;

  # Replace all occurrences of a pattern in a string
  # Example: replace "o" "0" "hello" => "hell0"
  replace = pattern: replacement: str:
    lib.concatStringsSep replacement (lib.splitString pattern str);

  # Convert camelCase to kebab-case
  # Example: camelToKebab "helloWorld" => "hello-world"
  camelToKebab = str:
    lib.toLower (lib.concatStrings (lib.mapAttrsToList
      (i: c: if c == lib.toUpper c && i != "0" then "-${lib.toLower c}" else lib.toLower c)
      (lib.imap0 (i: c: c) (lib.stringToCharacters str))));
}
