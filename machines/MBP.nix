{ config, pkgs, lib, ... }: {

  # Declare the user that will be running `nix-darwin`.
  users.users.jan = {
    name = "jan";
    home = "/Users/jan";
  };

  # The platform the configuration will be used on.
  # If you're on an Intel system, replace with "x86_64-darwin"
  nixpkgs =
    {
      hostPlatform = "aarch64-darwin";
      config.allowUnfree = true;
    };

  # Security settings
  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ bash zsh ];
    systemPackages = with pkgs; [
      # raycast # Maybe save config to dotfiles
      iterm2
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "Meslo" ]; }) # Add font hack nerd font
  ];

  # Enable services
  services = {
    nix-daemon.enable = true;
    aerospace = {
      # Currently not working
      enable = false;
      settings = { };
    };
  };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
      userKeyMapping = [
        # From https://hidutil-generator.netlify.app/ and just convert 0x7.. hex to decimal
        {
          # Esc to Capslock
          "HIDKeyboardModifierMappingSrc" = 30064771113;
          "HIDKeyboardModifierMappingDst" = 30064771129;
        }
        {
          # Right CMD to right Option
          "HIDKeyboardModifierMappingSrc" = 30064771303;
          "HIDKeyboardModifierMappingDst" = 30064771302;
        }
        {
          # Right Option to right CMD
          "HIDKeyboardModifierMappingSrc" = 30064771302;
          "HIDKeyboardModifierMappingDst" = 30064771303;
        }
      ];
    };
    defaults = {
      CustomUserPreferences = {
        # Find custom user preferences with 'defaults find ...'
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            "64" = {
              enabled = false;
            };
          };
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        # Find more info with 'defaults find input'
        "com.apple.TextInputMenu" = {
          # Enables Keyboard Input Menu Switcher
          visible = 1;
        };
        # Specify the iterm preferences directory
        "com.googlecode.iterm2" =
          {
            PrefsCustomFolder = "~/nixconfig/applications/iTerm2/";
          };
        # Tell iTerm2 to use the custom preferences in the directory
        "com.googlecode.iterm2" = {
          LoadPrefsFromCustomFolder = true;
        };
      };

      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        "com.apple.keyboard.fnState" = true;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSWindowShouldDragOnGesture = true;
        NSNavPanelExpandedStateForSaveMode = true;
        NSDocumentSaveNewDocumentsToCloud = false;
      };

      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        NewWindowTarget = "Documents";
        FXPreferredViewStyle = "clmv";
        ShowPathbar = true;
      };

      loginwindow.GuestEnabled = false;

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        show-recents = false;
        mru-spaces = false;
        wvous-tr-corner = 12; # Hot corner top right notification center
        persistent-apps = [
          "${pkgs.iterm2}/Applications/iTerm2.app"
          "/Applications/Brave Browser.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
        ];
      };

      controlcenter = {
        BatteryShowPercentage = true;
        Bluetooth = true;
      };

      alf = {
        globalstate = 1;
      };
    };
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility. please read the changelog
  # before changing: `darwin-rebuild changelog`.
  system.stateVersion = 5;
}
