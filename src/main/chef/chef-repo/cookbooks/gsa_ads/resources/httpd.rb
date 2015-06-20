#
# Cookbook Name:: gsa_ads
# Resource:: httpd
#
# Copyright:: 2015, Aquilent, Inc.

actions :install

attribute :name, :kind_of => String, :name_attribute => true
attribute :doc_root, :kind_of => String, :default => nil
attribute :listen_ports, :kind_of => Array, :default => %w[80]
attribute :modules_default, :kind_of => Array, :default => nil
attribute :modules_no_config, :kind_of => Array, :default => nil
attribute :modules_custom_config, :kind_of => Array, :default => nil
attribute :modules_disabled, :kind_of => Array, :default => nil
