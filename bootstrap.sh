#!/bin/bash

cd
cp ~/chef-config/aws.json ~/chef-config/solo.rb /
cd /
chef-solo -c solo.rb -j aws.json
