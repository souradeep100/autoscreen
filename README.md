# autoscreen
for automatic persistent screen
Inspired by https://mazzo.li/posts/autoscreen.html and modified it to have a option to
attach particular screen session attach during connect.

Paste it in .zshrc or .bashrc or .profile and source the file.
Then call autoscreen <ssh command>
  like autoscreen -J jmpbox remote server
  One thing, this needs password less ssh to be setup first for the remote server.
