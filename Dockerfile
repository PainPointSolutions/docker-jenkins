# Pull base image.
FROM jenkins/jenkins:latest

# File Author.
MAINTAINER Robert Hänsel <robert@painpoint-solutions.net>

ENV SONARQUBE_HOST=http://localhost:9000

USER root

RUN mkdir /data && \
  mkdir /root/.ssh

RUN apt update && \
  apt upgrade -y && \
  apt install -y wget ca-certificates apt-transport-https software-properties-common curl telnet rsync vim graphicsmagick

# postgresql client 9.6    
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# add maven 3.3.X
RUN echo "deb http://ftp2.de.debian.org/debian unstable main non-free contrib" >> /etc/apt/sources.list

# add docker engine
RUN /bin/sh -c "curl -fsSL https://yum.dockerproject.org/gpg | apt-key add -" && \
# not working :(
# RUN add-apt-repository "deb [arch=amd64] https://apt.dockerproject.org/repo/ debian-$(lsb_release -cs) main"
  echo "deb [arch=amd64] https://apt.dockerproject.org/repo/ debian-jessie main" >> /etc/apt/sources.list

RUN apt update && \
  apt upgrade -y

RUN apt install -y postgresql-client-9.6 docker-engine maven/unstable

# add sonar-scanner
RUN wget --no-verbose -O /tmp/sonar-scanner.zip "https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.0.3.778-linux.zip" && \
  unzip -q -d /opt /tmp/sonar-scanner.zip && \
  ln -s /opt/sonar-scanner-3.0.3.778-linux /opt/sonar-scanner && \
  ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
  echo "alias \"sonar-scanner=sonar-scanner -D sonar.host.url=\${SONARQUBE_HOST:-http://localhost:9000}\"" >> /root/.bashrc

WORKDIR /var/jenkins_home

