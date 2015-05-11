docker -H tcp://127.0.0.1:2375 run -d --name kfs-docker \
    -v <my-configuration-parent-directory>/configuration:/configuration \
    -v <my-security-parent-directory>/security:/security \
    -v <my-transactional-parent-directory>/transactional:/transactional:rw \
    -v <my-logs-parent-directory>/transactional:/logs:rw \
    -v <my-maven-kfs-build-target-directory>/docker/kfsbuild:/var/opt/kuali/tomcat/latest-tomcat/webapps:rw \
    -p 8080:8080 uaksd/kuali-applications:ksd-uaf-6.0.0-build1 tomcat-start

