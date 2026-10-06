{ inputs, pkgs, ... }:

let
  mkAwwwDaemon =
    namespace:
    let
      ns = if namespace != "" then " --namespace ${namespace}" else "";
    in
    {
      Unit = {
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        ExecStart = "${pkgs.awww}/bin/awww-daemon${ns}";
        Restart = "on-failure";
      };
    };
in
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.nixosModules.default
    inputs.dms-dcal.homeModules.default
  ];

  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };

    # to generate from the current dms settings, run:
    # DMS_SETTINGS_JSON=(dms ipc call settings dump) nix eval --impure --expr "builtins.fromJSON (builtins.getEnv \"DMS_SETTINGS_JSON\")"
    settings = {
      animationSpeed = 2;
      animationVariant = 2;
      appIdSubstitutions = [ ];
      barConfigs = [
        {
          attachToScreenEdge = false;
          autoHide = true;
          autoHideDelay = 250;
          autoHideStrict = true;
          borderColor = "surfaceText";
          borderEnabled = false;
          borderOpacity = 0.39;
          borderThickness = 1;
          bottomGap = 0;
          centerWidgets = [
            {
              enabled = true;
              id = "music";
              mediaSize = 0;
            }
            {
              clockCompactMode = false;
              enabled = true;
              id = "clock";
            }
            "notificationButton"
          ];
          clickThrough = false;
          enabled = true;
          fontScale = 1;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;
          gothCornersEnabled = false;
          hoverPopouts = false;
          iconScale = 1;
          id = "default";
          innerPadding = 4;
          leftWidgets = [
            {
              enabled = false;
              id = "launcherButton";
            }
            "workspaceSwitcher"
            {
              enabled = true;
              id = "systemTray";
              trayUseInlineExpansion = true;
            }
          ];
          maximizeDetection = true;
          maximizeWidgetIcons = false;
          maximizeWidgetText = false;
          name = "Main Bar";
          noBackground = false;
          openOnOverview = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
          position = 0;
          removeWidgetPadding = false;
          rightWidgets = [
            {
              enabled = true;
              id = "dankscale";
            }
            {
              enabled = true;
              id = "systemMonitorPlus";
            }
            {
              batteryPillPercentSign = true;
              batteryStyle = "solid";
              enabled = true;
              id = "battery";
              showBatteryPercent = true;
              showBatteryPercentOnlyOnBattery = false;
              showBatteryTime = false;
              showBatteryTimeOnlyOnBattery = false;
            }
            "controlCenterButton"
          ];
          screenPreferences = [ "all" ];
          scrollEnabled = true;
          scrollXBehavior = "column";
          scrollYBehavior = "workspace";
          shadowColorMode = "surface";
          shadowCustomColor = "#000000";
          shadowIntensity = 0;
          shadowOpacity = 60;
          showOnLastDisplay = true;
          showOnWindowsOpen = true;
          spacing = 4;
          squareCorners = false;
          transparency = 0.15;
          useOverlayLayer = false;
          visible = true;
          widgetOutlineColor = "primary";
          widgetOutlineEnabled = false;
          widgetOutlineOpacity = 0.68;
          widgetOutlineThickness = 1;
          widgetPadding = 8;
          widgetTransparency = 0.5;
        }
      ];
      batteryAutoPowerSaver = true;
      batteryNotifyChargeLimit = true;
      batteryNotifyLow = true;
      blurBorderEnabled = false;
      blurEnabled = true;
      blurLayerOutlineOpacity = 0;
      blurWallpaperOnOverview = true;
      builtInPluginSettings = {
        dms_clipboard_search = {
          trigger = "cb";
        };
        dms_settings_search = {
          trigger = "?";
        };
      };
      clockFormat = "24h";
      configVersion = 18;
      controlCenterShowMicPercent = true;
      controlCenterWidgets = [
        {
          enabled = true;
          id = "volumeSlider";
          width = 50;
        }
        {
          enabled = true;
          id = "brightnessSlider";
          width = 50;
        }
        {
          enabled = true;
          id = "wifi";
          width = 50;
        }
        {
          enabled = true;
          id = "bluetooth";
          width = 50;
        }
        {
          enabled = true;
          id = "audioOutput";
          width = 50;
        }
        {
          enabled = true;
          id = "audioInput";
          width = 50;
        }
        {
          enabled = true;
          id = "nightMode";
          width = 50;
        }
        {
          enabled = true;
          id = "builtin_vpn";
          width = 50;
        }
      ];
      cornerRadius = 18;
      currentThemeCategory = "dynamic";
      currentThemeName = "dynamic";
      cursorSettings = {
        dwl = {
          cursorHideTimeout = 0;
        };
        hyprland = {
          hideOnKeyPress = false;
          hideOnTouch = false;
          inactiveTimeout = 0;
        };
        niri = {
          hideAfterInactiveMs = 0;
          hideWhenTyping = false;
        };
        size = 24;
        theme = "Bibata-Modern-Classic";
      };
      customThemeFile = "/home/peter/.config/DankMaterialShell/themes/peaceAndQuiet/theme.json";
      dashTabs = [
        {
          enabled = true;
          id = "overview";
        }
        {
          enabled = true;
          id = "media";
        }
        {
          enabled = false;
          id = "wallpaper";
        }
        {
          enabled = true;
          id = "weather";
        }
        {
          enabled = true;
          id = "settings";
        }
      ];
      desktopClockCustomColor = {
        a = 1;
        b = 1;
        g = 1;
        hslHue = -1;
        hslLightness = 1;
        hslSaturation = 0;
        hsvHue = -1;
        hsvSaturation = 0;
        hsvValue = 1;
        r = 1;
        valid = true;
      };
      desktopWidgetInstances = [
        {
          config = {
            clickThrough = true;
            displayPreferences = [ "all" ];
            showOnOverlay = false;
            showOnOverview = false;
            syncPositionAcrossScreens = false;
            watermarkOpacity = 100;
          };
          enabled = true;
          group = null;
          id = "dw_1788793471751_3l5r4wh4l";
          name = "Activate Linux Watermark";
          widgetType = "activateLinux";
        }
      ];
      displayProfileAutoSelect = true;
      dockGroupByApp = true;
      dockIsolateDisplays = true;
      dockLauncherLogoMode = "os";
      frameBarInsetPadding = 2;
      frameOpacity = 0.6;
      frameShowOnOverview = true;
      frameThickness = 2;
      greeterWallpaperPath = "/home/peter/Projects/personal/dotfiles/nixos/wallpapers/greeter.png";
      iconThemeDark = "Adwaita";
      lockScreenWallpaperPath = "/home/peter/Projects/personal/dotfiles/nixos/wallpapers/greeter.png";
      m3ElevationIntensity = 18;
      m3ElevationOpacity = 40;
      matugenScheme = "scheme-rainbow";
      matugenTemplateKitty = false;
      matugenTemplateZed = false;
      modalAnimationSpeed = 2;
      monoFontFamily = "JetBrainsMono Nerd Font Mono";
      motionEffect = 2;
      networkPreference = "wifi";
      niriOverviewLauncherStyle = "spotlight";
      notificationAnimationSpeed = 3;
      osdAlwaysShowValue = true;
      osdPowerProfileEnabled = true;
      popoutAnimationSpeed = 2;
      popupTransparency = 0.7;
      registryThemeVariants = {
        amoledBlack = {
          dark = {
            accent = "blue";
            flavor = "black";
          };
        };
        peaceAndQuiet = "blue";
      };
      screenPreferences = {
        wallpaper = [ ];
      };
      showWorkspaceApps = true;
      springBounce = 2;
      syncComponentAnimationSpeeds = false;
      systemMonitorCustomColor = {
        a = 1;
        b = 1;
        g = 1;
        hslHue = -1;
        hslLightness = 1;
        hslSaturation = 0;
        hsvHue = -1;
        hsvSaturation = 0;
        hsvValue = 1;
        r = 1;
        valid = true;
      };
      systemTrayIconTintSaturation = 0;
      useAutoLocation = true;
      widgetColorMode = "colorful";
    };

    # may need to go to settings and hit scan in the plugins tab for the plugins to be loaded
    # to get the new plugin settings, run:
    # DMS_PLUGIN_SETTINGS_JSON=(cat ~/.config/DankMaterialShell/plugin_settings.json) nix eval --impure --expr "builtins.fromJSON (builtins.getEnv \"DMS_PLUGIN_SETTINGS_JSON\")"
    managePluginSettings = true;
    plugins = {
      calculator = {
        enable = true;
        settings = {
          calcEngine = "qalc";
          enabled = true;
          trigger = "=";
        };
      };
      dankscale = {
        enable = true;
        settings = {
          enabled = true;
          lastAccount = "Peanutt42@github";
        };
      };
      nixPackageRunner = {
        enable = true;
        settings = {
          enabled = true;
        };
      };
      systemMonitorPlus = {
        enable = true;
        settings = {
          enabled = true;
          cpuTempEnabled = true;
          cpuUsageVisualStyle = "gauge";
          diskPartitionUsageEnabled = true;
          diskPartitionUsageVisualStyle = "gauge";
          ramUsageEnabled = true;
          ramUsageTextMode = "value";
          ramUsageVisualStyle = "gauge";
        };
      };
    };
  };

  programs.dank-calendar = {
    enable = true;
    systemd.enable = true;
    # to get the new dank-calendar settings, run:
    # DCAL_SETTINGS_JSON=(cat ~/.config/dankcal/ui-settings.json) nix eval --impure --expr "builtins.fromJSON (builtins.getEnv \"DCAL_SETTINGS_JSON\")"
    settings = {
      allDayReminderDaysBefore = 0;
      allDayReminderTime = "09:00";
      allDayReminders = false;
      animationDuration = 250;
      closeBehavior = "minimize";
      colorSource = "auto";
      coreHoursEnabled = false;
      coreHoursEnd = 17;
      coreHoursStart = 9;
      customThemeFile = "";
      defaultCalendarId = "";
      defaultEventDurationMinutes = 30;
      defaultReminderMinutes = 10;
      dismissedAccountNotices = [ ];
      enableRippleEffects = true;
      firstDayOfWeek = -1;
      focusRingColor = "primary";
      focusRingEnabled = true;
      focusRingWidth = 1.5;
      fontScale = 1;
      fontWeight = 400;
      language = "";
      lastView = "week";
      monthEventTitleLines = 1;
      monthShowAllEvents = false;
      notificationSounds = true;
      presetTheme = "purple";
      radiusStrength = 50;
      reduceMotion = false;
      reminderPersist = true;
      remindersEnabled = true;
      showTasks = true;
      showTrayIcon = true;
      showWeekNumbers = false;
      sidebarCollapsed = false;
      sidebarWidth = 240;
      snoozeMinutes = 5;
      springBounce = 2;
      syncIntervalMinutes = 15;
      themeMode = "auto";
      timeFormat = "24h";
      timeLocale = "";
      use24HourClock = true;
      weekEventTitleLines = 1;
    };
  };

  home.packages = with pkgs; [
    dsearch
    awww
  ];

  systemd.user.services.awww-daemon = mkAwwwDaemon "";
  systemd.user.services.awww-backdrop = mkAwwwDaemon "backdrop";
}
