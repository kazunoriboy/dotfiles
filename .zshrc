# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(pyenv init -)"

export PS1="%d %% "
export LESS="-iRMXS"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/Cellar/dosfstools/4.2/sbin:$PATH"
export PATH="/Users/matsushima/development/flutter/bin:$PATH"
export PATH="/Users/matsushima/.local/bin:$PATH"
export DISPLAY=:0.0

alias ls='ls -F --color=always'
alias la='ls -la --color=always'
alias ll='ls -l --color=always'
alias mkdir='mkdir -p'
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'

autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt no_beep
setopt nonomatch

lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

function gitmain() {
  git config --global user.name "kazunoriboy"
  git config --global user.email "matunorigmnw@gmail.com"
}

function gitsub() {
  git config --global user.name "kazunori-matsushima"
  git config --global user.email "k.matsushima@crefil.com"
}

plugins=(
    zsh-autosuggestions
)

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
