{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      forAllSystems =
        function:
        lib.genAttrs lib.systems.flakeExposed (system: function nixpkgs.legacyPackages.${system});

      gtkFlavors = [
        "latte"
        "frappe"
        "macchiato"
        "mocha"
      ];

      gtkAccents = [
        "rosewater"
        "flamingo"
        "pink"
        "mauve"
        "red"
        "maroon"
        "peach"
        "yellow"
        "green"
        "teal"
        "sky"
        "sapphire"
        "blue"
        "lavender"
      ];

      themeName = flavor: accent: "catppuccin-${flavor}-${accent}-standard";

      themePackage = pkgs: flavor: accent:
        pkgs.catppuccin-gtk.override {
          variant = flavor;
          accents = [ accent ];
          size = "standard";
          tweaks = [ ];
        };

      themePackagesFor = pkgs:
        lib.listToAttrs (
          lib.concatMap (
            flavor:
            map (accent: {
              name = themeName flavor accent;
              value = themePackage pkgs flavor accent;
            }) gtkAccents
          ) gtkFlavors
        );
    in
    {
      packages = forAllSystems (
        pkgs:
        let
          themePackages = themePackagesFor pkgs;
        in
        themePackages
        // {
          bundled = pkgs.symlinkJoin {
            name = "catppuccin-gtk-themes";
            paths = builtins.attrValues themePackages;
          };
          default = pkgs.symlinkJoin {
            name = "catppuccin-gtk-themes";
            paths = builtins.attrValues themePackages;
          };
        }
      );

      devShells = forAllSystems (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });
    };
}
