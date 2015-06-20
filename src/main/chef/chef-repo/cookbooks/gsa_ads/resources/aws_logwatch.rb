#
# Cookbook Name:: gsa_ads
# Resource:: aws_logwatch
#
# Copyright:: 2014-2015, Aquilent, Inc.

actions :install
default_action :install

attribute :name, :kind_of => String, :name_attribute => true
attribute :region, :kind_of => String, :default => 'us-east-1'
attribute :log_group, :kind_of => String
attribute :files, :kind_of => Hash, :default => nil

