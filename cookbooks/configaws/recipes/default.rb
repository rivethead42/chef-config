#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
package 'git'
package 'docker'

service 'docker' do
	action :start
end
if node['platform_family'] == "debian" 
	package 'python-pip'
end

if node['platform'] == "redhat"
	package 'python2-pip'
	
	execute 'awscli' do
		command 'pip install awscli'
	end
end
