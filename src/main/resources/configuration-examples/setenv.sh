CATALINA_OPTS="-Dadditional.kfs.config.locations=$KFS_CONFIG_DIRECTORY/uaf-kfs-config.properties,$KFS_CONFIG_DIRECTORY/uaf-rice-config.properties,$KFS_CONFIG_DIRECTORY/uaf-security-config.properties -Dnewrelic.environment=dev -javaagent:/var/opt/kuali/tomcat/ksd/newrelic/newrelic.jar"
export CATALINA_OPTS

CATALINA_PID="/transactional/catalina.pid"
export CATALINA_PID

JAVA_OPTS="-Xmx1g -Xms512m -XX:PermSize=128m -XX:MaxPermSize=256m -XX:NewSize=128m -XX:MaxNewSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:SurvivorRatio=128 -XX:MaxTenuringThreshold=0 -XX:+UseTLAB -XX:+CMSClassUnloadingEnabled -Dsun.io.serialization.extendedDebugInfo=true -Doracle.net.CONNECT_TIMEOUT=10000 -Djava.awt.headless=true -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false -Dorg.terracotta.quartz.skipUpdateCheck=true -Dlogs.dir=$LOGS_DIRECTORY -DTOMCAT_DIR=/var/lib/tomcat7 -Dcatalina.base=/var/lib/tomcat7 -Dcatalina.home=/var/lib/tomcat7 -Djava.io.tmpdir=/var/lib/tomcat7/temp -Djava.util.logging.config.file=/var/lib/tomcat7/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Dadditional.kfs.config.locations=$KFS_ADDITIONAL_CONFIG_LOCATIONS -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,suspend=n,server=y"
export JAVA_OPTS
