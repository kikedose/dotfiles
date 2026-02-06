# .dotfiles
**archlinux** on WLS(2) and Alacritty setup.
February 2026.

Config for Neovim as a default editor.
Fallback config for Vim (plugins commented).

TODO: automate installs in a script


## Set up WSL
Check distro list and install archlinux.
```powershell
#PowerShell
wsl --list --online
wsl --install -d archlinux
```

Run archlinux on Windows Terminal -assuming it's already installed.
Initialize keyring and update system.
```bash
pacman-key --init
pacman-key --populate archlinux
pacman -Syu
```

Create a proper user; arch boots as root.
```bash
pacman -S sudo
useradd -m -G wheel -s /bin/bash your_username
passwd your_username
```

Install NeoVim and authorize your user to execute sudo commands.
```bash
sudo pacman -S nvim
EDITOR=nvim visudo
```
Uncomment this line `%wheel ALL=(ALL:ALL) ALL`, then save and quit `:wq`.

Terminate archlinux from PowerShell.
```powershell
wsl --terminate archlinux
```

Let's boot archlinux, and set your default user.
```bash
sudo nvim /etc/wsl.conf
```

Add the section below,
```
[user]
default = your_username
```
save and quit `:wq`.

Lastly, shotdown archlinux from the PowerShell.
```powershell
wsl --shutdown
```

## Locales
We need to enable UTF-8 to allow the input of special characters within the CLI.

Uncomment the desired locales from your locale list.
```bash
sudo nvim /etc/locale.gen
# en_US.UTF-8 UTF-8
```

Generate the locales.
```bash
sudo locale-gen
```

Watch the output, and check:
```
locale -a
```

You must see your desired locales there.


## Set up the environment

Install all the utilities.
```bash
sudo pacman -S zsh unzip tmux htop neovim curl wget bat ripgrep fd zoxide fzf fastfetch
```

Install OhMyZsh, and set `zsh` as the default shell when prompted.
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
You can always manually set it with `chsh -s $(which zsh)`.

## Set up SSH agent for GitHub
```bash
sudo pacman -S openssh
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# copy the output for GitHub authentication:
cat ~/.ssh/id_ed25519.pub
```

## Set up AUR helper
```bash
mkdir ~/.builds && cd ~/.builds
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## Set up the clipboard
This will allow yanking and pasting from nvim into Windows and vice versa.
```bash
yay -S win32yank-bin

# sanity check
file /usr/bin/win32yank.exe
```

Let's make sure they get along. Edit the WSL config file,
```bash
sudo nvim /etc/wsl.conf
```
and add this section below.
```
[interop]
enabled = true
appendWindowsPath = true
```

Mandatory shutdown from the PowerShell.
```powershell
wsl --shutdown
```

Sometimes the registration that tells Linux the `.exe` files belong to windows get dropped. If at any point yanking stops working, manually re-register it to test if this is the issue; then shutdown WSL from the PowerShell.
```bash
# Note: If you get an "image busy" error, it's already registered, which is fine.
sudo sh -c 'echo :WSLInterop:M::MZ::/init:PF > /proc/sys/fs/binfmt_misc/register'
```


## Prepare bare repository
1. To avoid recursion problems, let's make sure our source repository ignores the folder where we'll clone it: `echo ".dotfiles" >> ~/.gitignore`.
2. Let's clone our dotfiles into a bare repository in a "dot" folder `git clone --bare git@github.com:kikedose/dotfiles.git ~/.dotfiles`.
3. Define the alias in the current shell scope: `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`. This alias will be included in our `.zshrc`.

If you forked this repo and plan to track your fork:
- Create your own empty repository on GitHub/GitLab/etc.
- Update the remote: `dotfiles remote set-url origin <your-git-repo-url>`.
- Verify the change with: `dotfiles remote -v`.

4. Checkout the actual content from the bare repository to your $HOME: `dotfiles checkout`.

The step above might fail with a message like:
```bash
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```
This is because your $HOME folder might already have some stock configuration files which would be overwritten by Git.
Re-run the checkout if you had problems.

5. Set the flag 'showUntrackedFiles' to 'no' on this specific (local) repository:
```bash
dotfiles config --local status.showUntrackedFiles no
```
This prevents `dotfiles status` to show untracked (unwanted) files in the $HOME directory.

From now on you can now type config commands to add and update your dotfiles:
```bash
dotfiles status
dotfiles add .zshrc
dotfiles commit -m "updated zsh config"
dotfiles push -u origin main
```

## Nvim Plugin Dependencies
Install `nvm` (Node Version Manager).
```bash
sudo pacman -S nvm
```
Our `.zshrc` should already have the PATH configs for nvm. If not, add the install output manually.
Source the config file.
```bash
source ~/.zshrc
```

Install `node` and enable `pnpm`.
```bash
nvm install --lts
corepack enable
```

TreeSitter's Nvim adapter requires a C compiler plus some dependencies (breaking changes from laterst version):
```bash
sudo pacman -S clang llvm tree-sitter tree-sitter-cli
```
Check `tar` and `curl` are indeed installed.

## NerdFont
Download the [JetBrains Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip) patched font family on Windows. Install the "MONO" variants, since we will be using them exclusively from the terminal (Alacritty).

## Alacritty
Download the [Alacritty](https://alacritty.org/) `.msi` installer and proceed with the installation.
It won't create a config file, but it will look for one at `%APPDATA%\alacritty\alacritty.toml`. Either create it manually from the windows explorer, or via PowerShell:
```powershell
ni "$env:APPDATA\alacritty\alacritty.toml" -f
```
Then edit the file and paste our [config](https://github.com/kikedose/dotfiles/blob/main/.config/alacritty/alacritty.toml).
```powershell
winget install Microsoft.Edit
edit "$env:APPDATA\alacritty\alacritty.toml"
```
Uncomment the bottom `[terminal.shell]` section.
```toml
[terminal.shell]
# WSL
program = "C:\\Windows\\system32\\wsl.exe"
args = ["--cd", "~"]
```

## .gitconfig

Add your email and user name to your gitconfig.
```git
[alias]
  ladog = log --all --decorate --oneline --graph
[init]
  defaultBranch = main
[user]
  email = your.email@address.com
  name = John Salchichón
```
