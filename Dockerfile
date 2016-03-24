FROM jupyter/jupyterhub
MAINTAINER Lab41

# Update apt-get
RUN apt-get -y update

# Install Docker (see https://docs.docker.com/engine/installation/linux/debian/)
RUN apt-get -y install apt-transport-https ca-certificates && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    mkdir -p /etc/apt/sources.list.d/ && \
    echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-cache policy docker-engine && \
    apt-get -y install docker-engine

# Clone and install DockerSpawner and OAuthenticator
RUN cd /srv && \
    git clone https://github.com/jupyter/dockerspawner.git && \
    git clone https://github.com/jupyter/oauthenticator.git && \
    cd /srv/dockerspawner && \
    pip install . && \
    cd /srv/oauthenticator && \
    pip install .
