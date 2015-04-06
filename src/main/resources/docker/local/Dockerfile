FROM rbtucker/kfs-container:base

COPY local /var/lib/tomcat7/webapps
COPY scripts /

# install the admin app in local mode 
RUN apt-get install tomcat7-admin 

EXPOSE 8080
