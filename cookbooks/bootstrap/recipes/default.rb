#
# Cookbook:: test
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

  package 'python2-pip'

  execute 'curl-get-pip' do
    command 'curl -O https://bootstrap.pypa.io/get-pip.py'
  end

  #execute 'get-pip' do
  #  command 'python get-pip.py --user'
  #end

  #execute 'awscli' do
  #  command 'pip install awscli --upgrade --user'
  #end

  #execute 'Update Path' do
  #  command 'echo "PATH=~/.local/bin:\$PATH" >> /root/.bash_profile && echo "export PATH" >>  /root/.bash_profile'
  #end

  #execute 'Source .bash_profile' do
  #  command 'source ~/.bash_profile'
  #end
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
