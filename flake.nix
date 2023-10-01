{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    phppkgs.url = "github:fossar/nix-phps";
  };
  outputs = { self, nixpkgs, flake-utils, phppkgs, ... }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      phps = phppkgs.packages.${system};
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.curl
          pkgs.git
          pkgs.jq
          pkgs.wget
          phps.php74
          pkgs.phpactor
          pkgs.neovim
        ];
      };

      apps.default = {
        type = "app";
        program = "${pkgs.neovim}/bin/nvim";
      };
    });
  }
