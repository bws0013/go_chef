resource_name :go
property :name   , String, name_property: true
property :version, String, default: '1.9.2'
property :platform,String, default: node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
property :url, [String, NilClass], default: nil
property :install_dir, String, default: '/usr/local/'
property :project_dir, [String, NilClass], default: nil
property :gopath, String, default: "go/src"
property :gobin,  String, default: "go/bin"
property :perms,  String, default: "0777"

default_action :install
action :install do
  include_recipe 'tar'
  include_recipe 'git::default'

  unless new_resource.project_dir.nil?
    directory new_resource.project_dir do
      owner 'root'
      group 'root'
      mode  '0755'
      action :create
    end
  end

  if new_resource.url.nil?
    Chef::Log.warn('Default Link for GoLang will be used as it was not explicitely set.')
    new_resource.url = "https://golang.org/dl/go#{new_resource.version}.#{node['os']}-#{new_resource.platform}.tar.gz"
  end
  tar_extract new_resource.url do
    target_dir new_resource.install_dir
  end

  [new_resource.gopath, new_resource.gobin, 'pkg'].each do |dir|
    directory "#{new_resource.install_dir}#{dir}" do
      mode new_resource.perms
      recursive true
      action :create
    end
  end

  template "/etc/profile.d/path.sh" do
    source 'path.sh.erb'
    cookbook 'go_chef'
    variables ({installpath: new_resource.install_dir + "go/bin",
               golang_path:  new_resource.install_dir + new_resource.gopath,
               golang_bin:   new_resource.install_dir + new_resource.gobin})
    not_if { ::File.exist?('/etc/profile.d/path.sh') }
  end
end
