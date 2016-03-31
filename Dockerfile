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
RUN git clone https://github.com/jupyter/dockerspawner.git /srv/dockerspawner && \
    pip install /srv/dockerspawner/. && \
    rm -rf /srv/dockerspawner && \
    git clone https://github.com/jupyter/oauthenticator.git /srv/oauthenticator && \
    pip install /srv/oauthenticator/. && \
    rm -rf /srv/oauthenticator
COPY . /srv/ganymede_hub
RUN pip install /srv/ganymede_hub/. && \
    rm -rf /srv/ganymede_hub

# Eventually we can use pip to install, but unfortunately, the latest pypi release is 0.2.0 on Jan 4, but
# we are using a feature (usernames_map) first introduced in commit a37ec45120e1058a19aee49707724c6b90470323 from Jan 7.
#RUN pip install -r /srv/ganymede_hub/requirements.txt /srv/ganymede_hub/. && \
#    rm -rf /srv/ganymede_hub