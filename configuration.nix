{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    static-web-server
    pass
    gnupg
  ];

  # Necessary for using flakes on this system.
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
    orientation = "left";
    show-recents = false;
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
    brews = [
      "container"
      "container-compose"
    ];
    casks = [
      "syncthing-app"
      "helium-browser"
      "blender"
      "inkscape"
      "prusaslicer"
      "libreoffice"
      "glide"
      "handy"
      "blackhole-2ch"
    ];
  };

  # The do-not-touch section
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
