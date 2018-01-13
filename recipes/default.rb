#
# Cookbook:: go_chef
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'tar'

node.default['go']['platform'] = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
node.default['go']['filename'] = "go#{node['go']['version']}.#{node['os']}-#{node['go']['platform']}.tar.gz"
node.default['go']['url'] = "https://golang.org/dl/#{node['go']['filename']}"

directory "/projects/" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end


# execute 'print_stuff' do
#   command "echo #{node.default['go']['url']}"
# end

# execute 'print_stuff' do
#   command "echo #{node.default['go']['platform']}"
# end

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

# file '/etc/profile.d/path.sh' do
#   content 'export PATH=$PATH:/usr/local/go/bin'
#   mode '0755'
# end

directory '/projects/bin'
directory '/projects/pkg'
directory '/projects/src'

# directory '/projects/bin' do
#   owner 'root'
#   group 'root'
#   mode '0755'
#   action :create
# end
#
# directory '/projects/pkg' do
#   owner 'root'
#   group 'root'
#   mode '0755'
#   action :create
# end
#
# directory '/projects/src' do
#   owner 'root'
#   group 'root'
#   mode '0755'
#   action :create
# end

unless File.exist?('/etc/profile.d/path.sh')
  file '/etc/profile.d/path.sh'
  ruby_block "profile.d" do
    block do
      line = 'export PATH=$PATH:/usr/local/go/bin'
      file = Chef::Util::FileEdit.new("/etc/profile.d/path.sh")
      file.insert_line_if_no_match("/#{line}/", "export PATH=$PATH:/usr/local/go/bin")
      file.write_file
    end
  end
end

template "/etc/profile.d/path.sh" do
  source 'path.sh.erb'
  not_if { File.exist?('/etc/profile.d/path.sh') }
end

# default['go']['gopath'] = '/projects/src'
# default['go']['gobin']

bash 'modify bash_profile' do
  code <<-EOH
    echo "export GOBIN=#{node.default['go']['gobin']}" >> #{node.default['system']['home']}/.bash_profile
    echo "export GOPATH=#{node.default['go']['gopath']}" >> #{node.default['system']['home']}/.bash_profile
    EOH
end

# bash 'source setup files' do
#   code <<-EOH
#     echo "export GOBIN=#{node.default['go']['gobin']}" >> #{node.default['system']['home']}/.bash_profile
#     echo "export GOPATH=#{node.default['go']['gopath']}" >> #{node.default['system']['home']}/.bash_profile
#     EOH
# end

# ENV['GOPATH'] = "#{node.default['go']['gopath']}"


# ruby_block "bash_profile add" do
#   block do
#     line1 = 'export GOBIN="$HOME/projects/bin"'
#     line2 = 'export GOPATH="$HOME/projects/src"'
#     file = Chef::Util::FileEdit.new(Dir.home + "/.bash_profile")
#     file.insert_line_if_no_match("/#{line1}/", "#{line1}")
#     file.insert_line_if_no_match("/#{line2}/", "#{line2}")
#     file.write_file
#   end
# end


# ENV['PATH'] = '$PATH:/usr/local/go/bin'
# ENV['GOBIN'] = '$HOME/projects/bin'
# ENV['GOPATH'] = '$HOME/projects/src'

# env 'PATH' do
#   value '$PATH:/usr/local/go/bin'
# end
#
# env 'GOBIN' do
#   value '$HOME/projects/bin'
# end
#
# env 'GOPATH' do
#   value '$HOME/projects/src'
# end

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
