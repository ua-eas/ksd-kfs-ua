docker run -d --h <myhostname> --name kfs-docker \
-e TOMCAT_CONFIGURATION_DIRECTORY=/var/local/kfs/tomcat-config/local \
-e KFS_ADDITIONAL_CONFIG_LOCATIONS=/var/local/kfs/config/local/uaf-kfs-config.properties,/var/local/kfs/config/local/uaf-rice-config.properties,/var/local/kfs/config/local/uaf-security-config.properties \
-v /var/local/kfs:/var/local/kfs \
-p 127.0.0.1:8080:8080 rbtucker/kfs-container:UAF-6.0 /usr/local/bin/kfs-docker-startup.sh

