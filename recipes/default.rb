#
# Cookbook:: go_chef
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'tar'

node.default['go']['platform'] = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
node.default['go']['filename'] = "go#{node['go']['version']}.#{node['os']}-#{node['go']['platform']}.tar.gz"
node.default['go']['url'] = "https://golang.org/dl/#{node['go']['filename']}"

execute 'print_stuff' do
  command "echo #{node.default['go']['url']}"
end

execute 'print_stuff' do
  command "echo #{node.default['go']['platform']}"
end

# if node.default['go']['from_source'] == false
#   directory "#{node['go']['install_dir']}/go" do
#     action :delete
#     recursive true
#   end
# end

# remote_file "/tmp/#{node.default['go']['filename']}" do
#   source "#{node.default['go']['url']}"
#   mode '0755'
#   action :create
# end

tar_extract "#{node.default['go']['url']}" do
  target_dir '/usr/local'
end

# bash "install-golang" do
#   cwd Chef::Config[:file_cache_path]
#   code <<-EOH
#     rm -rf go
#     rm -rf #{node['go']['install_dir']}/go
#     tar -C #{node['go']['install_dir']} -xzf #{node['go']['filename']}
#   EOH
#   not_if { node['go']['from_source'] }
#   action :nothing
# end
