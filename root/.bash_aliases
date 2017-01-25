# redefined here so we don't need to modify .bashrc
alias ll='ls -l'

# nicely formatted list of ip addresses for all interfaces
alias ipa="ip -4 -o a | tr -s ' ' | cut -d ' ' -f 2,3,4 | column -t"

# markdown viewer
function markdown {
    pandoc -s -f markdown -t man $1 | man -l -
}

# less syntax highlighting; requires source-highlight package
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# powerline if possible, otherwise use custom bash prompt
if [ -f /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh ]; then
    source /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
else
    if [ -f ~/.bash_prompt ]; then
        . ~/.bash_prompt
    fi
fi

if [ -f ~/.bash_pip ]; then
    . ~/.bash_pip
fi
