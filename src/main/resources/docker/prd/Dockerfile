FROM kfs-container:base

# setup tomcat7 authbind so we can use port 80
RUN touch /etc/authbind/byport/80
RUN chmod 500 /etc/authbind/byport/80
RUN chown tomcat7 /etc/authbind/byport/80

COPY prd  /var/lib/tomcat7/webapps

EXPOSE 22

ENTRYPOINT $STARTUP_SCRIPT
