# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval $(/opt/homebrew/bin/brew shellenv)

export PS1="%d %% "
export LESS="-iRMXS"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/Cellar/dosfstools/4.2/sbin:$PATH"
export PATH="/Users/matsushima/development/flutter/bin:$PATH"
export PATH="/Users/matsushima/.local/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export DISPLAY=:0.0

alias ci='circleci'
alias g='gitui'
alias la='eza -la --color=always'
alias ls='eza -F --color=always'
alias ll='eza -l --color=always'
alias mkdir='mkdir -p'
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt no_beep
setopt nonomatch

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/Cellar/tfenv/3.0.0/versions/1.5.5/terraform terraform

eval "$(zoxide init zsh)"

