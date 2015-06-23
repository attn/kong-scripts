#!/usr/bin/env bash

#
# Helper Functions
# 
# Simple functions for logging colorized output to the terminal and exiting.
#

# Variables for colorizing log messages
red=`tput setaf 1`
blue=`tput setaf 4`
green=`tput setaf 2`
reset=`tput sgr0`

# Wrapper around error message and exit code
function error {
  echo "${red}[ERR!]${reset} $1" 1>&2
  exit 1
}

# Wrapper around maybe message
function info {
  echo "${blue}[INFO]${reset} $1" 1>&2
}

# Wrapper around success message and exit code
function success {
  echo "${green}[DONE]${reset} $1" 1>&2
  exit 0
}

