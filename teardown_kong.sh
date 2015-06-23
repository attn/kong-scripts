#!/usr/bin/env bash

# Load functions for printing results to terminal
source helper_functions.sh

rm -rf /etc/kong /var/lib/cassandra && docker stop kong cassandra && docker rm kong cassandra
