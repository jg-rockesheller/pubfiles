{ pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    ghc
    haskell-language-server
    haskellPackages.ormolu
    haskellPackages.cabal-install
  ];
}
