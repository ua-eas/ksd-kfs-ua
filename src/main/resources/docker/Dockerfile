# this is the dockerfile that build the uaf-overlay container
FROM rbtucker/kfs-container:base

COPY kfs-build /var/lib/tomcat7/webapps
COPY scripts /

ENV TOMCAT_WEBAPPS=/var/lib/tomcat7/webapps
ENV TOMCAT_CONF=/var/lib/tomcat7/conf
ENV KFS_WEBINF=/var/lib/tomcat7/webapps/kfs/WEB-INF
ENV KFS_WEBINF_CLASSES=/var/lib/tomcat7/webapps/kfs/WEB-INF/classes

# install the admin app in local mode 
RUN apt-get install tomcat7-admin 

EXPOSE 8080
