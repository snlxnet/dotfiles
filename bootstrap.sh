echo -ne "
____ ____ ___ _  _ ____ _  _    ___  ____ ____ ___ ____ ___ ____ ____ ___
[__  |__|  |  |  | |__/ |\ |    |__] |  | |  |  |  [__   |  |__/ |__| |__]
___] |  |  |  |__| |  \ | \|    |__] |__| |__|  |  ___]  |  |  \ |  | |

"

echo "Installing NIX"
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "run zsh setup-nix-darwin.sh after a reboot"
