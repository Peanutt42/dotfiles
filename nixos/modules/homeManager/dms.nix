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

    # TEMPORARY!
    # should be removed once khal builds successfully when building its man pages
    enableCalendarEvents = false;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };

    # to generate from the current dms settings, run:
    # DMS_SETTINGS_JSON=(dms ipc call settings dump) nix eval --impure --expr "builtins.fromJSON (builtins.getEnv \"DMS_SETTINGS_JSON\")"
    settings = {
      animationDuration = 500;
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
          followInterfaceStyle = false;
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
            {
              enabled = true;
              id = "workspaceSwitcher";
              showWorkspaceApps = true;
            }
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
            {
              enabled = true;
              id = "controlCenterButton";
              showMicPercent = true;
            }
          ];
          screenPreferences = [ "all" ];
          scrollEnabled = true;
          scrollXBehavior = "focusWindow";
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
          widgetFollowInterfaceStyle = false;
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
      blurBorderSeeded = true;
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
      configVersion = 42;
      controlCenterWidgets = [
        {
          enabled = true;
          h = 1;
          id = "user";
          w = 5;
        }
        {
          enabled = true;
          h = 1;
          id = "settings";
          small = true;
          w = 1;
        }
        {
          enabled = true;
          h = 1;
          id = "lock";
          small = true;
          w = 1;
        }
        {
          enabled = true;
          h = 1;
          id = "power";
          small = true;
          w = 1;
        }
        {
          enabled = true;
          h = 1;
          id = "volumeSlider";
          w = 4;
        }
        {
          enabled = true;
          h = 1;
          id = "brightnessSlider";
          w = 4;
        }
        {
          enabled = true;
          h = 1;
          id = "wifi";
          w = 4;
        }
        {
          enabled = true;
          h = 1;
          id = "bluetooth";
          w = 4;
        }
        {
          enabled = true;
          h = 1;
          id = "audioOutput";
          w = 4;
        }
        {
          enabled = true;
          h = 1;
          id = "audioInput";
          w = 4;
        }
        {
          enabled = true;
          h = 1;
          id = "nightMode";
          w = 4;
        }
        {
          enabled = true;
          h = 1;
          id = "builtin_vpn";
          w = 4;
        }
        {
          enabled = true;
          h = 1;
          id = "edit";
          small = true;
          w = 1;
        }
        {
          col = 0;
          enabled = true;
          h = 1;
          id = "runningApps";
          row = 6;
          small = true;
          w = 4;
        }
      ];
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
      dmsWindowsFloatingSeeded = [ "niri" ];
      dockConfigs = [
        {
          autoHide = false;
          borderColor = "surfaceText";
          borderEnabled = false;
          borderOpacity = 1;
          borderThickness = 1;
          bottomGap = 0;
          editOnRightClick = false;
          enabled = false;
          followInterfaceStyle = false;
          groupByApp = true;
          iconSize = 40;
          id = "dock";
          indicatorStyle = "circle";
          isolateDisplays = true;
          itemSpacing = 4;
          launcherEnabled = false;
          launcherLogoBrightness = 0.5;
          launcherLogoColorOverride = "";
          launcherLogoContrast = 1;
          launcherLogoCustomPath = "";
          launcherLogoMode = "os";
          launcherLogoSizeOffset = 0;
          magnification = false;
          magnificationExpand = false;
          magnificationProfile = "parabolic";
          magnificationScale = 130;
          margin = 0;
          maxVisibleApps = 0;
          maxVisibleRunningApps = 0;
          mode = "compact";
          name = "Dock";
          openOnOverview = false;
          order = [ ];
          position = 1;
          restoreSpecialWorkspaceOnClick = false;
          screenPreferences = [ "all" ];
          separatePinnedAndRunningApps = false;
          showOnFullscreen = false;
          showOnLastDisplay = true;
          showOverflowBadge = true;
          showTrash = false;
          smartAutoHide = false;
          spacing = 4;
          taskbarAlign = "center";
          transparency = 1;
          trashCustomCommand = "";
          trashFileManager = "default";
          useOverlayLayer = false;
          widgetExpansion = "popout";
          widgets = [
            {
              enabled = true;
              id = "dock_launcher";
              widgetId = "dockLauncher";
            }
            {
              enabled = true;
              id = "dock_apps";
              widgetId = "appsDock";
            }
            {
              enabled = true;
              id = "dock_trash";
              widgetId = "dockTrash";
            }
          ];
        }
      ];
      frameBarInsetPadding = 2;
      frameShowOnOverview = true;
      frameThickness = 2;
      greeterWidgetInstances = [
        {
          config = {
            autoPosition = true;
            colorMode = "default";
            customColor = "#ffffff";
            displayPreferences = [ "all" ];
            showAnalogNumbers = false;
            showAnalogSeconds = true;
            showDate = false;
            showDigitalSeconds = false;
            style = "expressive";
            syncPositionAcrossScreens = true;
            transparency = 0;
            twoTone = true;
            weight = 0;
          };
          enabled = true;
          id = "lock_clock";
          widgetType = "desktopClock";
        }
        {
          config = {
            colorMode = "default";
            customColor = "#ffffff";
            displayPreferences = [ "all" ];
            format = "short";
            syncPositionAcrossScreens = true;
          };
          enabled = true;
          id = "lock_date";
          widgetType = "lockDate";
        }
        {
          config = {
            displayPreferences = [ "all" ];
            passwordVisibility = "always";
            profileVisibility = "always";
            style = "expressive";
            syncPositionAcrossScreens = true;
          };
          enabled = true;
          id = "lock_auth";
          widgetType = "lockAuth";
        }
        {
          config = {
            background = false;
            displayPreferences = [ "all" ];
            showMediaPlayer = true;
            showWeather = true;
            syncPositionAcrossScreens = true;
          };
          enabled = true;
          id = "lock_status";
          widgetType = "lockStatus";
        }
        {
          config = {
            displayPreferences = [ "all" ];
            shape = "round";
            syncPositionAcrossScreens = true;
          };
          enabled = true;
          id = "lock_power";
          widgetType = "lockPower";
        }
        {
          config = {
            displayPreferences = [ "all" ];
            syncPositionAcrossScreens = true;
          };
          enabled = true;
          id = "greeter_session";
          widgetType = "greeterSession";
        }
      ];
      iconThemeDark = "Adwaita";
      lockBeforeSuspend = true;
      lockScreenShowPowerActions = true;
      lockScreenWallpaperPath = "/home/peter/Projects/personal/dotfiles/nixos/wallpapers/greeter.png";
      lockScreenWidgetInstances = [
        {
          config = {
            autoPosition = true;
            colorMode = "default";
            customColor = "#ffffff";
            displayPreferences = [ "all" ];
            showAnalogNumbers = false;
            showAnalogSeconds = true;
            showDate = false;
            showDigitalSeconds = false;
            style = "expressive";
            syncPositionAcrossScreens = true;
            transparency = 0;
            twoTone = true;
            weight = 0;
          };
          enabled = true;
          id = "lock_clock";
          widgetType = "desktopClock";
        }
        {
          config = {
            colorMode = "default";
            customColor = "#ffffff";
            displayPreferences = [ "all" ];
            format = "short";
            syncPositionAcrossScreens = true;
          };
          enabled = true;
          id = "lock_date";
          widgetType = "lockDate";
        }
        {
          config = {
            displayPreferences = [ "all" ];
            passwordVisibility = "always";
            profileVisibility = "always";
            style = "expressive";
            syncPositionAcrossScreens = true;
          };
          enabled = true;
          id = "lock_auth";
          widgetType = "lockAuth";
        }
        {
          config = {
            displayPreferences = [ "all" ];
            mode = 2;
            syncPositionAcrossScreens = true;
          };
          enabled = true;
          id = "lock_notifications";
          widgetType = "lockNotifications";
        }
        {
          config = {
            background = false;
            displayPreferences = [ "all" ];
            showMediaPlayer = true;
            showWeather = true;
            syncPositionAcrossScreens = true;
          };
          enabled = true;
          id = "lock_status";
          widgetType = "lockStatus";
        }
        {
          config = {
            displayPreferences = [ "all" ];
            shape = "round";
            syncPositionAcrossScreens = true;
          };
          enabled = true;
          id = "lock_power";
          widgetType = "lockPower";
        }
      ];
      m3ElevationIntensity = 18;
      m3ElevationOpacity = 40;
      matugenScheme = "scheme-rainbow";
      matugenTemplateKitty = false;
      matugenTemplateZed = false;
      modalAnimationDuration = 300;
      monoFontFamily = "JetBrainsMono Nerd Font Mono";
      motionEffect = 2;
      networkPreference = "wifi";
      niriOverviewLauncherStyle = "spotlight";
      notificationAnimationDuration = 600;
      osdAlwaysShowValue = true;
      osdPowerProfileEnabled = true;
      popoutAnimationDuration = 300;
      popupTransparency = 0.7;
      radiusStrength = 56;
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
      springBounce = 2;
      syncComponentAnimationSpeeds = false;
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
