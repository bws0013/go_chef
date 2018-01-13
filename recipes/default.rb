#
# Cookbook:: go_chef
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

node.default['go']['platform'] = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
node.default['go']['filename'] = "go#{node['go']['version']}.#{node['os']}-#{node['go']['platform']}.tar.gz"
node.default['go']['url'] = "https://golang.org/dl/#{node['go']['filename']}"

execute 'print_stuff' do
  command "echo #{node.default['go']['url']}"
end
