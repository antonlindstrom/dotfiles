set from      = "anton@lindstrom.sh"
set realname  = "Anton Lindstrom"

set mbox      = "+anton@lindstrom.sh/Archive"
set postponed = "+anton@lindstrom.sh/Drafts"
set record    = "+anton@lindstrom.sh/Sent"

set sendmail  = "/usr/bin/msmtp -a lindstrom.sh"
set sendmail_wait = 0

folder-hook anton@lindstrom.sh/* 'push <collapse-all>'

color status cyan default

macro index A \
    "<save-message>+anton@lindstrom.sh/Archive<enter>" \
    "move message to the archive"

macro index D \
    "<save-message>+anton@lindstrom.sh/Trash<enter>" \
    "move message to the trash"

macro index S \
    "<save-message>+anton@lindstrom.sh/Spam<enter>"  \
        "mark message as spam"

# vim:filetype=muttrc
