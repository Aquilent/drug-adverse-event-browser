#
# Cookbook Name:: gsa_ads
# Recipe:: bastion
#
# Copyright 2015, Aquilent, Inc.  2015, Aquilent, Inc.
#
# All rights reserved - Do Not Redistribute
#


#------------------------------------------------------------------------------
#             Install rsynch
#------------------------------------------------------------------------------

include_recipe "rsync"

#------------------------------------------------------------------------------
#             Install Apache
#------------------------------------------------------------------------------

gsa_ads_httpd "bastion" do
    #modules_default %w[mod_auth_basic]
    modules_no_config %w[proxy]
    modules_custom_config %w[proxy_http]
    action :install
end


#------------------------------------------------------------------------------
#             Install life-cycle management
#------------------------------------------------------------------------------

package "git" do
end

[ "manage-code", "synchronize", "setup-jenkins", "setup-jenkins-credentials" ].each do |name|
  gsa_ads_platform "#{name}" do
      template_source_dir "bastion/platform/bin"
      action :install_binary
  end
end

[ "manage.conf" ].each do |name|
  gsa_ads_platform "#{name}" do
      template_source_dir "bastion/platform/conf"
      action :install_configuration
  end
end


#------------------------------------------------------------------------------
#             Install Jenkins
#------------------------------------------------------------------------------

node.default['jenkins']['master']['install_method'] = 'package'

include_recipe "jenkins::java"
include_recipe "jenkins::master"

#jenkins_user "jenkins-admin" do
#end

%w[int test prod].each do |env|

  config_file = File.join(Chef::Config[:file_cache_path], "deploy-#{env}.xml")
  template config_file do
    source "bastion/jenkins/deploy-#{env}.xml.erb"
  end

  jenkins_job "deploy-to-#{env}" do
    config config_file
    action :create
  end

end  
