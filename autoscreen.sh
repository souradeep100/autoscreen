function settile() {
    #for zsh
    echo -ne "\e]1;$@\a"
    # for bash echo -ne '\033]0;'"$1"'\a'
    # for windows terminal with bash
    #export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #echo -ne '\033]0;'"$1"'\a'
}
}
function passwordless_proxy() {
    ssh-copy-id -o ProxyJump=$1 $2
}

function passwordless() {
    ssh-copy-id  $@
}

function autoscreen() {
  s=`ssh -t $@ 'screen -ls'`
  list=`echo $s | grep Detached` > /dev/null 2>&1
  if [[ $? -eq 0 ]]
  then
      echo $list | cut -d "." -f1
      echo 'choose session'
      read session_name
   fi
  if test -z "$session_name"
  then
      session_name=autosession-'$RANDOM$RANDOM$RANDOM$RANDOM'
  fi
  touch $HOME/$session_name.$$
  settile $session_name$@
  AUTOSSH_GATETIME=5 autossh -M 0 -- -o "ServerAliveInterval 5" -o "ServerAliveCountMax 1" -t $@ $'bash -c \'tmpScreenConfig=$(mktemp); echo "termcapinfo xterm* ti@:te" >> $tmpScreenConfig; echo "altscreen on" >> $tmpScreenConfig; echo "maptimeout 0" >> $tmpScreenConfig; echo "startup_message off" >> $tmpScreenConfig; echo "msgwait 0" >> $tmpScreenConfig; exec screen -c $tmpScreenConfig -S "'$session_name$'" -RD\'';
  echo "session id is"
  echo $session_name
  echo "if possible save the current terminal log to a file"
}
#put it in .zshrc or .bashrc

