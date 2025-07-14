#!/bin/bash
yum update -y
yum install -y httpd git
mkfs.ext4 /dev/xvdf
mkdir /data
mount /dev/xvdf /data
cd /data
git clone https://github.com/MojjadaCode-Git/high-availability-aws-webapp.git
cp high-availability-aws-webapp/app/index.html /var/www/html/index.html
systemctl start httpd
systemctl enable httpd
