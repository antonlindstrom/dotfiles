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

def newfile(event):
    fd = open(event.pathname, 'r')
    mail = MaildirMessage(message=fd)
    from_header, encoding = email.header.decode_header(mail['From'])[0]
    msg = "There is a new message waiting in your inbox from " + from_header + "."
    n = Notify.Notification.new("You've got mail!", msg, "mail-unread-new")
    fd.close()
    n.set_timeout(notification_timeout)
    n.show()

wm = pyinotify.WatchManager()
notifier = pyinotify.Notifier(wm, newfile)

wm.add_watch(new_mail_folder, pyinotify.IN_CREATE | pyinotify.IN_MOVED_TO)

notifier.loop()
