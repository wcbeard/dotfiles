
alias octave='octave -q'
alias ipythonq='ipython qtconsole --colors=linux'
alias ipn='cd ~/Dropbox/ipython_notebooks/; ipython notebook'
alias ls='ls $LS_OPTIONS -hF' #human readable, append character indicator
alias ll='ls $LS_OPTIONS -lhF' 	# long listing format
alias l='ls $LS_OPTIONS -lAhF'	# like -a (all) but not the implied . and ..
alias la='ls -a'
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
