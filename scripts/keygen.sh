#!/bin/zsh
ZSHSSHALIASESPATH="$SYNCED_DIR/zsh_override.sh"
SSHKEYDIRPATH="$HOME/.ssh"

echo ""
echo "Hello there! Let's create an ssh alias for the remote server!"

echo "Please, enter a name for the new server:"
read SERVERNAME
echo ""

echo "What ssh group should it be in?"
read SSHGROUP
echo ""

echo "What user?"
read NAME
echo ""

echo "What IP?"
read IP
echo ""

SSHIDENTITYPATH="$SSHKEYDIRPATH/$SERVERNAME"
SERVERENV=$(echo $SERVERNAME | tr 'a-z' 'A-Z' | tr -d "-")

ssh-keygen -t ed25519 -a 32 -f $SSHIDENTITYPATH

echo "export $SERVERENV=\"$NAME@$IP\"" >> $ZSHSSHALIASESPATH
echo "alias ssh$SSHGROUP$SERVERNAME=\"ssh -i $SSHIDENTITYPATH \$$SERVERENV\"" >> $ZSHSSHALIASESPATH

echo "Done! Here is the private key:"
echo ""
cat "$SSHIDENTITYPATH"
echo ""
echo "Here is the pub key:"
echo ""
cat "$SSHIDENTITYPATH.pub"
echo ""
