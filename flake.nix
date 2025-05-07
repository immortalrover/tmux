{
  description = "My Nix packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    snowfall = {
      url = "github:snowfallorg/lib/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.snowfall.mkFlake {
      inherit inputs;
      src = ./.;

      overlay-package-namespace = "plusultra";

      alias.packages.default = "tmux";
    };
}
