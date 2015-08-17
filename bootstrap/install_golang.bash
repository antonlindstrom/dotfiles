#!/bin/bash

# This script installs Golang. It's a pretty insecure script so be sure to
# look through and trust it before you're doing anything.

set -eou pipefail

# Add the gopath you wish to have here.
export GOPATH=$HOME/Documents/Development

export GOLANG_VERSION=1.4.2
export PATH=/usr/src/go/bin:$PATH:$GOPATH/bin

# Check if Go already is installed
go version | grep $GOLANG_VERSION
if [ $? == 0 ]; then
	echo "!! Go seems to be installed already."
	exit 0
fi

sudo apt-get update && sudo apt-get install -y ca-certificates curl gcc libc6-dev make bzr git mercurial
curl -sSL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz | sudo tar -v -C /usr/src -xz

cd /usr/src/go/src && sudo ./make.bash --no-clean 2>&1
mkdir -p $GOPATH
go version
