# dotfiles

## New Mac

1. Install Homebrew (it also installs the Xcode Command Line Tools, which provide `git`):

   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

2. Clone this repo to `~/Documents/repos/dotfiles`.

3. Install packages and apps from the `Brewfile`:

   ```sh
   brew bundle
   ```

4. Link the config files and install Node (LTS) and `ni`:

   ```sh
   ./install.sh
   ```

5. Import Raycast settings from the `.rayconfig` in `raycast/`.
