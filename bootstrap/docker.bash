#!/bin/bash

# This script installs docker but this is pretty darn dangerous. Only run this
# if you like to live dangerously.

docker version | grep "Version"
if [ $? == 0 ]; then
	echo "!! Docker seems to be installed already."
	exit 0
fi

curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker $(whoami)

echo "You need to log in and out again to make the permissions work properly."
