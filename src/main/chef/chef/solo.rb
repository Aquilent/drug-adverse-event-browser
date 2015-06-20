# See https://docs.chef.io/chef_solo.html#options

solo true

file_cache_path "/var/tmp/gsa-ads/chef-solo"
cookbook_path "/var/tmp/gsa-ads/chef/chef-repo/cookbooks"
data_bag_path "/var/tmp/gsa-ads/chef/chef-repo/data_bags"
role_path "/var/tmp/gsa-ads/chef/chef-repo/roles"
environment_path "/var/tmp/gsa-ads/chef/chef-repo/environments"
force_logger true
verbose_logging true

# Set the following configuration values as arguments to run-chef.sh
# log_location 
#   description: denotes location where log output is sent
#   default: /var/log/gsa-ads/bootstrap.log
#   alternative: STDOUT (run-chef.sh argument: --log-stdout)

# log_level 
#   description: denotes level of logging
#   default: :info
#   alternative: :debug (run-chef.sh argument --log-debug)

