set from      = "anton@lindstrom.sh"
set realname  = "Anton Lindstrom"

set mbox      = "+anton@lindstrom.sh/Archive"
set postponed = "+anton@lindstrom.sh/Drafts"
set record    = "+antonlindstrom.com/Sent"

set sendmail  = "/usr/bin/msmtp -a lindstrom.sh"
set sendmail_wait = 0

color status cyan default

macro index D \
    "<save-message>+anton@lindstrom.sh/Trash<enter>" \
    "move message to the trash"

macro index S \
    "<save-message>+anton@lindstrom.sh/Spam<enter>"  \
        "mark message as spam"

# vim:filetype=muttrc
