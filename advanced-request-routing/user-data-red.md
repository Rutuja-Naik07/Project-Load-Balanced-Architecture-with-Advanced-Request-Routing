#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
mkdir /var/www/html/red
cd /var/www/html/red
aws s3 cp s3://YOUR-BUCKET-NAME/hw-red.css ./
aws s3 cp s3://YOUR-BUCKET-NAME/hw.jpeg ./
aws s3 cp s3://YOUR-BUCKET-NAME/index-red.html ./index.html
systemctl restart httpd