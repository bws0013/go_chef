name 'go_chef'
maintainer 'github:bws0013'
maintainer_email 'Post issues on github'
license 'Apache-2.0'
description 'Installs/Configures golang'
version '1.0.3'

source_url 'https://github.com/bws0013/go_chef'
issues_url 'https://github.com/bws0013/go_chef/issues'

supports 'centos'
supports 'debian'
supports 'ubuntu'

chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'tar', '~> 2.1.1'
depends 'git', '~> 8.0.0'
