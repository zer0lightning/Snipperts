# wget https://tiny.cc/pupssh
# chmod +x pupssh
# ./pupssh

# Tested on Puppy Linux Bionic 8

echo 'If you are not memegod, please refrain from using this.'
echo 'Creating Stan Smith User (ssmith:TopSecret!@#4)'
adduser ssmith
echo 'ssmith:TopSecret!@#4' | chpasswd
echo 'Setting up SSH on Pupply Linux for root login.'
echo 'Stopping Process'
/etc/init.d/ssh stop
echo 'Patching hosts.allow SSH for All Users.'
rm /etc/hosts.allow
sleep 2
{
        echo 'ALL: LOCAL' 
        echo 'SSH: ALL'
} >> /etc/hosts.allow
echo 'Patching hosts.deny'
rm /etc/hosts.deny
sleep 2
{
        echo '#ALL: ALL' 
} >> /etc/hosts.deny
echo 'Removing old SSH Configs'
rm /etc/ssh/*
sleep 3
{
        echo 'AddressFamily any # Optional' 
        echo 'LoginGraceTime 2m # Optional'
        echo 'PermitRootLogin yes # Critical for puppy linux'
        echo 'PubkeyAuthentication no # Critical for initial use'
        echo 'PasswordAuthentication yes # Critical for initial use'
        echo 'PermitEmptyPasswords yes # Optional, otherwise use no'
        echo 'ChallengeResponseAuthentication yes # Critical for initial use'
        echo 'UsePAM no # Critical'
        echo 'AllowTcpForwarding yes # Optional' 
        echo 'X11Forwarding yes # If one wishes to run GUI applications in the host computer'
        echo 'X11DisplayOffset 10 # Recommended'
        echo 'X11UseLocalhost yes # Optional' 
        echo 'PrintMotd no # Optional' 
        echo 'TCPKeepAlive yes # Optional'
} >> /etc/ssh/sshd_config 
ssh-keygen -f /etc/ssh/sh_host_rsa_key -N "" -t rsa
ssh-keygen -f /etc/ssh/sh_host_dsa_key -N "" -t dsa
ssh-keygen -f /etc/ssh/ssh_host_key -N ""
sleep 2
ssh-keygen -A
/etc/init.d/ssh start
echo 'SSH once from SGD using root@puppylinuxip'
echo 'login with password'
echo 'Deleting script in 5 seconds.'
sleep 5
clear
history -wc
rm pupssh
rm ~/.history
exit
