#!/bin/bash

cp aws.json solo.rb /
cd /
chef-solo -c solo.rb -j aws.json
