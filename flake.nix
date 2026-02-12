{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
  flake-parts.lib.mkFlake { inherit inputs; } ({ lib, ...}: {
    imports = [ flake-parts.flakeModules.easyOverlay ];

    systems = lib.systems.flakeExposed;

    perSystem = { config, pkgs, ...}: {
      overlayAttrs = {
        bible = config.packages;
      };
      packages =
        let
          translations = builtins.attrNames (builtins.fromJSON (builtins.readFile ./translations.json));
        in
        (pkgs.lib.genAttrs translations (translation: pkgs.callPackage ./package.nix { inherit translation; }))
        // { default = config.packages.kjv; };
    };
  });
}
