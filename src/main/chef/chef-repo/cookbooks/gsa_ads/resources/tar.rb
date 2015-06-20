#
# Cookbook Name:: gsa_ads
# Resource:: tar
#
# Copyright:: 2015, Aquilent, Inc.

actions :unpack

attribute :name, :kind_of => String, :name_attribute => true
attribute :source, :kind_of => String
attribute :destination, :kind_of => String
attribute :owner, :kind_of => String, :default => 'root'
attribute :group, :kind_of => String, :default => 'root'
attribute :mode, :kind_of => String, :default => "600"
attribute :extension, :kind_of => String, "default" => "tar.gz"
attribute :options, :kind_of => String, :default => ""

