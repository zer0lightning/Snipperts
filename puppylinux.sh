wget https://raw.githubusercontent.com/zer0lightning/Snipperts/master/sshd_config
mv sshd_config /etc/ssh/
ssh-keygen -f /etc/ssh/sh_host_rsa_key -N "" -t rsa
ssh-keygen -f /etc/ssh/sh_host_dsa_key -N "" -t dsa
ssh-keygen -f /etc/ssh/ssh_host_key -N ""
ssh-keygen -A
/etc/init.d/ssh start