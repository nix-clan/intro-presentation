{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system} = {
        atlas-pa2-semestralka = import ./pkgs/mystic.nix pkgs;
      };
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          python3
          nixfmt
          (pkgs.writeShellScriptBin "foobar" ''
            echo 'Welcome to the FIT Nix meetup'
          '')
          (pkgs.writeShellScriptBin "my-old-python" ''
            ${pkgs.python38}/bin/python "$@"
          '')
          pkgs.hello.nativeBuildInputs
        ];
      };
    };
}
