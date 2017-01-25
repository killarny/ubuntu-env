export PATH="$PATH":"$HOME"/bin

# redefined here so we don't need to modify .bashrc
alias ll='ls -l'

# nicely formatted list of ip addresses for all interfaces
alias ipa="ip -4 -o a | tr -s ' ' | cut -d ' ' -f 2,3,4 | column -t"

# markdown viewer
function markdown {
    pandoc -s -f markdown -t man $1 | man -l -
}

# make python use .pythonrc at startup
export PYTHONSTARTUP=~/.pythonrc

# virtualenvwrapper aliases for python3 projects
alias mkproject3='mkproject --python=/usr/bin/python3'
alias mkvirtualenv3='mkvirtualenv --python=/usr/bin/python3'

# less syntax highlighting; requires source-highlight package
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# simple web servers
if [ -f ~/.bash_simple_webservers ]; then
    . ~/.bash_simple_webservers
fi

# include some other useful stuff
if [ -f ~/.bash_git_enhancements ]; then
    . ~/.bash_git_enhancements
fi

if [ -f ~/.bash_virtualenvwrapper ]; then
    . ~/.bash_virtualenvwrapper
fi

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

if [ -f ~/.bash_django ]; then
    . ~/.bash_django
fi
