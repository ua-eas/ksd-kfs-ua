#!/bin/bash

# create file to save startup information
touch /tmp/kfs-startup.log

# copy in tomcat platform configuration files
cp $TOMCAT_CONFIGURATION_DIRECTORY/server.xml /var/lib/tomcat7/conf
cp $TOMCAT_CONFIGURATION_DIRECTORY/tomcat-users.xml /var/lib/tomcat7/conf
cp $TOMCAT_CONFIGURATION_DIRECTORY/tomcat7 /etc/default/tomcat7

# start required services
/etc/init.d/tomcat7 start >> /tmp/kfs-startup.log

tail -f /tmp/kfs-startup.log

exit 0
