#
# Cookbook Name:: gsa_ads
# Recipe:: aws_codedeploy
#
# Copyright 2015, Aquilent, Inc.
#
# All rights reserved - Do Not Redistribute
#

PROJECT_NAME = node['gsa_ads']['project_name']
ENVIRONMENT = node['gsa_ads']['environment']
SERVER_TYPE=node['gsa_ads']['server_type']

gsa_ads_aws_codedeploy "codedeploy-agent" do
end

