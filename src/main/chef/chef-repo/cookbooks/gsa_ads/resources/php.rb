#
# Cookbook Name:: gsa_ads
# Resource:: php
#
# Copyright 2015, Aquilent, Inc.  All rights reserved.
# See https://github.com/Aquilent/drug-adverse-event-browser/blob/test/LICENSE.txt

actions :install

attribute :name, :kind_of => String, :name_attribute => true
attribute :packages, "kind_of" => Array, :default => nil
attribute :pear_packages, "kind_of" => Array, :default => nil
attribute :pear_channels, "kind_of" => Array, :default => nil
