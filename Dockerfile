# Pull base image.
FROM jenkins

# File Author.
MAINTAINER Robert Hänsel <robert@painpoint-solutions.net>

USER root

RUN mkdir /data && \
  mkdir /root/.ssh

RUN apt-get update && \
  apt-get install -y wget ca-certificates apt-transport-https software-properties-common curl telnet rsync

# postgresql client 9.6    
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update && \
  apt-get upgrade -y

# add maven 3.3.X
RUN echo "deb http://ftp2.de.debian.org/debian unstable main non-free contrib" >> /etc/apt/sources.list

# add docker engine
RUN /bin/sh -c "curl -fsSL https://yum.dockerproject.org/gpg | apt-key add -" && \
# not working :(
# RUN add-apt-repository "deb [arch=amd64] https://apt.dockerproject.org/repo/ debian-$(lsb_release -cs) main"
  echo "deb [arch=amd64] https://apt.dockerproject.org/repo/ debian-jessie main" >> /etc/apt/sources.list

RUN apt-get update && \
  apt-get install -y postgresql-client-9.6 docker-engine maven/unstable

WORKDIR /var/jenkins_home

