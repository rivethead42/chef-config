#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'sshd::default'

package 'git'
package 'docker'

user 'cloud_user' do
  home '/home/cloud_user'
  manage_home true
  shell '/bin/bash'
  password '$1$linuxaca$iGMxZ4g4lbPmfEDPhW3lw1'
  salt 'linuxacademy'
end

openssh_server '/etc/sshd_config' do
  PasswordAuthentication yes
end

service 'docker' do
	action :start
end
if node['platform_family'] == "debian"
  package 'python-pip'
  package 'awscli'
end

if node['platform_family'] == "rhel"
  package 'python2-pip'
  	
  execute 'curl-get-pip' do
    command 'curl -O https://bootstrap.pypa.io/get-pip.py'
  end
	
  execute 'get-pip' do
    command 'python get-pip.py --user'
  end

  execute 'awscli' do
    command 'pip install awscli --upgrade --user'
  end

  #ruby_block "update bash_profile" do
  #	fe = Chef::Util::FileEdit.new("/root/.bash_profile")
  #	fe.insert_line_if_no_match(/PATH=$PATH:$HOME/bin/, "PATH=$PATH:$HOME/bin:~/.local/bin:$PATH")
  #end
end

