#
# Cookbook Name:: gsa_ads
# Provider:: aws_codedeploy
#
# Copyright:: 2015, Aquilent, Inc
#

def whyrun_supported?
  false
end

action :install do
   platform_install(run_context, new_resource.name)
end

def platform_install (context, name)

    remote_file "#{Chef::Config[:file_cache_path]}/codedeploy-agent.rpm" do
        source "#{node['gsa_ads']['aws_codedeploy']['installer']['url']}"
    end

    package "codedeploy-agent" do
        action :install
        source "#{Chef::Config[:file_cache_path]}/codedeploy-agent.rpm"
    end

    service "codedeploy-agent" do
        action [:enable, :start]
    end

end
