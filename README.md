## catppuccin-gtk-flake

This repository packages Catppuccin GTK themes as a standalone Nix flake.

It is based on the upstream
[catppuccin/gtk](https://github.com/catppuccin/gtk) source tree, while adding
flake outputs for direct use from NixOS and Home Manager.

The original project documentation is still useful for understanding the theme
structure and build process. Usage and installation details are available in
[docs/USAGE.md](/docs/USAGE.md), and the codebase layout is described in
[docs/ARCHITECTURE.md](/docs/ARCHITECTURE.md).

## Nix flake output

This fork also exposes prebuilt Nix flake packages.

- `packages.<system>.default`: bundle of all Catppuccin GTK themes using the
  standard size and no extra tweaks
- `packages.<system>.bundled`: same as `default`
- `packages.<system>.catppuccin-<flavor>-<accent>-standard`: one theme variant

Example:

```nix
{
  inputs.catppuccin-gtk.url = "github:W4T4r/catppuccin-gtk-flake";

  outputs = { self, nixpkgs, catppuccin-gtk, ... }: let
    system = "x86_64-linux";
  in {
    homeConfigurations.me = ... {
      home.packages = [
        catppuccin-gtk.packages.${system}.default
      ];
    };
  };
}
```

&nbsp;

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>
<p align="center">Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
<p align="center"><a href="https://github.com/catppuccin/gtk/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=GPLv3&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a></p>
