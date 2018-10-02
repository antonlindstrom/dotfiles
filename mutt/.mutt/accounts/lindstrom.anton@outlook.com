set from      = "lindstrom.anton@outlook.com"
set realname  = "Anton Lindström"

set mbox      = "+lindstrom.anton@outlook.com/Archive"
set postponed = "+lindstrom.anton@outlook.com/Drafts"
set record    = "+lindstrom.anton@outlook.com/Sent"

set sendmail  = "/usr/bin/msmtp -a outlook"
set sendmail_wait = 0

color status red default

macro index D \
    "<save-message>+lindstrom.anton@outlook.com/Trash<enter>" \
    "move message to the trash"

macro index S \
    "<save-message>+lindstrom.anton@outlook.com/Spam<enter>"  \
        "mark message as spam"

# vim:filetype=muttrc
