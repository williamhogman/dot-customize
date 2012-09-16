
C_ZSH_F=$C_HOME/apps/zsh/
source $C_ZSH_F/termsupport.zsh
source $C_ZSH_F/history.zsh
source $C_ZSH_F/looks.zsh
source $C_ZSH_F/theme.zsh
source $C_ZSH_F/completion.zsh

if [[ $TERM != "emacs" ]]; then
    source $C_HOME/apps/zsh/key-bindings.zsh
fi

source $C_ZSH_F/git-flow.zsh
