# Pull base image.
FROM jenkins

# File Author.
MAINTAINER Robert Hänsel <robert@painpoint-solutions.net>

USER root

RUN mkdir /data

RUN apt-get update && \
    apt-get install -y wget ca-certificates apt-transport-https software-properties-common telnet rsync

# postgresql client 9.6    
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y maven postgresql-client-9.6

RUN curl -fsSL https://yum.dockerproject.org/gpg | apt-key add - && \
  add-apt-repository "deb https://apt.dockerproject.org/repo/ \
       debian-$(lsb_release -cs) \
       main"

RUN apt-get update && apt-get -y install docker-engine

WORKDIR /var/jenkins_home

