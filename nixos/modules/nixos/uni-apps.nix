{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    p3x-onenote

    (anki.withAddons [
      pkgs.ankiAddons.review-heatmap
    ])

    jetbrains.idea-oss

    mysql-workbench

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
