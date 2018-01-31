#!/bin/bash

if [ -z $1 ]; then
	find ~/Documents
else
	xdg-open $1 &
fi
