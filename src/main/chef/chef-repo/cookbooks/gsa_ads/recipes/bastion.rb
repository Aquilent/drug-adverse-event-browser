#
# Cookbook Name:: gsa_ads
# Recipe:: bastion
#
# Copyright 2015, Aquilent, Inc.
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
    modules_default %w[mod_auth_basic]
    modules_no_config %w[proxy]
    modules_custom_config %w[proxy_http]
    action :install
end

#------------------------------------------------------------------------------
#             Install Jenkins
#------------------------------------------------------------------------------

node.default['jenkins']['master']['install_method'] = 'package'

# include_recipe "jenkins::java"
# include_recipe "jenkins::master"

# jenkins_user "jenkins-admin" do
# end

# jenkins_password_credentials 'jenkins-admin' do
#   id 'f2361e6b-b8e0-4b2b-890b-82e85bc1a59f'
#   description 'Administartor'
#   password    'Tester1&'
# end

# deploy_int_xml = File.join(Chef::Config[:file_cache_path], 'deploy-int.xml')
# template deploy_int_xml do
#   source 'bastion/jenkins/deploy-int.xml.erb'
# end

# jenkins_job 'deploy-int' do
#   config deploy_int_xml
#   action :create
# end


#------------------------------------------------------------------------------
#             Install life-cycle management
#------------------------------------------------------------------------------

package "git" do
end

[ "manage-code", "synchronize" ].each do |name|
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
