# PATH
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/bin/try:$PATH"

# util-linux
export PATH="/usr/local/opt/util-linux/bin:$PATH"
export PATH="/usr/local/opt/util-linux/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/util-linux/lib"
export CPPFLAGS="-I/usr/local/opt/util-linux/include"
export PKG_CONFIG_PATH="/usr/local/opt/util-linux/lib/pkgconfig"

# WORKDIR
export d="$HOME/git"
# DOTFILES FOLDER
export DOTS="$HOME/dotfiles"

# zoxide
eval "$(zoxide init zsh)"

# starship
eval "$(starship init zsh)"

# thefuck 
eval $(thefuck --alias)

# lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# git
alias gka='gitk --all & disown'

# lazygit 
lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# fzf 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# tmux
launch() {
	if [[ -z $TMUX ]]; then
		"$HOME/.config/tmux/tmux_launch.sh"
	else
		tmux popup -EE -w 60% -h 60% "$HOME/.config/tmux/tmux_launch.sh"
  fi
}

# nvim
alias nano=nvim
alias vim=nvim

# moving around in the terminal
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
