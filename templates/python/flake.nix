{
  description = "standard flake for python";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          (python3.withPackages (ps: with ps; [
            pip
            virtualenv
          ]))
          pyright
        ];
        shellHook = "echo 'python env loaded'";
      };
    };
}
