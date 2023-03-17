  6 function settile() {
  7     echo -ne "\e]1;$@\a"
  8 }
  9 function passwordless_proxy() {
 10     ssh-copy-id -o ProxyJump=$1 $2
 11 }
 12
 13 function passwordless() {
 14     ssh-copy-id  $@
 15 }
 16 function autoscreen() {
 17   s=`ssh -t $@ 'screen -ls'`
 18   reattach=0
 19   list="`echo $s | grep Detached`" > /dev/null 2>&1
 20   if [[ "$?" -eq 0 ]]
 21   then
 22       echo $list | cut -d "." -f1
 23       echo 'choose session'
 24       read session_name
 25   fi
 26   if test -z "$session_name"
 27   then
 28       session_name=autosession-"$RANDOM$RANDOM$RANDOM$RANDOM"
 29   else
 30       reattach=1
 31   fi
 32   settile $session_name-$@
 33   AUTOSSH_GATETIME=5 autossh -M 0 -- -o "ServerAliveInterval 5" -o "ServerAliveCountMax 1" -t $@ $'bash -c \'tmpScreenConfig=$(mktemp); echo "termcapinfo xterm* ti@:te" >> $tmpScreenConfig; echo "altscreen
     on" >> $tmpScreenConfig; echo "maptimeout 0" >> $tmpScreenConfig; echo "startup_message off" >> $tmpScreenConfig; echo "msgwait 0" >> $tmpScreenConfig; echo "hardstatus ignore" >> $tmpScreenConfig; exec screen -c $tmpScreenConfig -S "'$session_name$'
    " -RD\'';
 34   echo "session id is"
 35   echo $session_name
 36   dir=/mnt/c/Users/schakrabarti/"$session_name"/"$(date +"%d-%m-%Y")"
 37   echo $dir
 38   if [[ ! -d "$dir" ]]
 39   then
 40     mkdir -p $dir
 41   fi
 42   echo "if possible save the current terminal log to a file"
 43 }
