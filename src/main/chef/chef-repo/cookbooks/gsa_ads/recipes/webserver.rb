#
# Cookbook Name:: gsa_ads
# Recipe:: varnish
#
# Copyright 2014-2015, Aquilent, Inc.
#
# All rights reserved - Do Not Redistribute
#

require "rubygems"
require "active_support/core_ext/object/blank"

#------------------------------------------------------------------------------
#             Install rsynch
#------------------------------------------------------------------------------

include_recipe "rsync"

#------------------------------------------------------------------------------
#             Install PHP
#------------------------------------------------------------------------------

gsa_ads_php "webserver" do
    packages %w[php-mbstring php-gd php-pdo php-dom php-mysql php-devel]
    #pear_packages %w[uploadprogress]
    pear_channels %w[pear.drush.org]
    action :install
end

#------------------------------------------------------------------------------
#             Install Apache
#------------------------------------------------------------------------------

WEBSERVER = node['gsa_ads']['webserver']
if !isBlank(WEBSERVER['application_home']) then
  node.force_override['apache']['docroot_dir'] = WEBSERVER['application_home'] 
end
APPLICATION_HOME=node['apache']['docroot_dir']

gsa_ads_httpd "webserver" do
    listen_ports %w[8080]
    doc_root APPLICATION_HOME
    modules_default %w[dir expires rewrite]
    action :install
end

template "#{APPLICATION_HOME}/index.html" do
    source "webserver/index.html.erb"
    owner node['apache']['user']
    group node['apache']['group']
    mode '0755'
end

[ "start-services", "stop-services", "verify-services", "set-permissions"].each do |name|
  drupal_platform_platform "#{name}" do
      template_source_dir "webserver/platform/bin"
      action :install_binary
  end
end

#------------------------------------------------------------------------------
#             Install Varnish
#------------------------------------------------------------------------------

# override standard Varnish attributes
node.default['varnish']['storage'] = 'malloc';
case node[:platform_family]
when "rhel"
    node.default['varnish']['dir']     = "/etc/varnish"
    node.default['varnish']['default'] = "/etc/sysconfig/varnish"
end
node.default['varnish']['version'] = '3.0';
node.default['varnish']['listen_port'] = '80';

include_recipe "varnish"

override_template "#{node['varnish']['dir']}/#{node['varnish']['vcl_conf']}" do
    recipe_name "varnish"
end

template "#{node['varnish']['dir']}/no_cache.vcl" do
    source "varnish/no_cache.vcl.erb"
    owner node['varnish']['user']
    group node['varnish']['group']
end

