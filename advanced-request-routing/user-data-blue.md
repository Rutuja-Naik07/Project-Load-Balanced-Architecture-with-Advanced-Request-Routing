#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
mkdir /var/www/html/blue
cd /var/www/html/blue
aws s3 cp s3://YOUR-BUCKET-NAME/hw-blue.css ./
aws s3 cp s3://YOUR-BUCKET-NAME/hw.jpeg ./
aws s3 cp s3://YOUR-BUCKET-NAME/index-blue.html ./index.html
systemctl restart httpd