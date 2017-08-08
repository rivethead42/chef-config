#!/bin/bash

cd
wget https://packages.chef.io/files/stable/chefdk/2.0.28/el/7/chefdk-2.0.28-1.el7.x86_64.rpm
rpm -ivh chefdk-2.0.28-1.el7.x86_64.rpm
cp aws.json solo.rb /
cd /
chef-solo -c solo.rb -j aws.json
