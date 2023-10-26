{
  inputs.nixpkgs.url = "github:NixOs/nixpkgs";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system} = {
        isolation = builtins.derivation {
          name = "isolation";
          builder = "${pkgs.bash}/bin/bash";
          args = [
            (builtins.toFile "builder.sh" ''
              set -euox pipefail;
              mkdir "$out";
              env > "$out/env";
              ls /nix/store > "$out/visible-store";
            '')
          ];
          PATH = "${pkgs.coreutils}/bin";
          inherit system;
        };
        unworth = builtins.derivation {
          name = "unworth";
          builder = "${pkgs.bash}/bin/bash";
          args = [
            (builtins.toFile "builder.sh" ''
              exit 1
            '')
          ];
          inherit system;
        };
        sloth = builtins.derivation {
          name = "sloth";
          builder = "${pkgs.bash}/bin/bash";
          args = [
            (builtins.toFile "builder.sh" ''
              exit 0
            '')
          ];
          inherit system;
        };
      };
    };
}
