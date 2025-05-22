# .dotfiles
**Ubuntu v24.04** on WLS(2) and Windows Terminal.

Config for Neovim as a default editor.
Fallback to Vim (plugins commented).

## Set up Z shell
1. Fetch latest versions: `sudo apt update && sudo apt upgrade`.
2. Ensure **cURL** is installed: `curl --version`. If not, `sudo apt install curl`.
3. Ensure **git** (>2.4.11) is installed: `git --version`. If not, `sudo apt install git`.
4. Install **zsh**: `sudo apt install zsh`.
5. Verify installation: `zsh --version`.
6. Make zsh your default shell: `chsh -s $(which zsh)`.
7. Log out and back in again.
8. Test with `echo $SHELL`. Expected path: `/usr/bin/zsh` or similar.
9. Test with `$SHELL --version`. Expected result: `zsh 5.9` or newer.
10. Install **oh my zsh**: `sh -c "$(curl -fsSL https://install.ohmyz.sh/)"`.
11. Clone the syntax highlight plugin: `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`.

## Install Neovim
As of April 2025, `sudo apt install neovim` installs v^0.9, which conflicts with our configuration.
We need v^0.11.

1. If you previously installed nvim via apt, try `sudo apt upgrade neovim` and test with `nvim --version`.
If <0.11, uninstall with `sudo apt remove neovim`, remove leftovers with `sudo apt purge neovim` and clean up
with `sudo apt autoremove`.
2. Do install these dependencies: `sudo apt install xclip python3-pynvim`. They are not included in the build.
3. Download AppImage: `curl -LO https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.appimage`.
4. Make it executable: `chmod u+x nvim-linux-x86_64.appimage`.
5. Rename for convenience: `mv nvim-linux-x86_64.appimage nvim`.
6. Move to PATH: `sudo mv nvim /usr/local/bin/`.
7. Test with `nvim --version`. Expected result `NVIM v0.11.0`.
8. Create the undodir.

## Prepare bare repository
1. To avoid recursion problems, let's make sure our source repository ignores the folder where we'll clone it: `echo ".dotfiles" >> ~/.gitignore`.
2. Let's clone our dotfiles into a bare repository in a "dot" folder `git clone --bare git@github.com:kikedose/dotfiles.git ~/.dotfiles`.
3. Define the alias in the current shell scope: `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`. This alias should already be included in our `.zshrc`.

## Set up your own repo
If you forked this repo and plan to track your fork, skip to step 4.

1. Create your own empty repository on GitHub/GitLab/etc.
2. Update the remote: `dotfiles remote set-url origin <your-git-repo-url>`.
3. Verify the change with: `dotfiles remote -v`.
4. Checkout the actual content from the bare repository to your $HOME: `dotfiles checkout`.

The step above might fail with a message like:
```BASH
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```
This is because your $HOME folder might already have some stock configuration files which would be overwritten by Git. The solution is simple: back up the files if you care about them, remove them if you don't care.
Re-run the checkout if you had problems.

5. Set the flag 'showUntrackedFiles' to 'no' on this specific (local) repository: `dotfiles config --local status.showUntrackedFiles no`. This prevents `dotfiles status` to show untracked (unwanted) files in the $HOME directory.

From now on you can now type config commands to add and update your dotfiles:
```BASH
dotfiles status
dotfiles add .zshrc
dotfiles commit -m "updated zsh config"
dotfiles push -u origin main
```

## Set up clipboard
We want to prevent the system `ctrl-c` and `ctrl-v` from conflicting with Neovim's keybinds.
These are the relevant changes on the **Windows Terminal** JSON config file (note the trailing commas):
```JSON
{
    ...,
    "keybindings":
    [
        {
            "id": "User.paste",
            "keys": "ctrl+shift+v"
        },
        {
            "id": "User.copy.644BA8F2",
            "keys": "ctrl+shift+c"
        },
        ...
    ],
    ...
}
```

## Extras
- Install `nvm` (Node Version Manager).
- Install `tmux` (Terminal Multiplexer).
- Install utilities `tree, neofetch, bat, ripgrep, fzf, delta-git, fd`.
- Clone `fzf-git` into ~/.local/share/fzf-git/.

TODO: automate installs in a script

## .gitconfig
```GIT
[alias]
  ladog = log --all --decorate --oneline --graph
```
