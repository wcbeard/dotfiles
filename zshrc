
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh


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

export USE_LIBPCRE=yes

if [ -f ~/.mac_zsh ]; then
    . ~/.mac_zsh
fi

set completion-ignore-case on

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

plugins=(git brew django pip python sublime vagrant neo4j mysql.server postgres
 gem npm tmux screen vundle)

# http://stackoverflow.com/a/394235/386279
case $OSTYPE in
  darwin*) platform=mac ;;
  linux*) platform=linux;;
  *) platform=other;;
esac

if [[ $platform == 'mac' ]]; then
   plugins+=(virtualenvwrapper)
   manp()
   {
     man -t "${1}" | open -f -a Skim
   }
   alias hm='cd ~/Dropbox/Engineering/vagrant/'
   # change cd to pushd
   # http://tmsh.posterous.com/cd-as-pushd
   # alias cd='. ${HOME}/bin/cd'
   export DJANGO_SETTINGS_MODULE="scholrly.settings_local"
   export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python"
   export JAVA_HOME=$(/usr/libexec/java_home)
   export SCALA_HOME=/usr/local/Cellar/scala/2.9.2/libexec
   export JAVACMD=drip
   export DRIP_SHUTDOWN=30
   export SBT_OPTS="-XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:PermSize=128M -XX:MaxPermSize=512M"
   #autojump
   [[ -s `brew --prefix`/etc/autojump.zsh ]] && . `brew --prefix`/etc/autojump.zsh

   #brew cask
   export HOMEBREW_CASK_OPTS="--appdir=/Applications"
   # Set name of the theme to load.
   # Look in ~/.oh-my-zsh/themes/
   # Optionally, if you set this to "random", it'll load a random theme each
   # time that oh-my-zsh is loaded.
   ZSH_THEME="robbyrussell"

   export WORKON_HOME="$HOME/py-env"
   export VIRTUALENVWRAPPER_LOG_DIR="$HOME/py-env"
   export VIRTUALENVWRAPPER_HOOK_DIR="$HOME/py-env"

elif [[ $platform == 'linux' ]]; then
   alias cd='pushd'
   alias subl='vim'
   alias prc="/var/pricing_share"
   alias open="xdg-open"
   ZSH_THEME="wedisagree"
   [[ -s ~/.autojump/etc/profile.d/autojump.zsh ]] && . ~/.autojump/etc/profile.d/autojump.zsh
   export PYENV_ROOT=$HOME/.pyenv
   export PATH=$PYENV_ROOT/bin:$PATH
   #export PATH=/usr/pgsql-9.3/bin/:$PATH
   export PATH=/home/beardc01/postgres/bin:$PATH
   export PYTHONPATH=/var/pricing_share/repos/src:$PYTHONPATH
   export LD_LIBRARY_PATH=/home/beardc01/postgres/lib:$LD_LIBRARY_PATH  #for psycopg
   eval "$(pyenv init -)"
   eval "pyenv virtualenvwrapper"
fi

export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=" -R "
setopt extendedglob

# QSTK
# source QSTK/local.sh



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

# export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
export PYTHONPATH=~/src:$PYTHONPATH

# https://github.com/mxcl/homebrew/wiki/Homebrew-and-Python
# export PATH=/usr/local/share/python:$PATH
export PATH=/Users/beard/scikit-learn:$PATH
export PATH=~/.cabal/bin:$PATH
export PATH=/usr/local/Cellar/ruby/1.9.3-p194/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=$WXDIR:$WXDIR/wx-2.9.4-osx_cocoa:$WXDIR/wx-2.9.1-osx_cocoa/tools:$PATH
export PATH=/Users/beard/Dropbox/Engineering/data:$PATH
export PATH=~/src:$PATH
export PYTHONDONTWRITEBYTECODE=True
export PATH=/usr/local/opt/ruby/bin:$PATH
# export PYTHONPATH="/usr/local/lib/wxPython-2.9.4.0/lib/python2.7/site-packages:$PYTHONPATH"
# export PYTHONPATH="/usr/local/lib/wxPython/lib/python2.7/site-packages/wx-2.9.4-osx_cocoa/wx:$PYTHONPATH"
# export PATH=/usr/local/lib/wxPython-2.9.4.0:$PATH

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# APPDATA=$HOME/.runsnake


# history handling
#
# Erase duplicates
export HISTCONTROL=erasedups
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


# pycuda
export CUDA_ROOT=/usr/local/cuda/bin
export PATH=/usr/local/cuda/bin:$PATH

# export PATH=$PATH:/Users/beardc01/src/anaconda/bin

#=========tips to keep in mind====
# textutil -convert doc /path/to/my/file.docx #to convert text documents

source $ZSH/oh-my-zsh.sh


# wk() {
#   cd /vagrant/;
#   cd "$*";
#   workon "$*";
# }

wk() {
  workon "$1" && cd /vagrant/ && cd "$1";
}

agpy () {
  ag "$@" **/*.py
}

# compdef wk workon
compdef workon wk

# system
umask 0002 # group write permission

# Setting PATH for Python 3.1
# The orginal version is saved in .bash_profile.pysave
# PATH="${PATH}:/Library/Frameworks/Python.framework/Versions/3.1/bin"
export TERM=xterm-256color
export PATH
