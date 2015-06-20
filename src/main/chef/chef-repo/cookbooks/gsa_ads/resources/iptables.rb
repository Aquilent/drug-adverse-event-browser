#
# Cookbook Name:: gsa_ads
# Resource:: iptables
#
# Copyright:: 2015, Aquilent, Inc.

actions :install

attribute :name, :kind_of => String, :name_attribute => true
attribute :rules, "kind_of" => Hash
attribute :recipe, "kind_of" => String, :default => "platform"

