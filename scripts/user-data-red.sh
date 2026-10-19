#!/bin/bash
# EC2 user data for the RED web server.
# Replace YOUR-BUCKET-NAME with the name of your S3 bucket before launching.
yum update -y
yum install -y httpd

# start the httpd daemon
systemctl start httpd
# start httpd automatically at boot time
systemctl enable httpd

mkdir /var/www/html/red

# populate the /red directory of the server with the web page
cd /var/www/html/red
aws s3 cp s3://YOUR-BUCKET-NAME/hw-red.css ./
aws s3 cp s3://YOUR-BUCKET-NAME/hw-red-py.css ./
aws s3 cp s3://YOUR-BUCKET-NAME/python.png ./
aws s3 cp s3://YOUR-BUCKET-NAME/apache.svg ./
aws s3 cp s3://YOUR-BUCKET-NAME/red-index.html ./index.html

# populate the root of the server with the web page (replaces the Apache default page)
cd /var/www/html
aws s3 cp s3://YOUR-BUCKET-NAME/hw-red.css ./
aws s3 cp s3://YOUR-BUCKET-NAME/hw-red-py.css ./
aws s3 cp s3://YOUR-BUCKET-NAME/python.png ./
aws s3 cp s3://YOUR-BUCKET-NAME/apache.svg ./
aws s3 cp s3://YOUR-BUCKET-NAME/red-root-index.html ./index.html

# optional restart of the httpd daemon
systemctl restart httpd
