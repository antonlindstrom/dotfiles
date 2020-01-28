-- One of the work mailservers is slow.
-- The time in seconds for the program to wait for a mail server's response (default 60)
options.timeout = 120

-- According to the IMAP specification, when trying to write a message to a
-- non-existent mailbox, the server must send a hint to the client, whether it
-- should create the mailbox and try again or not. However some IMAP servers don't
-- follow the specification and don't send the correct response code to the
-- client. By enabling this option the client tries to create the mailbox, despite
-- of the server's response.
options.create = true

-- By enabling this option new mailboxes that were automatically created, get
-- also subscribed; they are set active in order for IMAP clients to recognize them
options.subscribe = true

-- Normally, messages are marked for deletion and are actually deleted when the
-- mailbox is closed. When this option is enabled, messages are expunged
-- immediately after being marked deleted.
options.expunge = true

-- Read password.
function account_password(account)
  local status
  local value

  status, value = pipe_from('cat ~/.offlineimap/' .. account)

  value = string.gsub(value, '\n', '')
  return value
end

-- Fastmail
account1 = IMAP {
  server = "imap.fastmail.com",
  username = "anton@lindstrom.sh",
  password = account_password('anton@lindstrom.sh'),
  ssl = "ssl3"
}

-- Move to arch-general mailing list folder.
messages = account1["INBOX"]:contain_to("arch-general@archlinux.org")
  + account1["INBOX"]:contain_from("arch-general-request@archlinux.org")
  + account1["INBOX"]:contain_field("X-Original-Delivered-to", "arch-general@lists.archlinux.org")
messages:move_messages(account1["lists/arch-general"])

-- Move to arch-announce mailing list folder.
messages = account1["INBOX"]:contain_to("arch-announce@archlinux.org")
  + account1["INBOX"]:contain_from("arch-announce-request@archlinux.org")
  + account1["INBOX"]:contain_field("X-Original-Delivered-to", "arch-announce@lists.archlinux.org")
messages:move_messages(account1["lists/arch-announce"])

-- Move to qutebrowser-announce mailing list folder.
messages = account1["INBOX"]:contain_to("qutebrowser-announce@lists.qutebrowser.org")
  + account1["INBOX"]:contain_from("qutebrowser-announce-request@lists.qutebrowser.org")
  + account1["INBOX"]:contain_field("X-Original-Delivered-to", "qutebrowser-announce@lists.qutebrowser.org")
messages:move_messages(account1["lists/qutebrowser-announce"])

-- Move to vim-announce mailing list folder.
messages = account1["INBOX"]:contain_to("vim-announce@vim.org")
  + account1["INBOX"]:contain_from("vim_announce+subconfirm@googlegroups.com")
  + account1["INBOX"]:contain_field("X-Original-Delivered-to", "vim_announce+subconfirm@googlegroups.com")
messages:move_messages(account1["lists/vim-announce"])

-- Move to CodePractice folder.
messages = account1["INBOX"]:contain_from("@interviewcake.com")
  + account1["INBOX"]:contain_from("@hackerrankmail.com")
messages:move_messages(account1["CodePractice"])

-- Move company emails to the Company folder.
messages = account1["INBOX"]:contain_from("lrfkonsult.se")
messages:move_messages(account1["Company"])
