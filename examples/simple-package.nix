# Example: Creating a simple package using the flakes library
{ pkgs, flakes-lib }:

let
  # Using the builders from our library
  inherit (flakes-lib.builders) mkShellScript mkCustomPackage;
in
{
  # Create a simple hello world script
  hello-script = mkShellScript "hello" ''
    echo "Hello from flakes library!"
    echo "This is a simple shell script package."
  '' pkgs;

  # Create a custom package
  my-tool = mkCustomPackage {
    name = "my-tool";
    src = ./.;
    buildPhase = ''
      echo "Building my-tool..."
    '';
    installPhase = ''
      mkdir -p $out/bin
      echo '#!/bin/sh' > $out/bin/my-tool
      echo 'echo "My Tool v1.0"' >> $out/bin/my-tool
      chmod +x $out/bin/my-tool
    '';
  } pkgs;
}
