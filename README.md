# autoscreen
for automatic persistent screen
Inspired by https://mazzo.li/posts/autoscreen.html and modified it to have a option to
attach particular screen session attach during connect.

Paste it in .zshrc or .bashrc or .profile and source the file.
Then call autoscreen <ssh command>
  like autoscreen -J jmpbox remote server
  One thing, this needs password less ssh to be setup first for the remote server.

For passwordless ssh setup, put them on zshrc or bashrc:

function passwordless_proxy() {
    ssh-copy-id -o ProxyJump=$1 $2
}

function passwordless() {
    ssh-copy-id  $@
}

One thing here, if the particular terminal window is closed, the scrollbuffer of that window in local machine will be lost.
In that case upon reconnecting to the same session, those logs will be gone. To have the all previous scroll buffer
either keep the particular window opened or save the buffer to a file.

For FreeBSD to install screen on remote server please use :  pkg install sysutils/screen .

The benenfit of using autoscreen :
1) Persistent remote sessions
2) Easy clipboard copy/paste 
3) Auto reconnect of the sessions upon disconnection
4) No setup of tmux or screen to remote server.
