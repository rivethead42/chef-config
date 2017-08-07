#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe "cloudcli"

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

cloudcli_aws_credentials '/etc/aws/credentials' do
  owner 'cloud_user'
  group 'cloud_user'
  mode 0600
  credential_params(
    region: 'us-west-2'
  )
end
