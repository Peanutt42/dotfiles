{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:

buildGoModule {
  pname = "gwq";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "d-kuro";
    repo = "gwq";
    rev = "v0.1.1";
    hash = "sha256-MfCYFbODWnfPxx+6sLlcMT6tqghgILHB13+ccYqVjBA=";
  };

  vendorHash = "sha256-4K01Xf1EXl/NVX1loQ76l1bW8QglBAQdvlZSo7J4NPI=";

  doCheck = false;

  meta = {
    description = "Git worktree manager with fuzzy finder - Work on multiple branches simultaneously, perfect for parallel AI coding workflows";
    homepage = "https://github.com/d-kuro/gwq";
    license = lib.licenses.asl20;
    licenseFile = ./LICENSE;
    mainProgram = "gwq";
  };
}
