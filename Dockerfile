# Pull base image.
FROM jenkins

# File Author.
MAINTAINER Robert Hänsel <robert@advalyze.de>

USER root

RUN mkdir /data && \
  apt-get update && \
  apt-get install -y maven postgresql-client

# USER jenkins

WORKDIR /var/jenkins_home

