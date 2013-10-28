alias gi="vim .gitignore"

# Example aliases
alias zshconfig="subl ~/.zshrc"
alias slog="cd /Applications/Slogger && ./slogger"
alias ohmyzsh="subl ~/.oh-my-zsh"
alias bashconfig="subl ~/.bashrc"
alias alsconfig="subl ~/.bash_aliases"

alias la="ls -a"
alias ll="ls -l"

# $ a.txt # will open the file in subl
alias -s txt=subl

alias octave='octave -q'
alias ipythonq='ipython qtconsole --colors=linux --pylab=inline --InteractiveShellApp.pylab_import_all=False'
alias ipn='cd ~/c-data/notebooks; ipython notebook --pylab=inline --InteractiveShellApp.pylab_import_all=False --script'
alias ipnn='cd ~/c-data/margin-model; ipython notebook --pylab=inline --script --InteractiveShellApp.pylab_import_all=False'  #[n]ow: current project
alias ins='ipython notebook --pylab=inline --script --InteractiveShellApp.pylab_import_all=False'

# alias ls='ls $LS_OPTIONS -hF' #human readable, append character indicator
# alias ll='ls $LS_OPTIONS -lhF' 	# long listing format
# alias l='ls $LS_OPTIONS -lAhF'	# like -a (all) but not the implied . and ..
# alias la='ls -a'
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
alias dat="cd ~/Dropbox/Engineering/data/"
alias sp="cd /usr/local/lib/python2.7/site-packages/"
alias pc="pwd | pbcopy"

alias dw="/Volumes/C/Users/beardc01/Desktop/"
pb="/Volumes/C/Users/beardc01/Desktop/pasteboard.txt"

alias ipj="ipython notebook --profile julia"