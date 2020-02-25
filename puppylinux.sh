echo 'Setting up SSH on Pupply Linux for root login.'
echo.
echo.
{
        echo 'AddressFamily any # Optional;' 
        echo 'LoginGraceTime 2m # Optional;'
        echo 'PermitRootLogin yes # Critical for puppy linux;'
        echo 'PubkeyAuthentication no # Critical for initial use;'
        echo 'PasswordAuthentication yes # Critical for initial use;'
        echo 'PermitEmptyPasswords yes # Optional, otherwise use no;'
        echo 'ChallengeResponseAuthentication yes # Critical for initial use;'
        echo 'UsePAM no # Critical;'
        echo 'AllowTcpForwarding yes # Optional;' 
        echo 'X11Forwarding yes # If one wishes to run GUI applications in the host computer;'
        echo 'X11DisplayOffset 10 # Recommended;'
        echo 'X11UseLocalhost yes # Optional;' 
        echo 'PrintMotd no # Optional;' 
        echo 'TCPKeepAlive yes # Optional;'
} >> /etc/ssh/sshd_config 
ssh-keygen -f /etc/ssh/sh_host_rsa_key -N "" -t rsa
ssh-keygen -f /etc/ssh/sh_host_dsa_key -N "" -t dsa
ssh-keygen -f /etc/ssh/ssh_host_key -N ""
echo 'Executing Keygen A'
ssh-keygen -A
/etc/init.d/ssh start
