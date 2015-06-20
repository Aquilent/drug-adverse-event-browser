#
# Cookbook Name:: gsa_ads
# Recipe:: aws_logwatch
#
# Copyright 2014-2015, Aquilent, Inc.
#
# All rights reserved - Do Not Redistribute
#

PROJECT_NAME = node['gsa_ads']['project_name']
ENVIRONMENT = node['gsa_ads']['environment']
SERVER_TYPE=node['gsa_ads']['server_type']

logwatch_files = node['gsa_ads']['aws_logwatch']['default_files']
files = node['gsa_ads']['aws_logwatch']['files']
logwatch_files = logwatch_files.merge(files) if !files.nil?

gsa_ads_aws_logwatch "#{SERVER_TYPE}" do
    region node['gsa_ads']['aws_region']
    log_group node['gsa_ads']['aws_logwatch']['log_group']
    files logwatch_files 
end

