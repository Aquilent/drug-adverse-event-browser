#
# Cookbook Name:: gsa_ads
# Provider:: php
#
# Copyright:: 2015, Aquilent, Inc
#

def whyrun_supported?
  false
end

PHP_DEFAULT_PACKAGES = %w[php php-cli php-pear]
PHP_WEBTATIC_PACKAGES = %w[php54w php54w-devel php54w-cli php54w-pear]
WEBTATIC_REPO = "rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm"

action :install do
    platform_php_install(run_context, new_resource.name, new_resource.packages,
        new_resource.pear_packages, new_resource.pear_channels)
end

def platform_php_install (context, name, packages, pear_packages, pear_channels)

    has_php54 = (node['platform_family'] == 'rhel') && (node['platform_version'].to_f >= 7)

    if has_php54 then
        node.default['php']['packages'] = PHP_DEFAULT_PACKAGES
    else 
        ruby_block "install-webtatic-repo" do
            block do
                do_bash("install-repo", WEBTATIC_REPO)
            end
        end
        node.default['php']['packages'] = PHP_WEBTATIC_PACKAGES

        if !packages.nil? then
            packages = packages.map! { |s| s.gsub(/^php/, "php54w") }
            Chef::Log.info("PHP packages to install renamed to [#{packages}]")
        end

    end

    context.include_recipe "php"

    # if !has_php54 then
    #     ruby_block "replace-php-with_webtatic-php" do
    #         block do
    #             do_bash("install-replace-plugin", "yum install -y yum-plugin-replace")
    #             do_bash("replace-php-common", "yum replace -y php-common --replace-with=php54w-common")
    #         end
    #     end
    # end

    install_packages(packages)

    override_template("#{node['php']['conf_dir']}/php.ini", "php.ini.erb") do
        recipe_name "#{name}"
    end

    if !pear_packages.nil? then
        pear_packages.each do |package_name|
            php_pear "#{package_name}" do
              action :install
            end
        end
    end

    if !pear_channels.nil? then
        pear_channels.each do |channel_name|
            php_pear_channel "#{channel_name}" do
              action :discover
            end
        end
    end

end


