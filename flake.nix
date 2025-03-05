{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
  flake-parts.lib.mkFlake { inherit inputs; } ({...}: {
    systems = [
      "aarch64-darwin"
      # TODO more
    ];

    perSystem = { pkgs, ...}: rec {
      packages =
        let
          translations = builtins.attrNames (builtins.fromJSON (builtins.readFile ./translations.json));
        in
        (pkgs.lib.genAttrs translations (name: pkgs.callPackage ./package.nix { withTranslation = name; }))
        // { default = packages.kjv; };
    };
  });
}
