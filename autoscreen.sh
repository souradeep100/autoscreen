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
  echo $session_name
  AUTOSSH_GATETIME=5 autossh -M 0 -- -o "ServerAliveInterval 5" -o "ServerAliveCountMax 1" -t $@ $'zsh -c \'tmpScreenConfig=$(mktemp); echo "termcapinfo xterm* ti@:te" >> $tmpScreenConfig; echo "altscreen on" >> $tmpScreenConfig; echo "maptimeout 0" >> $tmpScreenConfig; echo "startup_message off" >> $tmpScreenConfig; echo "msgwait 0" >> $tmpScreenConfig; exec screen -c $tmpScreenConfig -S "'$session_name$'" -RD\''
}
#put it in zshrc or bashrc, in case of bashrc change  $'zsh -c \'tmpScreenConfig=$(mktemp) 
# to  $'bash -c \'tmpScreenConfig=$(mktemp)
