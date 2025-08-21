#!/bin/bash

if [[ $USER -ne "root" ]]
then
    echo "Sorry, this script is supposed to be run under the root user."
    exit 1
fi

echo "Hello there! Let's set up a new server!"
echo "Enter its hostname:"
read HOSTNAME

echo "Enter a username:"
read USERNAME

echo "Enter the user's ssh pub key:"
read SSHPUBKEY

# Change the hostname
echo $HOSTNAME > /etc/hostname

# Add the main user
adduser $USERNAME
usermod -aG sudo $USERNAME

# Add creds for the new user
USER_AUTHKEYS_PATH="/home/$USERNAME/.ssh/authorized_keys"
echo $SSHPUBKEY >> $USER_AUTHKEYS_PATH
chown $USERNAME $USER_AUTHKEYS_PATH
sudo -u $USERNAME chmod 600 $USER_AUTHKEYS_PATH

# Install updates
apt update
apt upgrade -y
