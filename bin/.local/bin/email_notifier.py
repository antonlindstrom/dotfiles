#!/usr/bin/python
# Based on: https://bbs.archlinux.org/viewtopic.php?pid=962423#p962423
# This version is simplified a lot and uses a hardcoded mailbox.

import pyinotify
import gi

gi.require_version('Notify', '0.7')

from gi.repository import Notify
from os.path import expanduser
from mailbox import MaildirMessage
from email.header import decode_header

maildir_folder = expanduser(r"~/.mail/")
new_mail_folder = maildir_folder+"antonlindstrom.com/INBOX/new"
notification_timeout = 12000

Notify.init(r'email_notifier.py')

dec_header = lambda h : ' '.join(str(s, e if bool(e) else 'ascii') for s, e in decode_header(h))

def dec_header(header):
    for s, e in decode_header(header):
        if isinstance(s, str):
            return s
        else:
            try:
                return s.decode(e)
            except:
                print("failed to decode message %s" % s)

def newfile(event):
    fd = open(event.pathname, 'r')
    mail = MaildirMessage(message=fd)
    subject_header = dec_header(mail['Subject'])
    from_header = dec_header(mail['From'])
    print("event: new message from '%s', sending notification" % from_header)
    n = Notify.Notification.new("New mail: " + from_header, subject_header, "mail-unread-new")
    fd.close()
    n.set_timeout(notification_timeout)
    n.show()

wm = pyinotify.WatchManager()
notifier = pyinotify.Notifier(wm, newfile)

wm.add_watch(new_mail_folder, pyinotify.IN_CREATE | pyinotify.IN_MOVED_TO)

notifier.loop()
