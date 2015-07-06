#!/bin/sh

if [ -d //var/www/gsa-ads ]; then 
   mkdir -p /var/www/gsa-ads
fi

docker run -d -p 80:80 prototype