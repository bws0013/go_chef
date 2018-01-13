#
# Cookbook:: go_chef
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'tar'
include_recipe 'git'

node.default['go']['platform'] = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
node.default['go']['filename'] = "go#{node['go']['version']}.#{node['os']}-#{node['go']['platform']}.tar.gz"
node.default['go']['url'] = "https://golang.org/dl/#{node['go']['filename']}"

git_client 'default' do
  action :install
end

directory "/projects/" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

if node.default['go']['override_url']
  tar_extract "#{node.default['go']['alternate_url']}" do
    target_dir '/usr/local'
  end
else
  tar_extract "#{node.default['go']['url']}" do
    target_dir '/usr/local'
  end
end

directory "#{node.default['go']['project_home']}/src" do
  mode '0777'
  recursive true
end
directory "#{node.default['go']['project_home']}/bin" do
  mode '0777'
  recursive true
end
directory "#{node.default['go']['project_home']}/pkg" do
  mode '0777'
  recursive true
end

template "/etc/profile.d/path.sh" do
  source 'path.sh.erb'
  not_if { File.exist?('/etc/profile.d/path.sh') }
end
