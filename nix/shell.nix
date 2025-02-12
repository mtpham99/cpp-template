{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell.override { stdenv = pkgs.llvmPackages.libcxxStdenv; } {
  # There is an open issue regarding building libc++ std module
  # with `FORTIFY_SOURCE` flag which is enabled by default
  #
  # See relevant issues:
  # https://github.com/llvm/llvm-project/issues/121709
  # https://nixos.wiki/wiki/C#Hardening_flags
  # https://nixos.org/manual/nixpkgs/stable/#fortify
  hardeningDisable = [ "fortify" ];

  nativeBuildInputs = [
    (pkgs.llvmPackages.clang-tools.override { enableLibcxx = true; })
    (pkgs.callPackage ./cmake-importstd-patched/package.nix { })
    pkgs.ninja
    pkgs.ccache

    pkgs.pre-commit
    pkgs.cppcheck
    pkgs.cmake-format
    pkgs.cmake-lint
  ];

  shellHook = ''
    # pre-commit install
    ${pkgs.pre-commit}/bin/pre-commit install
  '';
}
