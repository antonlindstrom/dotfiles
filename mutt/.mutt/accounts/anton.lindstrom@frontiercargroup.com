set from      = "anton.lindstrom@frontiercargroup.com"
set realname  = "Anton Lindstrom"

set mbox      = "+anton.lindstrom@frontiercargroup.com/archive"
set postponed = "+anton.lindstrom@frontiercargroup.com/drafts"
set record    = "+anton.lindstrom@frontiercargroup.com/sent"

set sendmail = "/usr/bin/msmtp -a anton.lindstrom@frontiercargroup.com"
set sendmail_wait = 0

color status green default

macro index D \
    "<save-message>+anton.lindstrom@frontiercargroup.com/trash<enter>" \
    "move message to the trash"

macro index S \
    "<save-message>+anton.lindstrom@frontiercargroup.com/spam<enter>"  \
        "mark message as spam"

# vim:filetype=muttrc
