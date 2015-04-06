FROM rbtucker/kfs-container:base

COPY dev /var/lib/tomcat7/webapps
COPY scripts /

ENV TOMCAT_CONFIGURATION_DIRECTORY=/var/local/kfs/config/tomcat-config/dev

# install the admin app in local mode 
RUN apt-get install tomcat7-admin 

EXPOSE 8080
