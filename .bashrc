if [ -f ~/.bash/sensitive ] ; then
    source ~/.bash/sensitive
fi

export PATH="$PATH:/usr/local/go/bin"
export AWS_PRIVATE_KEY="~/.ssh/ansible"
export EDITOR='/usr/bin/vim'

export TF_VAR_dir_ansible='/home/bkim/src/KeplerGroup/kepler-ansible'
export TF_VAR_private_key='/home/bkim/.ssh/ansible'

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -select clipboard -o'

alias apv='ansible-playbook --ask-vault-pass'
alias ap='ansible-playbook'
alias gitall='find . -name '.git' -type d | while read dir ; \
              do sh -c "cd $dir/../ && git status" ; done'

#######################################################################
# Set command to include git branch in my prompt
#######################################################################

function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

BOLD_GREEN="\[$(tput bold)\]\[\033[38;5;10m\]"
BOLD_BLUE="\[$(tput bold)\]\[\033[38;5;115m\]"
BOLD_YELLOW="\[$(tput bold)\]\[\033[38;5;226m\]"
NO_COLOR="\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\]"

PS1_USER_HOST="${BOLD_GREEN}\u@\h "
PS1_GIT="${BOLD_YELLOW}\$(parse_git_branch)${NO_COLOR} \$ "
PS1_DIR="${BOLD_BLUE}\w${NO_COLOR}"

PS1="${PS1_USER_HOST}${PS1_DIR}${PS1_GIT}"

# For man page formatting
export LESS="--RAW-CONTROL-CHARS"
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

