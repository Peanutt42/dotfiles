final: prev: {
  tmux = prev.tmux.overrideAttrs (oldAttrs: {
    src = final.fetchFromGitHub {
      owner = "Peanutt42";
      repo = "tmux";
      rev = "cb47b977097070397efc00b0f30588f928d87285"; # branch: win-slide-anim
      sha256 = "sha256-6PHEcmAMvjWateq6Au0ulS6lUjudK2anYDixTGdmA4E=";
    };
    version = "next-3.7";
  });
}
