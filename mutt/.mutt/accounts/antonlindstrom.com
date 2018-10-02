set from      = "anton@alley.se"
set realname  = "Anton Lindstrom"

set mbox      = "+antonlindstrom.com/archive"
set postponed = "+antonlindstrom.com/drafts"
set record    = "+antonlindstrom.com/sent"

set sendmail = "/usr/bin/msmtp -a me"
set sendmail_wait = 0

color status green default

macro index D \
    "<save-message>+antonlindstrom.com/trash<enter>" \
    "move message to the trash"

macro index S \
    "<save-message>+antonlindstrom.com/spam<enter>"  \
        "mark message as spam"

# vim:filetype=muttrc
