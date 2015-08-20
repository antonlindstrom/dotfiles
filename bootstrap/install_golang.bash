#!/bin/bash

# This script installs Golang. It's a pretty insecure script so be sure to
# look through and trust it before you're doing anything.

set -eou pipefail

# Add the gopath you wish to have here.
export GOPATH=$HOME/Documents/Development

export GOLANG_VERSION=1.5
export PATH=/usr/local/go/bin:$PATH:$GOPATH/bin

# Check if Go already is installed
count=$(go version | grep -c $GOLANG_VERSION || true)
if [ $count -gt 0 ]; then
	echo "!! Go $GOLANG_VERSION seems to be installed already."
	exit 0
fi

sudo apt-get update
sudo apt-get install -y ca-certificates curl gcc libc6-dev make bzr git mercurial
curl -sSL https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz | sudo tar -v -C /usr/local -xz

mkdir -p $GOPATH
go version
