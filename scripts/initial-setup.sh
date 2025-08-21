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

echo "Should an amnezia user be created (type 'true' if yes):"
echo "(type 'true' if yes)"
read IS_AMNEZIA_NEEDED

if [[ $IS_AMNEZIA_NEEDED == "true" ]]
then
    echo "Enter the pub key for the amnezia user:"
    read AMNEZIA_SSHPUBKEY
fi


# Install updates
apt update
apt upgrade -y

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

# Add the amnezia user, if needed
if [[ $IS_AMNEZIA_NEEDED == "true" ]]
then
    adduser amnezia
    usermod -aG sudo amnezia
    echo "amnezia ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

    AMNEZIA_AUTHKEYS_PATH="/home/amnezia/.ssh/authorized_keys"
    echo $AMNEZIA_SSHPUBKEY >> $AMNEZIA_AUTHKEYS_PATH
    chown amnezia $AMNEZIA_AUTHKEYS_PATH
    sudo -u amnezia chmod 600 $AMNEZIA_AUTHKEYS_PATH
fi

