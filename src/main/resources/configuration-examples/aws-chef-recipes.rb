# dockerInstall.rb
#---------------------------------------------------------------------------------------
package "docker" do
    action :install
end

ruby_block "dockerConfiguration" do
    block do
        system "sudo usermod -aG docker ec2-user"
    end
    action :run
end


service "docker" do
    action :start
end

# dockerDeploy.rb
#---------------------------------------------------------------------------------------
require 'aws-sdk'

hostname = node[:opsworks][:instance][:hostname]
region = node[:opsworks][:instance][:region]

# pull kfs-config.zip from s3 and extract for configuration setup
ruby_block "loadKfsConfiguration" do
    block do
        Chef::Log.info("load kfs configuration from s3")
        system "aws s3 cp --region #{region} s3://#{node["s3bucket"]}/kfs-config.zip /tmp"
        system "unzip -o /tmp/kfs-config.zip -d /var/local"
        system "chmod -R 777 /var/local/kfs"

        # create script to get into the kfs-docker instance
        system "touch /usr/local/bin/docex.sh"
        system "echo 'docker exec -i -t kfs-docker /bin/bash' >> /usr/local/bin/docex.sh"
        system "chmod +x /usr/local/bin/docex.sh"
    end
    action :run
end

# startup all docker containers configured in stack json
node["containers"].each do |c|
    c.each do |app, appconfig|
        image = appconfig["image"]
        platformConfigurationFile = appconfig["platformConfigurationFile"]
        volumes = appconfig["volumes"]
        containerPortMapping = appconfig["containerPortMapping"]
        forceImagePull = appconfig["forceImagePull"]

        # ensure host volume directories exist
        ruby_block "createVolumeDirectoriesIfRequired" do
            block do
                values = volumes.gsub(/\s+/m, ' ').strip.split(" ")
                values.each do |val1|
                    if val1 != "-v"
                        vols = val1.split(":");
                        Chef::Log.info("create directory #{vols[0]} if required")
                        system "mkdir -p #{vols[0]}"
                    end
                end
            end
            action :run
        end

        Chef::Log.debug("deploying '#{app}', from '#{image}'")
        ruby_block "deployKfsDockerContainer" do
            block do
                if forceImagePull == "true"
                    Chef::Log.info("removing existing image '#{image}'...")
                    system "docker rmi -f #{image}"
                    Chef::Log.info("pulling image '#{image}'...")
                    system "docker pull #{image}"
                end

                Chef::Log.info("launching image #{image} with configuration file #{platformConfigurationFile}")
                system "chmod +x /usr/local/bin/*.sh"
                system "docker run -d -h #{hostname} --name #{app}-docker -e PLATFORM_CONFIGURATION_FILE=#{platformConfigurationFile} #{volumes} #{containerPortMapping} #{image} /usr/local/bin/kfs-docker-startup.sh"
            end
            action :run
        end
    end
end

# dockerStop.rb    
#---------------------------------------------------------------------------------------
ruby_block "stopcontainers" do
    block do
        Chef::Log.info("Stopping and removing all docker containers and no name instances...")
        system "docker stop -t 1 $(docker ps -a -q)"
        system "docker rm -f $(docker ps -a -q)"
        system "docker rmi -f `docker images | grep '<none>' | awk  '{ print $3 }'`"
    end
    action :run
end
