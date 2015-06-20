#
# Cookbook Name:: gsa_ads
# Attributes:: platform
#
# Copyright 2014-2015, Aquilent, Inc.
#
# All rights reserved - Do Not Redistribute
#

default['gsa_ads']['architecture'] = 'x86_64'
default['gsa_ads']['home_dir'] = "/opt/gsa-ads"
default['gsa_ads']['iptables']['enabled'] = true
default['gsa_ads']['epel_repo']['file_name'] = 'epel-release-6-8.noarch.rpm'
default['gsa_ads']['epel_repo']['url'] = 
    'http://download.fedoraproject.org/pub/epel/6/x86_64'
default['gsa_ads']['yum_extra_repo_names']['redhat']['rhel_server_releases_optional'] = 
    'rhui-REGION-rhel-server-releases-optional'

