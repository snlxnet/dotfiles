## Setting up saturn

Install NIX
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Homebrew
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Launch a new shell, get git and clone the repo
```shell
nix-shell -p git
git clone https://github.com/snlxnet/dotfiles
```

Make sure the hostname is set to saturn. If it's not, change it in settings & reboot.

Drop the default configs so they don't conflict with nix-darwin. Don't exit the shell after that.
If you do, nix won't be in your PATH.

```shell
sudo mv /etc/bashrc /etc/bashrc.bak
sudo mv /etc/zshrc /etc/zshrc.bak
```

Navigate to the repo again, comment out `sunshine` in `configuration.nix` and run:

```shell
sudo nix run --extra-experimental-features "nix-command flakes" nix-darwin/nix-darwin-25.11#darwin-rebuild -- switch --flake .
```

Run `fish`, uncomment `sunshine` and run `rebuild`. Install rosetta 2 and reboot:

```shell
softwareupdate --install-rosetta
reboot
```

Go to settings and enable `Switch to Desktop X` under Keyboard -> Keyboard shortcuts -> Mission Control.

Start Glide using Spotlight. Setup complete.
