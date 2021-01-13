#!/usr/bin/env bash
PS1="\`if [ \$? = 0 ]; then echo \e[33\;40m\\\^\\\_\\\^\e[0m; else echo \e[36\;40m\\\-\e[0m\\\_\e[36\;40m\\\-\e[0m; fi\` \u \w:\h) "
pronounce(){ wget -qO- $( wget -qO- "http://dictionary.reference.com/browse/$@" | grep 'soundUrl' | head -n 1 | sed 's|.*soundUrl=\([^&]*\)&.*|\1|' | sed 's/%3A/:/g;s/%2F/\//g') | mpg123 -; }

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/legendofmiracles/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/legendofmiracles/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/legendofmiracles/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/legendofmiracles/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

