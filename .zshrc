autoload -U compinit
compinit -u

PS1="${USER}@${HOST%%.*} %1~ %(!.#.$) "

if [ -f ${HOME}/.zsh.d/zsh_env ]; then
    source ${HOME}/.zsh.d/zsh_env
fi

if [ -f ${HOME}/.zsh.d/zsh_option ]; then
    source ${HOME}/.zsh.d/zsh_option
fi

if [ -f ${HOME}/.zsh.d/zsh_aliases ]; then
    source ${HOME}/.zsh.d/zsh_aliases
fi

if [ -f ${HOME}/.zsh.d/zsh_git ]; then
    source ${HOME}/.zsh.d/zsh_git
fi

if [ -f ${HOME}/.zsh.d/zsh_aws ]; then
    source ${HOME}/.zsh.d/zsh_aws
fi

if [ -f ${HOME}/.zsh.d/zsh_tmux ]; then
    source ${HOME}/.zsh.d/zsh_tmux
fi
