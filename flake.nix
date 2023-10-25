{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixpkgs-unstable";
  };

  outputs = {nixpkgs, ...}: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    revealjs =
      # nix run nixpkgs#nurl -- https://github.com/hakimel/reveal.js 4.6.1
      pkgs.fetchFromGitHub {
        owner = "hakimel";
        repo = "reveal.js";
        rev = "4.6.1";
        hash = "sha256-R599Zdw9YzID7CRzWRcasz+ZZvZiagBFsuDWUvnNX4o=";
      };
  in {
    packages.x86_64-linux = rec {
      presentation = pkgs.runCommand "intro-presentation" {} ''
        mkdir $out
        ln -s ${revealjs} $out/reveal.js
        cp ${./index.html} $out/index.html
      '';
      default = presentation;
    };
  };
}
