# GSA Prototype
#
# VERSION 1.0

FROM centos:6.6
MAINTAINER Aquilent

LABEL Description="Installs Drug Reaction Finder web server" Vendor="Aquilent, Inc." Version="1.0"

RUN mkdir -p /var/tmp/gsa-ads/php
RUN mkdir -p /var/tmp/gsa-ads/chef
WORKDIR /var/tmp/gsa-ads
ADD php/ ./php/
ADD chef-config.json ./chef-config.json
ADD chef/ ./chef/
ADD php/ ./php/
ADD bootstrap.sh ./bootstrap.sh
RUN chmod 777 ./bootstrap.sh
RUN ./bootstrap.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
