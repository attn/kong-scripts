#!/usr/bin/env bash

#
# Setup Kong
#
# This little script runs through the setup process of building a Kong instance
# with a locally-mounted configuration file at `/etc/kong/kong.yml` and a
# Cassandra database locally mounted to the filesystem using a Data Volume.
#
# Everything is Docker-ready and you should be notified of all errors.
#
# To un-build everything (destroy), run the following:
# $ rm -rf /etc/kong /var/lib/cassandra
# $ docker stop kong cassandra
# $ docker rm kong cassandra
#
# If the Kong configuration is modified, be sure to restart Kong:
# $ docker run -it kong kong reload
#

# Load functions for printing results to terminal
source helper_functions.sh

# Create directory for Kong configuration
info "Creating /etc/kong"
mkdir /etc/kong || error "Could not create /etc/kong"

# Pull latest YAML config from GitHub
info "Pulling down latest Kong config"
curl --silent \
  https://raw.githubusercontent.com/Mashape/docker-kong/master/config.docker/kong.yml \
  > /etc/kong/kong.yml \
  || error "Could not pull down latest Kong config from GitHub"

# Create directory for local data storage on host
info "Creating /var/lib/cassandra"
mkdir /var/lib/cassandra || error "Could not create /var/lib/cassandra"

# Spin up new Cassandra container mounted to the local file system
info "Spinning up new Cassandra container"
docker run -d \
  -v /var/lib/cassandra/:/var/lib/cassandra \
  -p 9042:9042 \
  --name cassandra \
  mashape/cassandra \
  || error "Could not spin up Cassandra instance"

# Spin up new Docker container consuming the local config we just made
info "Spinning up new Kong container"
docker run -d \
  -v /etc/kong/:/etc/kong \
  -p 8000:8000 \
  -p 8001:8001 \
  --link cassandra:cassandra \
  --name kong \
  mashape/kong \
  || error "Could not spin up Kong instance"

# Ensure Kong container is running
info "Make sure Kong container is running"

# Print success message and exit
success "Kong is ready to go!"
