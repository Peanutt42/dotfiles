{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    opencode
    pi-coding-agent
  ];
}
