## Installing Secure Global Desktop with Oracle Linux 7.7

**1. Install Virtualbox Guests**

**Windows Server 2019 Activer Directory Services, DNS and Remote Desktop Services Roles**

>Processor: 2 Core / RAM: 4gb / HDD: 200gb

>Network Adapter1: BridgeMode (Allow Promiscous) - Internal
	
 - Change Computer Name, Disable UAC, Disable Firewall and Update 
 - Set IP: 142.232.141.X
 - Subnet: 255.255.255.0
 - Promote to AD and create new forrest
 - Configure DNS Role and Setup a NS Record and A Record
 - Create A for all the host and check PTR for each

**SGD Oracle Linux 7.7** Processor: 2 Core / RAM: 4gb / HDD: 200gb
**ISO:** [https://tiny.cc/oraclelinux77](https://tiny.cc/oraclelinux77)
>Network Adapter1: BridgeMode (Allow Promiscous) - Internal

   > Login using root

 - Set IP: 142.232.241.X
 - Subnet: 255.255.255.0
 - DNS: 142.232.141.X
 - Gateway: 142.232.241.X
 
 >Network Adapter2: NAT (Allow Promiscous) - Internet
 
 >DNS: 142.232.241.X

**2. Installation of SGD 5.5 on Oracle Linux 7 Fails with Dependency Message, "Requires: libtclx8.4.so()"**

Open Terminal
> Login as root

> sudo -i 

> systemctl stop firewalld

> systemctl disable firewalld

> nano /etc/hosts

> add entry sgd.X.esa.bcit.ca 142.232.241.X

> groupadd ttaserv

> useradd -g ttaserv -s /bin/sh -d /home/ttasys -m ttasys

> useradd -g ttaserv -s /bin/sh -d /home/ttaserv -m ttaserv

> passwd -l ttasys

> passwd -l ttaserv

> nano /etc

> yum-config-manager --enable ol7_optional_latest

> nano /etc/yum.repos.d/public-yum-ol7.repo

Look for Entry on [ol7_optional_latest]
change enabled=0 to enabled=1

> yum-config-manager --enable ol7_optional_latest

> yum update


**3. Download and Extract SGD Package**
> http://www.mediafire.com/file/1yt2609m8b6jhhy/SGD5.5.zip/file

Install SGD Server
> yum install /tempdir/oracle-sgd-server-version.el7.x86_64.rpm

> /opt/tarantella/bin/tarantella start

Install Clients and Packages in order
> yum install oracle-sgd-clients-version.el7.noarch.rpm

> yum install oracle-sgd-clients-legacy-version.el7.noarch.rpm

> yum install oracle-sgd-tems-version.el7.noarch.rpm

**Checklist**
> useraccounts exist

> firewall is down

> SGD installed correctly with no errors and starts normally

> visit http://localhost

