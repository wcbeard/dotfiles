# Define how Bash prompt looks like:
#
# User @ Host – working dir
#export PS1="\u@\h\w$ "
#export PS1="\u@\h\w: "

set completion-ignore-case on

#  ==============
#  ===AQUATERM===
#  ==============
# export GNUTERM='aqua'

#  ===========================
#  ===HOMEBREW AUTOCOMPLETE===
#  ===========================
source `brew --prefix`/Library/Contributions/brew_bash_completion.sh

#  =================
#  ===PYTHON-PATH===
#  =================
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
export PYTHONPATH="/usr/local/Cellar/python/2.7.2/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages:$PYTHONPATH"
export PYTHONPATH="/usr/local/Cellar/python/2.7.2/Frameworks/Python.framework/Versions/2.7/lib:$PYTHONPATH"
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH

#  ================
#  ===VIRTUALENV===
#  ================

# http://j2labs.tumblr.com/post/2904859594/python-2-6-2-7-and-3-1-with-virtualenv
export WORKON_HOME="$HOME/py-env"
export VIRTUALENVWRAPPER_LOG_DIR="$HOME/py-env"
export VIRTUALENVWRAPPER_HOOK_DIR="$HOME/py-env"
source /usr/local/bin/virtualenvwrapper.sh
# source $HOME/py-env/src/virtualenvwrapper/virtualenvwrapper.sh
# alias mkve26="mkvirtualenv --system-site-packages --python=/usr/bin/python2.6"
# alias mkve27="mkvirtualenv --system-site-packages --python=/usr/local/bin/python2.7"

alias mkve26="mkvirtualenv --python=/usr/bin/python2.6"
alias mkve27="mkvirtualenv --python=/usr/local/bin/python2.7"

export PATH=${PATH}:/Developer/SDKs/android-sdk-mac_86/tools
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# https://github.com/mxcl/homebrew/wiki/Homebrew-and-Python
export PATH=/usr/local/share/python:$PATH

# Something's f'd up
export MACOSX_DEPLOYMENT_TARGET=10.6

#  ====================
#  ===SKIM MAN PAGES===
#  ====================

manp()
{
  man -t "${1}" | open -f -a Skim
}

#  =====================
#  ===PROMPT FUNCTION===
#  =====================

#  http://www.debian-administration.org/articles/548  # in the comments
function truncate_pwd
{
  newPWD="${PWD/#$HOME/~}"
  local pwdmaxlen=15
  if [ ${#newPWD} -gt $pwdmaxlen ]
  then
     newPWD=".+${newPWD: -$pwdmaxlen}"
  fi
}

PROMPT_COMMAND=truncate_pwd
PS1="\${newPWD}\\$ "


# ====================
# =====DirColors======
# ====================
# http://hocuspokus.net/2008/01/a-better-ls-for-mac-os-x/
# brew install coreutils --default-names

# defined at ~/.dir_colors
# Terminal colours (after installing GNU coreutils)
NM="\[\033[0;38m\]" #means no background and white lines
HI="\[\033[0;37m\]" #change this for letter colors
HII="\[\033[0;31m\]" #change this for letter colors
SI="\[\033[0;33m\]" #this is for the current directory
IN="\[\033[0m\]"
 
# export PS1="$NM[ $HI\u $HII\h $SI\w$NM ] $IN"
 
if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    eval `dircolors ~/.dir_colors`
fi


#  =============
#  ===ALIASES===
#  =============
alias octave='octave -q'
alias ipythonq='ipython qtconsole --colors=linux'
alias ipn='cd ~/Dropbox/ipython_notebooks/; ipython notebook'
alias ls='ls $LS_OPTIONS -hF' #human readable, append character indicator
alias ll='ls $LS_OPTIONS -lhF' 	# long listing format
alias l='ls $LS_OPTIONS -lAhF'	# like -a (all) but not the implied . and ..
alias la='ls -a'
alias cd..="cd .."
alias c="clear"
alias e="exit"
alias ssh="ssh -X"
alias untar="tar -zxvf"
alias ej="hdiutil eject" # for ejecting
alias dr="cd ~/Dropbox" # dropbox directory
alias dt="cd ~/Desktop" #desktop
alias ~="cd ~/"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias duh='du -h'
# alias go="gcc -o" #compile with output
# alias ls="ls -G -F -C" # G: colored; F: slash after Directory C: multi column
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'


# change cd to pushd
# http://tmsh.posterous.com/cd-as-pushd
alias cd='. ${HOME}/bin/cd'
alias pd='popd'


# history handling
# 
# Erase duplicates
export HISTCONTROL=erasedups
# resize history size
export HISTSIZE=5000
# append to bash_history if Terminal.app quits
shopt -s histappend

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
