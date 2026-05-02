sed -i '' "s/saturn/$(scutil --get LocalHostName)/" flake.nix

sudo mv /etc/bashrc /etc/bashrc.bak
sudo mv /etc/zshrc /etc/zshrc.bak # this has nix path though, so don't accidentally drop it
sudo nix run --extra-experimental-features "nix-command flakes" nix-darwin/nix-darwin-25.11#darwin-rebuild -- switch --flake .

