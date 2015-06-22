name             'gsa_ads'
maintainer       'Aquilent'
license          'All rights reserved'
description      'Installs/Configures GSA ADS prototype'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ centos redhat }.each do |os|
  supports os
end

depends "selinux"
depends "apache2"
depends "iptables"
depends "jenkins"
depends "php"
depends "rsync"
depends "varnish"
depends "yum-mysql-community"

recipe 'gsa_ads::platform', 'Install /op/gsa-ads'
recipe 'gsa_ads::varnish', 'Install a standard Varnish webserver'
recipe 'gsa_ads::aws_codedeploy', 'Install AWS CodeDeploy agent'
recipe 'gsa_ads::aws_logwatch', 'Install AWS CloudWatch aws_logwatch service and configuration'
recipe 'gsa_ads::bastion', 'Install bastion server as a proxy for shared services'


