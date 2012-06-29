# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"
alias bashconfig="subl ~/.bashrc"

alias la="ls -a"
alias ll="ls -l"

# $ a.txt # will open the file in subl
alias -s txt=subl

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

export WORKON_HOME="$HOME/py-env"
export VIRTUALENVWRAPPER_LOG_DIR="$HOME/py-env"
export VIRTUALENVWRAPPER_HOOK_DIR="$HOME/py-env"


# Customize to your needs...
# export PATH=/usr/local/share/python:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
# Define how Bash prompt looks like:
#
# User @ Host – working dir
#export PS1="\u@\h\w$ "
#export PS1="\u@\h\w: "



# #############################
############ BASHRC ###########
# #############################

set completion-ignore-case on

# http://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   platform='mac'
elif [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
fi

if [[ $platform == 'mac' ]]; then
   manp()
   {
     man -t "${1}" | open -f -a Skim
   }
   alias hm='cd ~/Dropbox/Engineering/vagrant/'
   # change cd to pushd
   # http://tmsh.posterous.com/cd-as-pushd
   # alias cd='. ${HOME}/bin/cd'
   alias pd='popd'

   export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python"

plugins=(git brew django pip screen sublime vagrant virtualenvwrapper)

source $ZSH/oh-my-zsh.sh
elif [[ $platform == 'linux' ]]; then
   # alias ls='ls --color=auto'
# /usr/local/lib/python2.6/dist-packages/neo4django
   alias cd='pushd'
   alias pd='popd'
   alias hm='cd /vagrant/'
   export DJANGO_SETTINGS_MODULE="neo4django.tests.test_settings"
fi  


plugins=(git brew django pip screen sublime vagrant virtualenvwrapper)

source $ZSH/oh-my-zsh.sh

#  ================
#  ===VIRTUALENV===
#  ================

# http://j2labs.tumblr.com/post/2904859594/python-2-6-2-7-and-3-1-with-virtualenv
# export WORKON_HOME="$HOME/py-env"
# export VIRTUALENVWRAPPER_LOG_DIR="$HOME/py-env"
# export VIRTUALENVWRAPPER_HOOK_DIR="$HOME/py-env"
# export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python"
# source /usr/local/share/python/virtualenvwrapper.sh
# 
# source $HOME/py-env/src/virtualenvwrapper/virtualenvwrapper.sh
# alias mkve26="mkvirtualenv --system-site-packages --python=/usr/bin/python2.6"
# alias mkve27="mkvirtualenv --system-site-packages --python=/usr/local/bin/python2.7"

alias mkve26="mkvirtualenv --python=/usr/bin/python2.6"
alias mkve27="mkvirtualenv --python=/usr/local/bin/python2.7"

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# https://github.com/mxcl/homebrew/wiki/Homebrew-and-Python
export PATH=/usr/local/share/python:$PATH


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# history handling
# 
# Erase duplicates
# export HISTCONTROL=erasedups
# resize history size
export HISTSIZE=5000
# append to bash_history if Terminal.app quits
# shopt -s histappend

#  ================================
#  ===PACKAGE CONFIGURATION PATH===
#  ================================
# from http://www.linuxquestions.org/questions/linux-software-2/how-do-i-add-to-the-pkg_config_path-environment-variable-619202/
# PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/my/additional/config
# PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig/

#=========tips to keep in mind====
# textutil -convert doc /path/to/my/file.docx #to convert text documents


# Setting PATH for Python 3.1
# The orginal version is saved in .bash_profile.pysave
# PATH="${PATH}:/Library/Frameworks/Python.framework/Versions/3.1/bin"
export PATH
