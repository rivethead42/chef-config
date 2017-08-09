#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'sshd::default'
include_recipe 'cloudcli::default'

execute 'echo "stop sshd" >> /root/chef.log' do end
service 'sshd' do
  action :stop
end

execute 'echo "install git" >> /root/chef.log' do end
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
  execute 'echo "install docker" >> /root/chef.log' do end
  package 'docker'

  execute 'echo "start  docker service" >> /root/chef.log' do end
  service 'docker' do
    action :start
  end

  execute 'echo "python2-pip" >> /root/chef.log' do end
  package 'python2-pip'

  #execute 'echo "get pip" >> /root/chef.log' do end
  #execute 'curl-get-pip' do
  #  command 'curl -O https://bootstrap.pypa.io/get-pip.py'
  #end

  #execute 'echo "install get-pip" >> /root/chef.log' do end
  #execute 'get-pip' do
  #  command 'python get-pip.py --user'
  #end

  #execute 'echo "pip install awscli" >> /root/chef.log' do end
  #execute 'awscli' do
  #  command 'pip install awscli --upgrade --user'
  #end

  #execute 'echo "update path in .bash_profile" >> /root/chef.log' do end
  #execute 'Update Path' do
  #  command 'echo "PATH=~/.local/bin:\$PATH" >> /root/.bash_profile && echo "export PATH" >>  /root/.bash_profile'
  #end
end

execute 'echo "install photo-filter" >> /root/chef.log' do end
execute 'install photo-filter' do
  command 'docker pull cloudassessmentscom/photo-filter'
end

execute 'echo "install photo-storage" >> /root/chef.log' do end
execute 'install photo-storage' do
  command 'docker pull cloudassessmentscom/photo-storage'
end

execute 'echo "install web-client" >> /root/chef.log' do end
execute 'install web-client' do
  command 'docker pull cloudassessmentscom/web-client'
end

execute 'echo "start sshd" >> /root/chef.log' do end
service 'sshd' do
  action :start
end
