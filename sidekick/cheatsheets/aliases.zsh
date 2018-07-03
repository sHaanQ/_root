# some more ls aliases
alias ll='ls -alF'
alias lt='ls -t'
alias llt='ls -lt'
alias llh='ls -alFh'
alias lth='ls -lth'
alias lssort='ls --sort=size -lh'
alias la='ls -A'
alias l='ls -CF'
alias documents='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias desktop='cd ~/Desktop'
alias music='cd ~/Music'
alias videos='cd ~/Videos'
alias coder='cd ~/Coder'
alias camera='cd ~/Camera'
alias public='cd ~/Public'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias install='sudo apt-get install -y'
alias search='sudo apt-cache search'
alias remove='sudo apt-get remove'
alias update='sudo apt-get update'
alias build='sudo echo "Build" && time make -j8 && sudo make modules_install && sudo make install && echo "Done"' 
alias cheat='git add python/python_cheatsheet.py  && git commit -m "Updated python_cheatsheet.py" && git push -u origin master' 
alias eudy='cd /home/bhargav/Coder/eudyptula/linux'
alias draft='cd /home/bhargav/Coder/_draft'
alias raspberry='cd /home/bhargav/Coder/raspberrypi'
alias ssid_print='sudo grep -r '^psk=' /etc/NetworkManager/system-connections/' 
alias connected_ssid='iwgetid -r'
alias wifi_reboot='sudo systemctl restart network-manager.service'
alias connections='sudo nmap -sP --disable-arp-ping'
alias rsync='rsync -ah --info=progress2 --partial'
alias diskspace='du -h --max-depth=1'

alias find_file='find . -name'

# extract 
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

# No more cd ../../..
# cd ../../../.. 	= up 4
# cd ../../../../../ 	= up 5
up() {
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}
