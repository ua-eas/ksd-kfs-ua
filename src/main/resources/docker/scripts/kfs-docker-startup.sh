#!/bin/bash

# create file to save startup information
touch /tmp/kfs-startup.log

# copy in tomcat platform configuration files
cp $TOMCAT_CONFIGURATION_DIRECTORY/server.xml $TOMCAT_CONF_DIRECTORY
cp $TOMCAT_CONFIGURATION_DIRECTORY/tomcat-users.xml $TOMCAT_CONF_DIRECTORY
cp $TOMCAT_CONFIGURATION_DIRECTORY/tomcat7 $TOMCAT_STARTUP_CONFIG

# start required services
/etc/init.d/tomcat7 start >> /tmp/kfs-startup.log

tail -f /tmp/kfs-startup.log

exit 0
