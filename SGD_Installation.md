## Installing Secure Global Desktop with Oracle Linux 7.7

**Notes: Prerequisites (USE LM Adapter!!!!)**
- ISO and SGD RPM - http://tiny.cc/sgdinstall
- Plan out your IP Address Range for these Host - Windows Server 2019 (AD, DNS, RS), SGD, Windows 10 Client
- Download offline installers for the applications you want to install, or get it installed while your VM have internet access.
- Your DNS Server needs to work for SGD to work.
- SGD User Accounts need to be created locally for Linux, for Windows create it using AD Users and Computers.

**Topology**
- Tarantella Server is also your Linux Application Server
- Windows Server 2019 (AD, DNS, RDS) is also your Windows Server Application Server
- Windows 10 Client Enterprise is your Windows 10 Desktop Application Server

## **1. Install VirtualBox Guests**

**Windows Server 2019**

>Processor: 2 Core / RAM: 4gb / HDD: 200gb
>Network Adapter1: Bridge Mode (Allow Promiscuous)

**Inside your Windows Server 2019**
- Go to ninite.com to install some apps for SGD that you need, then proceed.
- Accomplish these before anything else.

**Network and Configuration**
 - Change Computer Name, Disable UAC, Disable Firewall and Update 
```
Set IP: 10.10.10.X
Subnet: 255.255.255.0
Gateway: 10.10.10.X
DNS: 127.0.0.1
```

 **Install Roles**
 - Active Directory Services (Default Settings)
 - DNS  (Default Settings)
 - Remote Desktop Services Roles (Connection Broker, Session Host, Web Access)
 
 **Post Install Role (AD and DNS)**
 
 **Active Directory Role**
 - Disable all Firewalls
 - Promote to AD and create new forest
 - Active Directory Users and Computers (Add all the SGD Users)
 - Add those users to Domain Admins and Remote Desktop Users
 
**DNS Role**
 - Configure DNS Reverse lookup zone.
 - Add A + PTR record for all host (dns, win10, sgd) and check PTR option
 - Ping 8.8.8.8 and google.ca
 - Ping 10.10.10.X and sgd.X.your.domain.ca

**SGD Oracle Linux 7.7** 

Processor: 2 Core / RAM: 4gb / HDD: 200gb

**ISO:** [https://tiny.cc/oraclelinux77](https://tiny.cc/oraclelinux77)

>Network Adapter1: Bridge Mode (Allow Promiscuous)

**Installation Screen**
- Software Selection: Server with GUI, Java Support, System Administration Tools, Compatibility Libraries
- Enable Default Networking DHCP to get internet access
- We will set the static after we manage to install SGD

**Open Terminal**
- Login as root

```
sudo -i 
systemctl stop firewalld
systemctl disable firewalld
nano /etc/hosts
add entry sgd.X.your.domain.ca 10.10.10.X
groupadd ttaserv
useradd -g ttaserv -s /bin/sh -d /home/ttasys -m ttasys
useradd -g ttaserv -s /bin/sh -d /home/ttaserv -m ttaserv
passwd -l ttasys
passwd -l ttaserv
```
## **2. Installation of SGD 5.5 on Oracle Linux 7 Fails with Dependency Message, "Requires: libtclx8.4.so()"**
```
yum-config-manager --enable ol7_optional_latest
nano /etc/yum.repos.d/oracle-linux-ol7.repo
Look for Entry on [ol7_optional_latest]
change enabled=0 to enabled=1
yum -y update
```

**Static IP Address for Networking**
```
Set IP: 10.10.10.X
Subnet: 255.255.255.0
DNS: 142.232.141.X
Gateway: 10.10.10.X
```

## **3. **Install SGD Server****
[SGD RPM](http://tiny.cc/sgdinstall)
- unzip the file, enter the directory.

Terminal:$
```
cd SGDRPM
sudo yum install -y *.rpm
/opt/tarantella/bin/tarantella start
```

**Install Clients and Packages in order**
```
yum install oracle-sgd-clients-version.el7.noarch.rpm
yum install oracle-sgd-clients-legacy-version.el7.noarch.rpm
yum install oracle-sgd-tems-version.el7.noarch.rpm
```

**Add Linux Local Accounts**
```
sudo useradd XUsername
sudo passwd XUsername
```

- Login atleast once to each account to generate the home folder.

**Checklist**
- User Accounts exist.
- Firewall is down
- SGD installed correctly with no errors and starts normally
- Visit http://localhost
- Change Client Settings to HTML 5
- Login to MY Desktop as root, click 'My Desktop'
- If you can see the Oracle Desktop, it works. Otherwise go home.


## **4. Windows 10 Client**
>Processor: 2 Core / RAM: 4gb / HDD: 200gb

>Network Adapter1: Bridge Mode (Allow Promiscuous)
	
**Inside your Windows 10 Client**
Go to ninite.com to install some apps for SGD that you need, then proceed.
Accomplish these before anything else.

**Post Install**
 - Change Computer Name, Disable UAC, Disable Firewall and Update 
```
Set IP: 10.10.10.X
Subnet: 255.255.255.0
Gateway: 10.10.10.X
DNS: 10.10.10.X
```
 - Reboot Machine
 
**Domain Joining and Remote**
 - Login as local user
 - Domain join using 'domain', use your fruit name (ex. apple)
 - Login using Administrator and Password
 - Enable Remote Assistance and Remote Desktop, allow those users to use it
 - Reboot
 - Login using regulardomainuser@yourdomain.com
 
**SGD Objects Installation/RDS are not covered by this guide.**


## **5. Windows Server 2019 RDS Configuration**
**Install Active Directory Domain Services**

- **Reboot** after installing ADDS and promote Domain Admin.
- Rebooting avoids the issue of RDS not having right to some databases.
- Install Remote Desktop Services.

[**Configuring Remote Desktop Services:**](https://nedimmehic.org/2017/02/08/how-to-install-remote-desktop-services-2016-quick-start-deployment/)
- You need to create a Collection and publish the application for which you created objects for in SGD. Otherwise the application won’t work in SGD workspace.
- Enable RDP and Add User.

**Creating the Collection:**
- In Server Manager click RDS Collection Tasks Create Session Collections
- Enter a name for the collection
- Select the RD Session Host server (your Windows Server 2019 server)
- Enter a file share location (this doesn’t really make a difference for our lab purpose)
- Accept the default user groups
- Click ‘create’.

**Adding the Application to the Collection:**
- In Server Manager, click the collection you just made.
- Under RemoteApp Programs, click ‘Publish RemoteApp Programs’
- Select the programs you want to publish, and then click ‘Publish’

