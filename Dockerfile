# Dockerizing SonarQube
# Based on Ubuntu 18.04


FROM  ubuntu:18.04
SHELL ["/bin/bash", "-c"]

# Add repositories and update Ubuntu 18.04
RUN apt-get update -y
RUN apt-get install software-properties-common python3-setuptools python3-pip -y
RUN add-apt-repository ppa:certbot/certbot -y
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update -y
RUN apt-get upgrade -y


#Install PostgreSQL
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -

RUN apt-get -y install postgresql postgresql-contrib
RUN systemctl start postgresql
RUN systemctl enable postgresql

#Create sonar database
RUN passwd postgres
RUN su - postgres
RUN createuser sonar
RUN psql 
RUN ALTER USER sonar WITH ENCRYPTED password 'pw4sonar';
RUN CREATE DATABASE sonar OWNER sonar;
RUN \q

#Install SonarQube
RUN cd /opt/sonarqube 
RUN wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-7.9.zip
RUN unzip sonarqube-7.9.zip
RUN rm sonarqube-7.9.zip

RUN cd /etc/systemd/system/sonarqube.service
RUN wget 

#Enable sonarqube
RUN systemctl enable sonarqube


#Install nginx and certbox
RUN apt-get install nginx certbot python-certbot-nginx -y
RUN cd /etc/nginx/sites-enabled/sonarqube
RUN wget 

#Install openssh server and vim
RUN apt-get install openssh-server vim -y supervisor
RUN ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa


#expose HTTP PORT
EXPOSE 80 443
