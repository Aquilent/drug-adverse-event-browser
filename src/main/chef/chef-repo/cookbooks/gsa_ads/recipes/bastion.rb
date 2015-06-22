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
#             Install life-cycle management
#------------------------------------------------------------------------------

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
