{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    p3x-onenote

    mattermost-desktop

    (anki.withAddons [
      pkgs.ankiAddons.review-heatmap
    ])

    jetbrains.idea-oss

    typst
    typstyle
    typst-live
    tinymist

    # haskell
    ghc
    cabal-install
    haskell-language-server
    hlint

    mysql-workbench

    renderdoc

    godot_4_7
    blender

    wireshark # gui

    # cisco anyconnect vpn: uni-ulm
    openconnect
    networkmanager-openconnect
    gp-saml-gui
  ];

  # configures wireshark-cli, the cli, not the qt gui
  programs.wireshark = {
    enable = true;
    usbmon.enable = true;
  };
}
