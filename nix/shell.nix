{
  pkgs ? import <nixpkgs> { },
}:
let
  llvm-pkgs-ver = "19";
in
pkgs.mkShell.override { stdenv = pkgs."llvmPackages_${llvm-pkgs-ver}".libcxxStdenv; } {
  # There is an open issue regarding building libc++ std module
  # with `FORTIFY_SOURCE` flag which is enabled by default
  #
  # See relevant issues:
  # https://github.com/llvm/llvm-project/issues/121709
  # https://nixos.wiki/wiki/C#Hardening_flags
  # https://nixos.org/manual/nixpkgs/stable/#fortify
  hardeningDisable = [ "fortify" ];

  nativeBuildInputs = [
    (pkgs."llvmPackages_${llvm-pkgs-ver}".clang-tools.override { enableLibcxx = true; })
    pkgs."llvmPackages_${llvm-pkgs-ver}".libcxxClang

    pkgs.cmake
    pkgs.ninja
    pkgs.ccache

    pkgs.doctest

    pkgs.pre-commit
    pkgs.cppcheck
    pkgs.cmake-format
    pkgs.cmake-lint
  ];

  shellHook = ''
    # workaround required for cmake to find clang manifest (allowing import std)
    # see https://github.com/NixOS/nixpkgs/issues/370217#issuecomment-2660926816
    NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -B${pkgs."llvmPackages_${llvm-pkgs-ver}".libcxxClang.libcxx}/lib";

    # pre-commit install
    ${pkgs.pre-commit}/bin/pre-commit install --allow-missing-config
  '';
}
