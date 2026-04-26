{ pkgs, nixpkgs-unstable, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    static-web-server
    pass
    gnupg
  ];
    # Workaround for aarch64-darwin codesigning bug (nixpkgs#208951 / #507531):
  # fish binaries from the binary cache occasionally have invalid ad-hoc
  # signatures on Apple Silicon. Forcing a local rebuild ensures codesigning
  # is applied on this machine with a valid signature.
  nixpkgs.overlays = [
    (_final: prev: {
      fish = prev.fish.overrideAttrs (_old: {
        # Bust the cache key so fish is always built locally rather than
        # substituted from the binary cache where the signature may be stale.
        NIX_FORCE_LOCAL_REBUILD = "darwin-codesign-fix";
      });
    })
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
