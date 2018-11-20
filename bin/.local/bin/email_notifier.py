#!/usr/bin/python
# Based on: https://bbs.archlinux.org/viewtopic.php?pid=962423#p962423
# This version is simplified a lot and uses a hardcoded mailbox.

import pyinotify
import gi
import glob
import re

gi.require_version('Notify', '0.7')

from gi.repository import Notify
from os.path import expanduser
from mailbox import MaildirMessage
from email.header import decode_header

maildir_folder = expanduser(r"~/.mail/")
new_mail_folders = glob.glob(maildir_folder+"*/*/new")
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
    from_header = dec_header(mail['From']).replace("<", "&lt;").replace(">", "&gt;")
    to_header = dec_header(mail['To'])

    message = "%s\n<i>%s</i>" % (from_header, subject_header)

    print("event: new message from '%s', sending notification" % from_header)

    if (mail['Delivered-To'] == None) or (mail['Delivered-To'] == ""):
        subject = to_header
    else:
        subject = dec_header(mail['Delivered-To'])

    subject = subject.replace("<", "").replace(">", "")
    subject = (subject[:100] + '..') if len(subject) > 100 else subject

    n = Notify.Notification.new(subject, message, "mail-unread-new")

    fd.close()
    n.set_timeout(notification_timeout)
    n.show()

wm = pyinotify.WatchManager()
notifier = pyinotify.Notifier(wm, newfile)

for new_mail_folder in new_mail_folders:
    # Skip some folders folders.
    if re.match(r'(spam|trash|drafts|sent)', new_mail_folder, re.IGNORECASE):
        continue

    print("adding watch on %s" % new_mail_folder)
    wm.add_watch(new_mail_folder, pyinotify.IN_CREATE | pyinotify.IN_MOVED_TO)

notifier.loop()
