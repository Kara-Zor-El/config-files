# Set up the prompt

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
#bindkey -e
bindkey -v
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[3~" vi-delete-char

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY

# Set TTY Colors to Dracula theme
if [ "$TERM" = "linux" ]; then
	printf %b '\e[40m' '\e[8]' # set default background to color 0 'dracula-bg'
	printf %b '\e[37m' '\e[8]' # set default foreground to color 7 'dracula-fg'
	printf %b '\e]P0282a36'    # redefine 'black'          as 'dracula-bg'
	printf %b '\e]P86272a4'    # redefine 'bright-black'   as 'dracula-comment'
	printf %b '\e]P1ff5555'    # redefine 'red'            as 'dracula-red'
	printf %b '\e]P9ff7777'    # redefine 'bright-red'     as '#ff7777'
	printf %b '\e]P250fa7b'    # redefine 'green'          as 'dracula-green'
	printf %b '\e]PA70fa9b'    # redefine 'bright-green'   as '#70fa9b'
	printf %b '\e]P3f1fa8c'    # redefine 'brown'          as 'dracula-yellow'
	printf %b '\e]PBffb86c'    # redefine 'bright-brown'   as 'dracula-orange'
	printf %b '\e]P4bd93f9'    # redefine 'blue'           as 'dracula-purple'
	printf %b '\e]PCcfa9ff'    # redefine 'bright-blue'    as '#cfa9ff'
	printf %b '\e]P5ff79c6'    # redefine 'magenta'        as 'dracula-pink'
	printf %b '\e]PDff88e8'    # redefine 'bright-magenta' as '#ff88e8'
	printf %b '\e]P68be9fd'    # redefine 'cyan'           as 'dracula-cyan'
	printf %b '\e]PE97e2ff'    # redefine 'bright-cyan'    as '#97e2ff'
	printf %b '\e]P7f8f8f2'    # redefine 'white'          as 'dracula-fg'
	printf %b '\e]PFffffff'    # redefine 'bright-white'   as '#ffffff'
	clear
fi
# Sets zstyle completions

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu yes select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme


export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git
  zsh-autosuggestions
  copypath
  dirhistory
  zsh-z
)
source $ZSH/oh-my-zsh.sh

bindkey '^ ' autosuggest-enable

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$PATH:$HOME/.spicetify"

export PATH="/home/kara/.local/bin:$PATH"
export PATH="/home/kara/.cargo/bin:$PATH"
export PATH="/home/kara/.emacs.d/bin:$PATH"
# export PATH="/home/.bin:$PATH"
export PATH="/usr/lib/jvm/java-17-openjdk/bin/:$PATH"
export PATH="$HOME/.spicetify:$PATH"
export PATH="/home/kara/.local/share/gem/ruby/3.0.0/bin:$PATH"
export PATH="/opt/depot_tools:$PATH"

if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

#[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
#source /usr/share/nvm/nvm.sh
#source /usr/share/nvm/bash_completion
#source /usr/share/nvm/install-nvm-exec

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
# source /usr/share/nvm/nvm.sh
# source /usr/share/nvm/bash_completion
# source /usr/share/nvm/install-nvm-exec
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export PATH="$HOME/.nvm/versions/node/v17.9.1/bin/:$PATH"

#  export NVM_DIR="$HOME/.nvm"
#  [ -s "$NVM_DIR/bash_completion" ] && \. "NVM_DIR/bash_completion"
#alias nvm="unalias nvm; [ -s '$NVM_DIR/nvm.sh' ] && . '$NVM_DIR/nvm.sh'; nvm $@"

source ~/.profile
source /usr/share/icons-in-terminal/icons_bash.sh
source /home/kara/.zplugins/dracula-syntax-highlighting/zsh-syntax-highlighting.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zplugins/cd-ls/cd-ls.zsh
source /home/kara/.zplugins/zsh-autopair/autopair.zsh
autopair-init
#source /home/kara/.zplugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zplugins/bgnotify/bgnotify.plugin.zsh
source ~/.zplugins/zsh-sudo/sudo.plugin.zsh
CLASSPATH="$CLASSPATH:/home/kara/Dev/RTP/tools.jar"
#  source /usr/share/nvm/init-nvm.sh
eval "$(thefuck --alias)"

if [ "$TERM" != "Linux" ]; then
  rust-fetch
fi
