#!/bin/bash

if [ -z $1 ]; then
	find ~/Documents
else
	xdg-open ~/Documents/$1
fi
