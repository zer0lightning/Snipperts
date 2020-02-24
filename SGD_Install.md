## Installing Secure Global Desktop with Oracle Linux 7.7

**Notes: Choose the LM Adapter**

**1. Install Virtualbox Guests**

**Windows Server 2019**

>Processor: 2 Core / RAM: 4gb / HDD: 200gb
>Network Adapter1: BridgeMode (Allow Promiscuous) - Internal

Inside your Windows Server 2019
- Go to ninite.com to install some apps for SGD that you need, then proceed.
- Accomplish these before anything else.

Network and Configuration
 - Change Computer Name, Disable UAC, Disable Firewall and Update 
 - Set IP: 142.232.241.X
 - Subnet: 255.255.255.0
 - Gateway: 142.232.241.254
 - DNS: 127.0.0.1
 
 Install Roles
 - Active Directory Services (Default Settings)
 - DNS  (Default Settings)
 - Remote Desktop Services Roles (Connection Broker, Session Host, Web Access)
 
 Post Install Role (AD and DNS)
 
 Active Directory Role
 - Disable all Firewalls
 - Promote to AD and create new forest
 - Active Directory Users and Computers (Add all the SGD Users)
 - Add those users to Domain Admins and Remote Desktop Users
 
DNS Role
 - Configure DNS Reverse lookup zone.
 - Add A + PTR record for all host (dns, win10, sgd) and check PTR option
 - Ping 8.8.8.8 and google.ca
 - Ping 142.232.241.254 and sgd.X.esa.bcit.ca

**SGD Oracle Linux 7.7** 
Processor: 2 Core / RAM: 4gb / HDD: 200gb
**ISO:** [https://tiny.cc/oraclelinux77](https://tiny.cc/oraclelinux77)

>Network Adapter1: Bridge Mode (Allow Promiscuous)

**Installation Screen**
- Software Selection: Server with GUI, Java Support, System Administration Tools, Compatibility Libraries
- Enable Default Networking DHCP to get internet access
- We will set the static after we manage to install SGD

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

> yum-config-manager --enable ol7_optional_latest

> nano /etc/yum.repos.d/oracle-linux-ol7.repo

Look for Entry on [ol7_optional_latest]
change enabled=0 to enabled=1

> yum-config-manager --enable ol7_optional_latest

> yum update

Static IP Address for Networking

 - Set IP: 142.232.241.X
 - Subnet: 255.255.255.0
 - DNS: 142.232.141.X
 - Gateway: 142.232.241.254

**3. Download and Extract SGD Package**
> http://tiny.cc/sgdinstall

Install SGD Server
> yum install /tempdir/oracle-sgd-server-version.el7.x86_64.rpm
- this process should install with no errors, otherwise repeat the yum configuration.

> /opt/tarantella/bin/tarantella start

Install Clients and Packages in order
> yum install oracle-sgd-clients-version.el7.noarch.rpm

> yum install oracle-sgd-clients-legacy-version.el7.noarch.rpm

> yum install oracle-sgd-tems-version.el7.noarch.rpm

**Add Linux Local Accounts**
> sudo useradd XUsername

> sudo passwd XUsername

- Login atleast once to each account to generate the home folder.

**Checklist**
> useraccounts exist

> firewall is down

> SGD installed correctly with no errors and starts normally

> visit http://localhost


**Windows 10 Client**
>Processor: 2 Core / RAM: 4gb / HDD: 200gb

>Network Adapter1: BridgeMode (Allow Promiscuous) - Internal
	
Inside your Windows 10 Client
Go to ninite.com to install some apps for SGD that you need, then proceed.
Accomplish these before anything else.

Post Install
 - Change Computer Name, Disable UAC, Disable Firewall and Update 
 - Set IP: 142.232.241.X
 - Subnet: 255.255.255.0
 - Gateway: 142.232.241.254
 - DNS: 142.232.241.X
 - Reboot Machine
 
Domain Joining and Remote
 - Login as local user
 - Domain join using 'domain', use your fruit name (ex. apple)
 - Login using Administrator and Password
 - Enable Remote Assistance and Remote Desktop, allow those users to use it
 - Reboot
 - Login using regulardomainuser@yourdomain.com
 
