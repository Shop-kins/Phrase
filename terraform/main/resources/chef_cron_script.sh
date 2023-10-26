#/bin/bash
aws s3 cp s3://shop-kins-chef-bucket/chef_cookbooks.zip chef_cookbooks.zip
unzip chef_cookbooks.zip
chef-client -z -o $(cat ./runlist.txt)