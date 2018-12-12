#!/bin/bash

notmuch new
notmuch tag --batch --input=/home/anton/.offlineimap/notmuch_tags

notmuch search --format=text0 --output=files tag:company | \
    xargs -0 -I {} --no-run-if-empty mv {} ~/.mail/anton@lindstrom.sh/Company/cur

notmuch search --format=text0 --output=files tag:codepractice | \
    xargs -0 -I {} --no-run-if-empty mv {} ~/.mail/anton@lindstrom.sh/CodePractice/cur
