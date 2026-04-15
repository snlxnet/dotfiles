{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    static-web-server
    pass
    gnupg
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  system.primaryUser = "alex";
  users.users.alex = {
    home = "/Users/alex";
    shell = pkgs.fish;
  };

  system.defaults.dock = {
    autohide = true;
    orientation = "right";
    show-recents = false;
    mru-spaces = false;
    mineffect = "scale";
    persistent-apps = [
      { app = "/Applications/Safari.app"; }
      { app = "/Users/alex/Applications/Home Manager Apps/kitty.app"; }
    ];
  };
  system.defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    _HIHideMenuBar = true;
    "com.apple.swipescrolldirection" = false;
  };

  homebrew = {
    enable = true;
    taps = [ "LizardByte/homebrew" ]; # this has to be a separate build from the sunshine install
    brews = [
      "container"
      "container-compose"
      {
        name = "sunshine";
        restart_service = "changed";
      }
    ];
    casks = [
      "syncthing-app"
      "helium-browser"
      "blender"
      "inkscape"
      "prusaslicer"
      "libreoffice"
      "glide"
      "betterdisplay"
      "thunderbird"
      "handy"
      "blackhole-2ch"
      "utm"
    ];
  };

  # The do-not-touch section
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
