FROM kfs-container:base

# setup tomcat7 authbind so we can use port 80
RUN touch /etc/authbind/byport/80
RUN chmod 500 /etc/authbind/byport/80
RUN chown tomcat7 /etc/authbind/byport/80

EXPOSE 22

COPY dev  /var/lib/tomcat7/webapps

ENTRYPOINT $STARTUP_SCRIPT
