{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    static-web-server
    android-tools
    scrcpy
    pass
    gnupg
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  services.tailscale.enable = true;
  services.openssh = {
    enable = true;
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding yes
      AuthenticationMethods publickey
    '';
  };

  system.primaryUser = "alex";
  users.users.alex = {
    home = "/Users/alex";
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGuOHwF1mi4zlUyda/hmrPEzfsgIGkNHCdBCPkhKjX37 root@e09e96d04e05"
    ];
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
      "firefox"
      "obs"
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
