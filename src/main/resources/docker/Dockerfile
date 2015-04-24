# this is the dockerfile that builds the uaf-overlay container
FROM uaksd/kuali-applications:ksd-uaf-base-0.1

# copy in the kfs build and utility scripts
COPY kfs-build /var/opt/kuali/tomcat/latest-tomcat/webapps
COPY scripts /

# create some useful shorcut environment variables
ENV TOMCAT_KFS_DIR=/var/opt/kuali/tomcat/latest-tomcat/webapps/kfs
ENV TOMCAT_KFS_WEBINF_DIR=/var/opt/kuali/tomcat/latest-tomcat/webapps/kfs/WEB-INF
ENV TRANSACTIONAL_DIRECTORY=/transactional
ENV CONFIG_DIRECTORY=/configuration
ENV LOGS_DIRECTORY=/transactional/logs
ENV TOMCAT_CONFIG_DIRECTORY=/configuration/tomcat-config
ENV KFS_CONFIG_DIRECTORY=/configuration/config





