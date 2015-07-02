#!/bin/sh

cd /var/tmp/gsa-ads

contents=`cat <<EOH 
{
   "gsa_ads": {
      "project_name": "GSA-ADS",
      "environment": "ENVIRONMENT_NAME",
      "aws_region": "us-east1",
      "iptables": {
          "enabled": false
      },
      "webserver": {
        "use_varnish": false
      }
   },
   "run_list": [
      "recipe[gsa_ads::platform]",
      "recipe[gsa_ads::webserver]" 
   ]
}
EOH
`
echo -e "${contents}" > ./chef-config.json

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

mkdir -p /opt/gsa-ads/baseline
cp -rf /var/www/gsa-ads /opt/gsa-ads/baseline/

contents=`cat <<EOH
#!/bin/sh

if [ ! -f /var/www/gsa-ads/composer.json ]; then
    cp -rf /var/www/gsa-ads /opt/gsa-ads/baseline/
fi

/opt/gsa-ads/bin/set-permissions

source /etc/sysconfig/httpd
exec /usr/sbin/httpd

EOH
`
echo -e "${contents}" > /opt/gsa-ads/bin/run-httpd.sh
chmod 755 /opt/gsa-ads/bin/run-httpd.sh

yum install -y python-pip
if [ "$?" != "0" ]; then
     echo "Failed to install python-pip" 1>&2
     exit 1
fi
pip install supervisor
easy_install supervisor

contents=`cat <<EOH
[supervisord]
nodaemon=true

[program:httpd]
command=/bin/bash -c "/opt/gsa-ads/bin/run-httpd.sh"
EOH
`
mkdir -p /etc/supervisor/conf.d
echo -e "${contents}" > "/etc/supervisor/conf.d/supervisord.conf"

