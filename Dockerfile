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

# Install Ganymede Hub + dependencies
COPY . /srv/ganymede_hub
RUN pip install -r /srv/ganymede_hub/requirements.txt /srv/ganymede_hub/. && \
    rm -rf /srv/ganymede_hub

# Download and build the ganymede_nbserver image.
RUN git clone https://github.com/kylemvz/ganymede_nbserver.git /srv/ganymede_nbserver && \
    docker build -t "lab41/ganymede_nbserver" /srv/ganymede_nbserver && \
    rm -rf /srv/ganymede_nbserver
