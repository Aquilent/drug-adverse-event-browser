#
# Varnish webserver attributes
#
# Setting the following attribute triggers the addition of the X-Server
# header in the response to allow identification of the responding server
# when using a load balancer.
# The default (empty string) does NOT add the header

default['gsa_ads']['server_type'] = "web"

default['gsa_ads']['webserver']['application_home'] = '/var/www/gsa-ads';
