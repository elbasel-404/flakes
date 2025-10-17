{ lib }:

{
  # Create a simple shell script package
  # Example: mkShellScript "hello" "echo hello" => <derivation>
  mkShellScript = name: text: pkgs:
    pkgs.writeShellScriptBin name text;

  # Create a Python script package
  # Example: mkPythonScript "hello" "print('hello')" => <derivation>
  mkPythonScript = name: text: pkgs:
    pkgs.writeScriptBin name ''
      #!${pkgs.python3}/bin/python3
      ${text}
    '';

  # Create a simple package from a directory
  # Example: mkPackageFromDir ./myapp
  mkPackageFromDir = dir: pkgs:
    pkgs.stdenv.mkDerivation {
      name = baseNameOf dir;
      src = dir;
      installPhase = ''
        mkdir -p $out
        cp -r * $out/
      '';
    };

  # Create a development shell with specific packages
  # Example: mkDevShell [pkgs.go pkgs.nodejs]
  mkDevShell = packages: pkgs:
    pkgs.mkShell {
      buildInputs = packages;
    };

  # Create a package with custom build phases
  # Example: mkCustomPackage { name = "myapp"; src = ./.; buildPhase = "..."; }
  mkCustomPackage = { name, src, buildPhase ? "", installPhase ? "", ... }@args: pkgs:
    pkgs.stdenv.mkDerivation ({
      inherit name src;
      buildPhase = buildPhase;
      installPhase = installPhase;
    } // args);

  # Wrap an existing package with additional environment variables
  # Example: wrapPackage pkgs.hello { MY_VAR = "value"; }
  wrapPackage = pkg: env: pkgs:
    pkgs.symlinkJoin {
      name = "${pkg.name}-wrapped";
      paths = [ pkg ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/* \
          ${lib.concatStringsSep " \\\n  " (lib.mapAttrsToList (k: v: "--set ${k} ${v}") env)}
      '';
    };

  # Create a simple static website package
  # Example: mkStaticSite ./website
  mkStaticSite = src: pkgs:
    pkgs.stdenv.mkDerivation {
      name = "static-site";
      inherit src;
      installPhase = ''
        mkdir -p $out
        cp -r * $out/
      '';
    };

  # Build a Docker image from a package
  # Example: mkDockerImage pkgs.hello { tag = "latest"; }
  mkDockerImage = pkg: { name ? pkg.name, tag ? "latest", ... }@args: pkgs:
    pkgs.dockerTools.buildImage ({
      inherit name tag;
      contents = [ pkg ];
    } // args);

  # Create a systemd service derivation
  # Example: mkSystemdService "myservice" { ExecStart = "/bin/myapp"; }
  mkSystemdService = name: config: {
    systemd.services.${name} = {
      description = "${name} service";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = config;
    };
  };

  # Fetch and build from Git repository
  # Example: mkFromGit { url = "https://github.com/user/repo"; rev = "main"; }
  mkFromGit = { url, rev, sha256 ? lib.fakeSha256, ... }@args: pkgs:
    let
      src = pkgs.fetchFromGitHub ({
        owner = lib.elemAt (lib.splitString "/" url) 3;
        repo = lib.elemAt (lib.splitString "/" url) 4;
        inherit rev sha256;
      } // args);
    in
      src;
}
