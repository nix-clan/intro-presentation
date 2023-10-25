{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    another-flake = {
      url = "github:dev-null-undefined/ascii-art";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, another-flake, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages = pkgs.lib.recursiveUpdate
        {
          ${system}.mystic = import ./pkgs/mystic.nix pkgs;
        }
        another-flake.packages;
    };
}
