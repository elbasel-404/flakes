{ lib }:

{
  # List all files in a directory recursively
  # Example: listFiles ./src => [./src/a.nix ./src/b.nix ./src/sub/c.nix]
  listFiles = dir:
    let
      entries = lib.filesystem.listFilesRecursive dir;
    in
      entries;

  # List only .nix files in a directory recursively
  # Example: listNixFiles ./src => [./src/a.nix ./src/b.nix]
  listNixFiles = dir:
    lib.filter (path: lib.hasSuffix ".nix" (toString path))
      (lib.filesystem.listFilesRecursive dir);

  # Import all .nix files from a directory
  # Example: importAll ./modules => { module1 = <imported>; module2 = <imported>; }
  importAll = dir:
    let
      files = listNixFiles dir;
      getName = path:
        let
          base = baseNameOf path;
          name = lib.removeSuffix ".nix" base;
        in
          name;
    in
      lib.listToAttrs (lib.map (file: {
        name = getName file;
        value = import file;
      }) files);

  # Get the base name of a path (file name)
  # Example: baseName /path/to/file.nix => "file.nix"
  baseName = path: baseNameOf path;

  # Get the directory name of a path
  # Example: dirName /path/to/file.nix => "/path/to"
  dirName = path: dirOf path;

  # Get file extension
  # Example: extension "file.nix" => "nix"
  extension = path:
    let
      parts = lib.splitString "." (baseNameOf path);
    in
      if lib.length parts > 1
      then lib.last parts
      else "";

  # Remove file extension
  # Example: removeExtension "file.nix" => "file"
  removeExtension = path:
    let
      base = baseNameOf path;
      ext = extension path;
    in
      if ext != ""
      then lib.removeSuffix ".${ext}" base
      else base;

  # Check if path has specific extension
  # Example: hasExtension "nix" ./file.nix => true
  hasExtension = ext: path: lib.hasSuffix ".${ext}" (toString path);

  # Join path components
  # Example: joinPath ["/path" "to" "file.nix"] => "/path/to/file.nix"
  joinPath = components: lib.concatStringsSep "/" components;

  # Normalize path (remove redundant separators and dots)
  # Example: normalizePath "/path//to/./file.nix" => "/path/to/file.nix"
  normalizePath = path:
    let
      parts = lib.filter (x: x != "" && x != ".") (lib.splitString "/" path);
      isAbsolute = lib.hasPrefix "/" path;
    in
      (if isAbsolute then "/" else "") + lib.concatStringsSep "/" parts;

  # Get relative path from base to target
  # Example: relativePath "/a/b" "/a/b/c/d" => "c/d"
  relativePath = base: target:
    let
      baseParts = lib.splitString "/" base;
      targetParts = lib.splitString "/" target;
      commonPrefixLen = lib.length (lib.takeWhile (i: lib.elemAt baseParts i == lib.elemAt targetParts i)
        (lib.genList (i: i) (lib.length baseParts)));
      relative = lib.drop commonPrefixLen targetParts;
    in
      lib.concatStringsSep "/" relative;
}
