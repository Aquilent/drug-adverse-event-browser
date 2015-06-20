#
# Cookbook Name:: gsa_ads
# Resource:: php
#
# Copyright:: 2015, Aquilent, Inc.

actions :install

attribute :name, :kind_of => String, :name_attribute => true
attribute :packages, "kind_of" => Array, :default => nil
attribute :pear_packages, "kind_of" => Array, :default => nil
attribute :pear_channels, "kind_of" => Array, :default => nil
