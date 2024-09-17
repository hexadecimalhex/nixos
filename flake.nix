{
  outputs = inputs:
    let
      inherit (inputs) stable;
      systems = [ "x86_64-linux" ];
      eachSystem = f:
        stable.lib.genAttrs systems (system: f stable.legacyPackages.${system});
    in {
      nixosConfigurations = import ./hosts inputs;
      homeManagerModules = import ./common/homeManagerModules;
      nixosModules = import ./common/nixosModules;
      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [ nil nixfmt-classic treefmt ];
        };
      });
    };

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixprs.url = "github:mtlhrt/nixprs";
    nyanvim.url = "github:mtlhrt/nyanvim";
    quick-stack.url = "github:mtlhrt/quick-stack";
    patchy.url = "github:mtlhrt/patchy";

    swayfx.url = "github:willpower3309/swayfx";
    wayland.url = "github:nix-community/nixpkgs-wayland";
    lix = {
      url =
        "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
      inputs.nixpkgs.follows = "stable";
    };
    home = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "stable";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  nixConfig = rec {
    connect-timeout = 14;
    substituters = [
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://nix-community.cachix.org"
      "https://comfybyte.cachix.org"
    ];
    trusted-substituters = substituters;
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "comfybyte.cachix.org-1:MDOWRaQIVADC1iluO91OiGrC0gIG+iIe0koTGhYLycg="
    ];
  };
}
