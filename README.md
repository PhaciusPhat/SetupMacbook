# Setup-Macbook

This repository contains a small macOS setup for a personal machine. It includes:

- `brew-setup.sh` — a script that installs Homebrew (if missing), updates it, and installs a curated list of formulae and casks.
- `.zshrc` — a safe, minimal Zsh configuration that wires Homebrew into your shell, initializes `asdf`, sets `JAVA_HOME` (when available), and defines useful aliases and shell settings.
- `git-config.sh` — a small script to set your global Git user name/email and a few useful Git aliases.

Use this README to understand what each file does, how to run the setup, and how to verify or customize it.

## Quick summary

- Homebrew: installed (if missing) and updated by `brew-setup.sh`.
- Installed Homebrew formulae (from the script): `asdf`, `btop`, `docker`, `docker-completion`, `gettext`, `git`, `libunistring`, `ollama`, `pcre2`.
- Installed Homebrew casks (from the script): `arc`, `betterdisplay`, `chatgpt`, `clipy`, `clop`, `discord`, `flameshot`, `insomnia`, `jetbrains-toolbox`, `jordanbaird-ice`, `lens`, `onlyoffice`, `orbstack`, `raycast`, `rectangle`, `spotify`, `visual-studio-code`, `zalo`.

## How the files work

- `brew-setup.sh`
	- Checks for `brew` and installs it using the official installer if not found.
	- Adds Homebrew to the shell environment (`~/.zprofile`) and evals the `brew shellenv` so `brew` is available in the current session.
	- Runs `brew update`, installs a list of formulae and casks, then runs `brew cleanup`.
	- Note: the installer is invoked with a remote script (curl). Inspect `brew-setup.sh` before running if you want to confirm exact steps.

- `.zshrc`
	- Safely evals Homebrew's environment if `/opt/homebrew` exists (Apple Silicon default).
	- Loads `asdf` when installed through Homebrew and sets up completions.
	- Sets `JAVA_HOME` automatically to an `asdf`-managed Java when available and prepends it to `PATH`.
	- Ensures common system paths are in `PATH` and defines a few handy aliases (`ll`, `gs`, `brewup`, `cls`).
	- Contains safe shell options: `noclobber`, `ignoreeof`, and increased history sizes.

## Git configuration

- `git-config.sh`
	- Sets global Git configuration values for `user.name` and `user.email` and adds common aliases (`co`, `br`, `ci`, `st`).
	- Edit `git-config.sh` to replace the example name and email before running.
	- Note: `git-config.sh` currently uses `//` comments which are not valid in sh/zsh scripts; replace `//` with `#` or run the `git config` commands manually.

Run the script (after editing) with:

```zsh
chmod +x git-config.sh
./git-config.sh
```

Or run the commands interactively in your terminal to set your name/email and aliases.

## Usage — run the installer

Run these commands in a terminal (zsh):

```zsh
chmod +x brew-setup.sh
./brew-setup.sh
```

Notes:

- The script will add `eval "$(/opt/homebrew/bin/brew shellenv)"` to `~/.zprofile` when installing Homebrew. If you use a different shell startup file, adapt accordingly.
- If Homebrew is already installed, the script will skip installation and continue with `brew update` and package installs.

## Verify the installation

Run these commands to verify the environment and key tools:

```zsh
brew --version
brew list --formula
brew list --cask
which asdf && asdf --version
java -version || true
echo $JAVA_HOME
which brew
```

If `asdf` is present, you can list installed runtimes with `asdf list` and install new ones as needed (for example, `asdf plugin-add java` then `asdf install java <version>`).

## Customization

- To add/remove installed items, edit `brew-setup.sh`. Keep the `brew update` and `brew cleanup` calls.
- To change aliases, PATH additions, or other shell behavior, edit `.zshrc`. If you prefer `~/.zprofile` for login-time environment variables, move permanent `eval` lines there.
- To enable a fancy prompt or `oh-my-zsh`/`starship`, uncomment or add the relevant lines in `.zshrc`.

## Troubleshooting

- If `brew` is not found after running the script, open a new login shell or source your profile:

```zsh
source ~/.zprofile
```

- If `asdf` doesn't load completions, run:

```zsh
autoload -Uz compinit && compinit
```

- If `JAVA_HOME` is empty, ensure you have installed a Java version via `asdf` and that it's set as global or local:

```zsh
asdf plugin-add java   # if plugin not added
asdf install java <version>
asdf global java <version>
```

## Security note

The `brew-setup.sh` script uses the official Homebrew installer which is fetched over HTTPS. As with any remote installer, review the script before running it if you have concerns.

## Author / Maintainer

Repository owner: PhaciusPhat
