default['system']['home'] = '/home/vagrant'
default['go']['version'] = '1.9.2'
default['go']['platform'] = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
default['go']['filename'] = "go#{node['go']['version']}.#{node['os']}-#{node['go']['platform']}.tar.gz"
default['go']['from_source'] = false
default['go']['url'] = "https://golang.org/dl/#{node['go']['filename']}"
default['go']['install_dir'] = '/usr/local/go/bin'
default['go']['gopath'] = '/projects/src'
default['go']['gobin'] = '/projects/bin'
default['go']['scm'] = true
default['go']['packages'] = []
default['go']['owner'] = 'root'
default['go']['group'] = 'root'
default['go']['mode'] = 0755
