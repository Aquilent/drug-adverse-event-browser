# GSA Prototype
#
# VERSION 1.0

FROM centos:6.6
MAINTAINER Aquilent

LABEL Description="Installs Drug Reaction Finder web server" Vendor="Aquilent, Inc." Version="1.0"

WORKDIR /var/tmp/gsa-ads
ADD chef/ ./chef/
ADD php/ ./php/
ADD bootstrap.sh ./bootstrap.sh
RUN chmod 777 ./bootstrap.sh
RUN ./bootstrap.sh
VOLUME ["/var/www/gsa-ads"]

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
