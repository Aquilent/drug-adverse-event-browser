#!/bin/sh

cd /var/tmp/gsa-ads
chmod 777 ./chef/bin/*.sh
./chef/bin/install-chef.sh
./chef/bin/run-chef.sh ./chef-config.json --yum-suppress --log-stdout
if [ "$?" != "0" ]; then
     echo "Chef provisioning failed" 1>&2
     exit 1
fi
/opt/gsa-ads/bin/stop-services
cp -rf ./php/* /var/www/gsa-ads/
/opt/gsa-ads/bin/install-php-composer
if [ "$?" != "0" ]; then
     echo "Failed to install PHP Composer" 1>&2
     exit 2
fi
/opt/gsa-ads/bin/set-permissions

yum install -y python-pip
if [ "$?" != "0" ]; then
     echo "Failed to install python-pip" 1>&2
     exit 1
fi
pip install supervisor
easy_install supervisor

