{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    static-web-server
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  programs.fish.enable = true;

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
    ];
  };
  system.defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    "com.apple.swipescrolldirection" = false;
  };

  # The do-not-touch section
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
