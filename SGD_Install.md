## Installing Secure Global Desktop with Oracle Linux 7.0

**1. Download and Install SGD Oracle Linux 7.0**

**Windows Server 2019 DNS** 
>Processor: 2 Core / RAM: 4gb / HDD: 200gb
Network Adapter1: BridgeMode (Allow Promiscous) - Internal
	
 - Change Computer Name, Disable Firewall and Update 
 - Set IP: 142.232.141.X
 - Subnet: 255.255.255.0
 - Install DNS Role and Setup a NS Record and A Record

**ISO:** [https://tiny.cc/oraclelinux](https://tiny.cc/oraclelinux)

**SGD Oracle Linux 7.0** Processor: 2 Core / RAM: 4gb / HDD: 200gb
			    Network Adapter1: BridgeMode (Allow Promiscous) - Internal
			    Network Adapter2: NAT (Allow Promiscous) - Internet
   > Login using root

 - Change Computer Name, Disable Firewall and Update 
 - Set IP: 142.232.141.X
 - Subnet: 255.255.255.0
 - DNS: 142.232.141.X
 - Gateway: 142.232.141.X

**2. Installation of SGD 5.5 on Oracle Linux 7 Fails with Dependency Message, "Requires: libtclx8.4.so()"**
Open Terminal
> cd ~

> wget https://www.rpmfind.net/linux/mageia/distrib/3/x86_64/media/core/release/lib64tclx8.4-8.4-2.mga3.x86_64.rpm

> yum install lib64tclx8.4-8.4-2.mga3.x86_64.rpm

Follow the docs installing the setting up requirements and user accounts
Download and Extract SGD Package **SGD5.5.zip** and Install Server
> http://www.mediafire.com/file/1yt2609m8b6jhhy/SGD5.5.zip/file

Follow the docs installing the .rpm packages

**3. Allowing SGD to Expose Port 80 and 443**

>wget [https://pastebin.com/raw/1W9trRje](https://pastebin.com/raw/1W9trRje) -O /root/firewalld.sh

>chmod +x /etc/rc.local

>echo “/root/firewalld.sh” >> /etc/rc.local
