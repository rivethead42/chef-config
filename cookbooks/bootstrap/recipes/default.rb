#
# Cookbook:: bootstrap
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'sshd::default'
include_recipe 'cloudcli::default'

service 'sshd' do
  action :stop
end

package 'git'

if node['platform_family'] == "debian"

  user 'cloud_user' do
    home '/home/cloud_user'
    manage_home true
    shell '/bin/bash'
    password '$1$linuxaca$iGMxZ4g4lbPmfEDPhW3lw1'
    salt 'linuxacademy'
  end

  openssh_server '/etc/ssh/sshd_config' do
    PasswordAuthentication yes
  end

  package 'python-pip'
  package 'awscli'
end

if node['platform_family'] == "rhel"
  package 'docker'

  service 'docker' do
    action :start
  end

  execute 'echo "python2-pip" >> /root/chef.log' do end
  package 'python2-pip'
end

execute 'install photo-filter' do
  command 'docker pull cloudassessmentscom/photo-filter'
end

execute 'install photo-storage' do
  command 'docker pull cloudassessmentscom/photo-storage'
end

execute 'install web-client' do
  command 'docker pull cloudassessmentscom/web-client'
end

service 'sshd' do
  action :start
end
