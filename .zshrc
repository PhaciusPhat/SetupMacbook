#############################################
# ~/.zshrc — Clean and Safe Configuration
# Compatible with macOS (Zsh default shell)
#############################################

# ===== 1. Homebrew setup =====
# Add Homebrew to PATH safely (Apple Silicon path)
if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# ===== 2. ASDF setup =====
# Load asdf if installed via Homebrew
if [ -d "$(brew --prefix asdf 2>/dev/null)" ]; then
  . "$(brew --prefix asdf)/libexec/asdf.sh"

  # Optional: enable asdf completions
  fpath=($(brew --prefix asdf)/completions $fpath)
  autoload -Uz compinit && compinit
fi


# ===== 3. JAVA_HOME setup =====
# Automatically set JAVA_HOME based on asdf's active Java version
if command -v asdf >/dev/null 2>&1; then
  JAVA_PATH="$(asdf where java 2>/dev/null)"
  if [ -n "$JAVA_PATH" ]; then
    export JAVA_HOME="$JAVA_PATH"
    export PATH="$JAVA_HOME/bin:$PATH"
  fi
fi


# ===== 4. PATH sanity =====
# Make sure system paths are included
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"


# ===== 5. Aliases =====
alias ll='ls -la'
alias gs='git status'
alias brewup='brew update && brew upgrade && brew cleanup'
alias cls='clear'


# ===== 6. Optional visual prompt setup (safe placeholder) =====
# Uncomment if using starship or oh-my-zsh later
# eval "$(starship init zsh)"
# source $ZSH/oh-my-zsh.sh


# ===== 7. Misc shell settings =====
set -o noclobber   # prevent overwriting files with >
set -o ignoreeof   # require Ctrl+D twice to exit
HISTSIZE=5000
SAVEHIST=5000


# ==== 8. Start and config ssh-agent for git ====
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/{your_private_key}  # replace with your key name

#############################################
# END OF FILE
#############################################
