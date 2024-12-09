{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    selfup = {
      url = "github:kachick/selfup/v1.1.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      selfup,
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            buildInputs =
              (with pkgs; [
                bashInteractive
                findutils # xargs
                nixfmt-rfc-style
                nil
                go-task
                coreutils
                gnugrep

                powershell
                fzf

                dprint
                typos
              ])
              ++ [ selfup.packages.${system}.default ];
          };
        }
      );
    };
}
