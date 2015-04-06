FROM ubuntu

# Update Ubuntu
RUN apt-get update && apt-get -y upgrade

# install some utility apps we might use
RUN apt-get install vim -y
RUN apt-get install gettext-base -y

# Install oracle java 7 
#=======================================================================
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN apt-get install oracle-java7-installer -y

# Install tomcat
#=======================================================================
RUN apt-get -y install tomcat7

# setup some environment variables
ENV TOMCAT_CONF_DIRECTORY=/var/lib/tomcat7/conf
ENV TOMCAT_STARTUP_CONFIG=/etc/default/tomcat7
