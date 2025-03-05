{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
  flake-parts.lib.mkFlake { inherit inputs; } ({...}: {
    imports = [ flake-parts.flakeModules.easyOverlay ];

    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    perSystem = { config, pkgs, ...}: {
      overlayAttrs = {
        bible = config.packages;
      };
      packages =
        let
          translations = builtins.attrNames (builtins.fromJSON (builtins.readFile ./translations.json));
        in
        (pkgs.lib.genAttrs translations (name: pkgs.callPackage ./package.nix { withTranslation = name; }))
        // { default = config.packages.kjv; };
    };
  });
}
