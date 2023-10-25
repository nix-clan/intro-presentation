{
  inputs = {
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nixpkgs.url = "github:NixOs/nixpkgs";
  };

  outputs = { self, nixpkgs, pre-commit-hooks, ... }:
    let system = "x86_64-linux"; in
    {
      checks.${system} = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
            shellcheck.enable = true;
          };
        };
      };
      devShell.${system} = nixpkgs.legacyPackages.${system}.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    };
}
