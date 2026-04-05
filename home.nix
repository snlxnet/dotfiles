{ pkgs, ... }:

{
  home.username = "alex";
  
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "catppuccin_mocha";

      editor = {
        true-color = true;
        line-number = "relative";
        color-modes = true;
        indent-guides.render = false;
        lsp.display-inlay-hints = true;
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Alex";
      user.email = "alexanderthestudent@yandex.ru";

      # Based on https://www.codetinkerer.com/2023/10/01/stacked-branches-with-vanilla-git.html
      # Found it after remembering t3dotgg recommending graphite
      aliases = {
        hist = "rebase --keep-base master -i";
        next = "rebase --continue";
        ct = "commit -p";
        up = "push --force-with-lease";
      };

      # Based on https://blog.gitbutler.com/how-git-core-devs-configure-git/
      # Article recommended to me by arswarog
      init.defaultBranch = "main";
      pull.rebase = true;
      merge.conflictstyle = "zdiff3";
      commit.verbose = true;
      help.autocorrect = "prompt";
      column.ui = "auto";
      branch.sort = "-committerdate";
      feature.experimental = true;
      rebase = {
      	updateRefs = true;
      	autoSquash = true;
      	autoStash = true;
      };
      fetch = {
      	prune = true;
      	pruneTags = true;
      	all = true;
      };
      push = {
      	default = "simple";
      	autoSetupRemote = true;
      	followTags = true;
      };
      diff = {
      	colorMoved = "plain";
      	mnemonicPrefix = true;
      	renames = true;
      	algorithm = "histogram";
      };
    };
  };

  programs.lazygit = {
    enable = true;
    settings.notARepository = "quit";
    settings.disableStartupPopups = true;
    settings.gui.nerdFontsVersion = "3";
  };

  programs.bat = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.direnv.enable = true;

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings.theme = "catppuccin-mocha";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # disable it
    '';
    shellAbbrs = {
      cat = "bat";
      agent = "eval (ssh-agent -c)";
      rebuild = "sudo darwin-rebuild switch";
    };
  };

  programs.ripgrep.enable = true;

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };
  };

  home.stateVersion = "25.11";
}
