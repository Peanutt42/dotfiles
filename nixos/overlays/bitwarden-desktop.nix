# overrides bitwarden-desktop to use prebuild electron 39 (EOL!)
# remove once bitwarden-desktop ships with non EOL electron so we dont build from source by default
final: prev: {
  bitwarden-desktop = prev.bitwarden-desktop.override {
    electron_39 = final.electron_39-bin;
  };
}
