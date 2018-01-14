name 'go_chef'
maintainer 'github:bws0013'
maintainer_email 'Post issues on github'
license 'Apache License'
version '1.0.0'
supports 'centos'
chef_version '>= 12.1' if respond_to?(:chef_version)
source_url 'https://github.com/bws0013/go_chef'
issues_url 'https://github.com/bws0013/go_chef/issues'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/go_chef/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/go_chef'

depends 'tar', '~> 2.1.1'
depends 'git', '~> 8.0.0'
