#!/bin/bash

# create file to save startup information
touch /tmp/kfs-startup.log

# load the platform-specific properties
source $PLATFORM_CONFIGURATION_FILE

# if required create external directory structure
if [ -e $SECURITY_DIRECTORY/$ENVIRONMENT/dir-structure.sh ]; then
    source $SECURITY_DIRECTORY/$ENVIRONMENT/dir-structure.sh
fi

# update configuration files for platform from dynamically loaded environment above
envsubst < $TOMCAT_CONFIG_DIRECTORY/$ENVIRONMENT/logging.properties > $TOMCAT_CONF/logging.properties
envsubst < $TOMCAT_CONFIG_DIRECTORY/$ENVIRONMENT/tomcat7 > /etc/default/tomcat7
envsubst < $TOMCAT_WEB_INF/configuration-templates/configuration.properties > $TOMCAT_WEB_INF/classes/configuration.properties
envsubst < $TOMCAT_WEB_INF/configuration-templates/kfs-RiceDataSourceSpringBeans.xml > $TOMCAT_WEB_INF/classes/kfs-RiceDataSourceSpringBeans.xml
envsubst < $TOMCAT_WEB_INF/configuration-templates/spring-ldap.xml > $TOMCAT_WEB_INF/classes/spring-ldap.xml
envsubst < $TOMCAT_WEB_INF/configuration-templates/web.xml > $TOMCAT_WEB_INF/web.xml
envsubst < $TOMCAT_WEB_INF/configuration-templates/log4j.properties > $TOMCAT_WEB_INF/classes/log4j.properties

# copy in tomcat platform configuration files
cp $TOMCAT_CONFIG_DIRECTORY/$ENVIRONMENT/server.xml $TOMCAT_CONF
cp $TOMCAT_CONFIG_DIRECTORY/$ENVIRONMENT/tomcat-users.xml $TOMCAT_CONF

# add custom users and groups
if [ -e $SECURITY_DIRECTORY/$ENVIRONMENT/users-groups.sh ]; then
    source $SECURITY_DIRECTORY/$ENVIRONMENT/users-groups.sh
fi

echo '=============================================================' >>  /tmp/kfs-startup.log
echo 'configuration file: ' $PLATFORM_CONFIGURATION_FILE >> /tmp/kfs-startup.log
echo 'platform: ' $ENVIRONMENT  >> /tmp/kfs-startup.log
echo 'logs directory: ' $LOGS_DIRECTORY'/'$ENVIRONMENT >>  /tmp/kfs-startup.log
echo 'batch directory: ' $BATCH_DIRECTORY'/'$ENVIRONMENT >>  /tmp/kfs-startup.log
echo 'attachments directory: ' $ATTACHMENTS_DIRECTORY'/'$ENVIRONMENT >>  /tmp/kfs-startup.log
echo 'security directory: ' $SECURITY_DIRECTORY'/'$ENVIRONMENT >>  /tmp/kfs-startup.log
echo '=============================================================' >>  /tmp/kfs-startup.log

# start required services
/etc/init.d/tomcat7 start >> /tmp/kfs-startup.log

tail -f /tmp/kfs-startup.log

exit 0
