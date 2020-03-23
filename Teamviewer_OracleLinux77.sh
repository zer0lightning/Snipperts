# Installing Teamviewer on Oracle Linux 7.7
yum install epel-release -y
wget https://download.teamviewer.com/download/linux/teamviewer-host.x86_64.rpm
yum install qt5-qtdeclarative-5.9.7-1.el7.x86_64  -y
yum intall qt5-qtxmlpatterns-5.9.7-1.el7.x86_64 -y
wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-12.noarch.rpm
yum install epel* -y
yum install qt5-qtwebkit -y
yum install ./teamviewer-host.x86_64.rpm -y
