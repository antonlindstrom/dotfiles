#!/bin/bash

notmuch new
notmuch tag --batch --input=/home/anton/.offlineimap/notmuch_tags

# Save the payslips with tags payslip and work in a separate directory.
notmuch search --format=text0 --output=files tag:payslip and tag:work | \
    xargs -0 -I {} --no-run-if-empty ripmime --overwrite -i {} -d ~/documents/payslips/; \
    rm ~/documents/payslips/{textfile*,*.jpg}
