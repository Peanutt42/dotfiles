{ pkgs, ... }:

{
  # automatic display brightnes control using the ambient light sensor
  environment.systemPackages = with pkgs; [
    wluma
    iio-sensor-proxy
  ];
  services.udev.packages = with pkgs; [
    wluma
    iio-sensor-proxy
  ];
  environment.etc."wluma/config.toml".text = ''
    	[als.iio]
    	path = "/sys/bus/iio/devices"

    	[output.backlight]
    	name = "eDP-1"
    	path = "/sys/class/backlight/amdgpu_bl1"
    	min_brightness = 5
  '';
  systemd.user.services.wluma = {
    description = "Automatic brightness control (wluma)";

    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = ''
        ${pkgs.wluma}/bin/wluma
      '';
      Restart = "on-failure";
      Environment = [
        # this will override the config.toml file, as wluma reads $XDG_CONFIG_HOME/wluma/config.toml
        "XDG_CONFIG_HOME=/home/peter/Projects/personal/dotfiles/nixos/hosts/framework-laptop/"
      ];
    };
  };
}
