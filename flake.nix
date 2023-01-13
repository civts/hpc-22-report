{
  description = "VSCode, beacause of ";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      in
      {
        devShell =
          with pkgs; mkShell rec {
            #needed because of https://stackoverflow.com/questions/69464001
            COMPOSE_COMPATIBILITY = true;
            buildInputs = [
              (vscode-with-extensions.override {
                vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                  {
                    name = "remote-containers";
                    vscodeExtName = "remote-containers";
                    publisher = "ms-vscode-remote";
                    vscodeExtPublisher = "ms-vscode-remote";
                    version = "0.266.1";
                    sha256 = "sha256-D0nwLKGojvvRuviGRI9zo4SZmpZgee7ZpHLWjUK3LWA=";
                  }
                  {
                    name = "nix-ide";
                    vscodeExtName = "nix-ide";
                    publisher = "jnoortheen";
                    vscodeExtPublisher = "jnoortheen";
                    version = "0.2.1";
                    sha256 = "sha256-yC4ybThMFA2ncGhp8BYD7IrwYiDU3226hewsRvJYKy4=";
                  }
                ];
              })
            ];
          };
      });
}
