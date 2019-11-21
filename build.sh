#!/bin/bash
# script to add dep and user in image
apt-get update -y
useradd test -ms /bin/bash
echo -e "test\ntest" | passwd test # changing password of test user to test
apt-get install -y wget sudo 
