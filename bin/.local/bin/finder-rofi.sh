#!/bin/bash

if [ -z $1 ]; then
        ls ~/Documents
else
        xdg-open ~/Documents/$1
fi
