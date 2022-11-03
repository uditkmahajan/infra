#!/usr/bin/bash
cloudwatch_group_name="prod-memberportal-teamd-log-group"
sudo yum update -y
sudo su
echo "Installing Java 11.."
amazon-linux-extras install java-openjdk11 -y
echo "Setting openjdk11 as default.."
sudo /usr/sbin/alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.2.7-0.amzn2.x86_64/bin/java
sudo /usr/sbin/alternatives --set javac /usr/lib/jvm/java-11-openjdk-11.0.2.7-0.amzn2.x86_64/bin/javac

## Verifying Tomcat Installation Directory ##
sudo groupadd --system tomcat
sudo useradd -d /usr/share/tomcat -r -s /bin/false -g tomcat tomcat
sudo yum -y install wget
wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.82/bin/apache-tomcat-8.5.82.tar.gz
sudo tar -xvf apache-tomcat-8.5.82.tar.gz -C /usr/share/
sudo ln -s /usr/share/apache-tomcat-8.5.82/ /usr/share/tomcat
sudo chown -R tomcat:tomcat /usr/share/tomcat
sudo chown -R tomcat:tomcat /usr/share/apache-tomcat-8.5.82/
sudo cat >/etc/systemd/system/tomcat.service <<EOL
[Unit]
Description=Tomcat Server
After=syslog.target network.target
[Service]
Type=forking
User=tomcat
Group=tomcat
Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment='JAVA_OPTS=-Djava.awt.headless=true'
Environment=CATALINA_HOME=/usr/share/tomcat
Environment=CATALINA_BASE=/usr/share/tomcat
Environment=CATALINA_PID=/usr/share/tomcat/temp/tomcat.pid
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M'
ExecStart=/usr/share/tomcat/bin/catalina.sh start
ExecStop=/usr/share/tomcat/bin/catalina.sh stop
StandardOutput=syslog
StandardError=syslog
[Install]
WantedBy=multi-user.target
EOL
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

#Enable Cloudwatch
sudo yum update -y
sudo yum install awslogs -y
sudo sed -i "s/log_group_name = \/var\/log\/messages/log_group_name = ${cloudwatch_group_name}/" /etc/awslogs/awslogs.conf
sudo sed -i 's/us-east-1/ap-northeast-2/g' /etc/awslogs/awscli.conf
sudo service awslogsd start
sudo systemctl enable awslogsd

#PostgressClient
sudo amazon-linux-extras install postgresql12

#Codedeploy install
sudo yum install ruby -y
sudo yum install wget -y
sudo cd /home/ec2-user
sudo wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent status
sudo service codedeploy-agent start
sudo service codedeploy-agent status


# changing catalina.properties file 
sudo cat >> /usr/share/tomcat/conf/catalina.properties <<EOL
env=prod
log.path=.
log.rootlevel=debug
CATALINA_OPTS="-Dlog4j2.formatMsgNoLookups=true"
AWS_REGION=ap-northeast-2
EOL
sudo mkdir ./AppLog
sudo cat > /usr/share/tomcat/conf/server.xml <<EOL
<?xml version="1.0" encoding="UTF-8"?>

<Server port="8005" shutdown="SHUTDOWN">
  <Listener className="org.apache.catalina.startup.VersionLoggerListener" />
  <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
  <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
  <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
  <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />
  <GlobalNamingResources>
    <Resource name="UserDatabase" auth="Container"
              type="org.apache.catalina.UserDatabase"
              description="User database that can be updated and saved"
              factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
              pathname="conf/tomcat-users.xml" />
  </GlobalNamingResources>
  <Service name="Catalina">
    <Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
    <Engine name="Catalina" defaultHost="localhost">                                                                                            
      <Realm className="org.apache.catalina.realm.LockOutRealm">
        <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
               resourceName="UserDatabase"/>
      </Realm>
      <Host name="localhost" appBase="webapps"
                    unpackWARs="true" autoDeploy="false" deployOnStartup="false" >
            <Context path="" docBase="portal-memberex-web"></Context>
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log" suffix=".txt"
               pattern="%h %l %u %t &quot;%r&quot; %s %b" />

      </Host>
    </Engine>
  </Service>
</Server>                                                                                                                                                                                                                                          
EOL

