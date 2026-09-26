{ inputs, pkgs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.nixosModules.default
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };
    plugins = {
      calculator.enable = true;
      nixPackageRunner.enable = true;
      activateLinux.enable = true;
      dankscale.enable = true;
      systemMonitorPlus.enable = true;
    };
  };

  home.packages = [ pkgs.dsearch ];

  /*
    {
      "currentThemeName": "dynamic",
      "currentThemeCategory": "dynamic",
      "customThemeFile": "/home/peter/.config/DankMaterialShell/themes/peaceAndQuiet/theme.json",
      "registryThemeVariants": {
        "amoledBlack": {
          "dark": {
            "flavor": "black",
            "accent": "blue"
          }
        },
        "peaceAndQuiet": "blue"
      },
      "matugenScheme": "scheme-rainbow",
      "popupTransparency": 0.7,
      "widgetColorMode": "colorful",
      "cornerRadius": 18,
      "clockFormat": "24h",
      "animationSpeed": 3,
      "syncComponentAnimationSpeeds": false,
      "popoutAnimationSpeed": 3,
      "modalAnimationSpeed": 3,
      "springBounce": 2,
      "animationVariant": 2,
      "motionEffect": 2,
      "m3ElevationIntensity": 18,
      "m3ElevationOpacity": 40,
      "blurEnabled": true,
      "blurLayerOutlineOpacity": 0,
      "blurBorderEnabled": false,
      "blurWallpaperOnOverview": true,
      "systemTrayIconTintSaturation": 0,
      "controlCenterShowMicPercent": true,
      "controlCenterWidgets": [
        {
          "id": "volumeSlider",
          "enabled": true,
          "width": 50
        },
        {
          "id": "brightnessSlider",
          "enabled": true,
          "width": 50
        },
        {
          "id": "wifi",
          "enabled": true,
          "width": 50
        },
        {
          "id": "bluetooth",
          "enabled": true,
          "width": 50
        },
        {
          "id": "audioOutput",
          "enabled": true,
          "width": 50
        },
        {
          "id": "audioInput",
          "enabled": true,
          "width": 50
        },
        {
          "id": "nightMode",
          "enabled": true,
          "width": 50
        },
        {
          "id": "builtin_vpn",
          "enabled": true,
          "width": 50
        }
      ],
      "showWorkspaceApps": true,
      "appIdSubstitutions": [],
      "greeterWallpaperPath": "/home/peter/Pictures/nix-dark.png",
      "niriOverviewLauncherStyle": "spotlight",
      "useAutoLocation": true,
      "networkPreference": "wifi",
      "iconThemeDark": "Adwaita",
      "cursorSettings": {
        "theme": "Bibata-Modern-Classic",
        "size": 24,
        "niri": {
          "hideWhenTyping": false,
          "hideAfterInactiveMs": 0
        },
        "hyprland": {
          "hideOnKeyPress": false,
          "hideOnTouch": false,
          "inactiveTimeout": 0
        },
        "dwl": {
          "cursorHideTimeout": 0
        }
      },
      "monoFontFamily": "JetBrainsMono Nerd Font Mono",
      "batteryNotifyLow": true,
      "matugenTemplateKitty": false,
      "matugenTemplateZed": false,
      "dockGroupByApp": true,
      "dockIsolateDisplays": true,
      "dockLauncherLogoMode": "os",
      "notificationAnimationSpeed": 3,
      "dankIslandFloating": true,
      "dankIslandInteractionMode": "click",
      "dankIslandHomeCompactTight": true,
      "osdAlwaysShowValue": true,
      "osdPowerProfileEnabled": true,
      "screenPreferences": {
        "wallpaper": [
          "all"
        ]
      },
      "displayProfiles": {
        "niri": {
          "profile_1784549564994_yqqpkm": {
            "id": "profile_1784549564994_yqqpkm",
            "name": "Powersave",
            "outputSet": [
              "eDP-1"
            ],
            "createdAt": 1784549564994,
            "updatedAt": 1784549564994
          },
          "profile_1784584027797_umfyig": {
            "id": "profile_1784584027797_umfyig",
            "name": "Normal",
            "outputSet": [
              "eDP-1"
            ],
            "createdAt": 1784584027797,
            "updatedAt": 1784584027797
          }
        }
      },
      "barConfigs": [
        {
          "id": "default",
          "name": "Main Bar",
          "enabled": true,
          "position": 0,
          "screenPreferences": [
            "all"
          ],
          "showOnLastDisplay": true,
          "leftWidgets": [
            {
              "id": "launcherButton",
              "enabled": false
            },
            "workspaceSwitcher",
            {
              "id": "systemTray",
              "enabled": true,
              "trayUseInlineExpansion": true
            }
          ],
          "centerWidgets": [
            {
              "id": "music",
              "enabled": true,
              "mediaSize": 0
            },
            {
              "id": "clock",
              "enabled": true,
              "clockCompactMode": false
            },
            "notificationButton"
          ],
          "rightWidgets": [
            {
              "id": "dankscale",
              "enabled": true
            },
            {
              "id": "systemMonitorPlus",
              "enabled": true
            },
            {
              "id": "battery",
              "enabled": true,
              "showBatteryPercent": true,
              "showBatteryPercentOnlyOnBattery": false,
              "showBatteryTime": false,
              "showBatteryTimeOnlyOnBattery": false,
              "batteryPillPercentSign": true,
              "batteryStyle": "solid"
            },
            "controlCenterButton"
          ],
          "spacing": 4,
          "innerPadding": 4,
          "bottomGap": 0,
          "transparency": 0.15,
          "widgetTransparency": 0.5,
          "squareCorners": false,
          "noBackground": false,
          "maximizeWidgetIcons": false,
          "maximizeWidgetText": false,
          "removeWidgetPadding": false,
          "widgetPadding": 8,
          "gothCornersEnabled": false,
          "gothCornerRadiusOverride": false,
          "gothCornerRadiusValue": 12,
          "borderEnabled": false,
          "borderColor": "surfaceText",
          "borderOpacity": 0.39,
          "borderThickness": 1,
          "widgetOutlineEnabled": false,
          "widgetOutlineColor": "primary",
          "widgetOutlineOpacity": 0.68,
          "widgetOutlineThickness": 1,
          "fontScale": 1,
          "iconScale": 1,
          "autoHide": true,
          "autoHideDelay": 250,
          "showOnWindowsOpen": true,
          "openOnOverview": true,
          "visible": true,
          "popupGapsAuto": true,
          "popupGapsManual": 4,
          "maximizeDetection": true,
          "scrollEnabled": true,
          "scrollXBehavior": "column",
          "scrollYBehavior": "workspace",
          "shadowIntensity": 0,
          "shadowOpacity": 60,
          "shadowColorMode": "surface",
          "shadowCustomColor": "#000000",
          "clickThrough": false,
          "autoHideStrict": true,
          "useOverlayLayer": false,
          "hoverPopouts": false,
          "attachToScreenEdge": false
        }
      ],
      "desktopClockCustomColor": {
        "r": 1,
        "g": 1,
        "b": 1,
        "a": 1,
        "hsvHue": -1,
        "hsvSaturation": 0,
        "hsvValue": 1,
        "hslHue": -1,
        "hslSaturation": 0,
        "hslLightness": 1,
        "valid": true
      },
      "systemMonitorCustomColor": {
        "r": 1,
        "g": 1,
        "b": 1,
        "a": 1,
        "hsvHue": -1,
        "hsvSaturation": 0,
        "hsvValue": 1,
        "hslHue": -1,
        "hslSaturation": 0,
        "hslLightness": 1,
        "valid": true
      },
      "desktopWidgetInstances": [
        {
          "id": "dw_1788793471751_3l5r4wh4l",
          "widgetType": "activateLinux",
          "name": "Activate Linux Watermark",
          "enabled": true,
          "config": {
            "displayPreferences": [
              "all"
            ],
            "showOnOverlay": false,
            "clickThrough": true,
            "syncPositionAcrossScreens": false,
            "watermarkOpacity": 100,
            "showOnOverview": false
          },
          "group": null
        }
      ],
      "builtInPluginSettings": {
        "dms_settings_search": {
          "trigger": "?"
        },
        "dms_clipboard_search": {
          "trigger": "cb"
        }
      },
      "frameThickness": 2,
      "frameOpacity": 0.6,
      "frameShowOnOverview": true,
      "frameBarInsetPadding": 2,
      "configVersion": 17
    }
  */
}
