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

-- Move to CodingPractice folder.
messages = account1["INBOX"]:contain_from("@interviewcake.com")
  + account1["INBOX"]:contain_from("@hackerrankmail.com")
messages:move_messages(account1["CodingPractice"])

-- Move company emails to the Company folder.
messages = account1["INBOX"]:contain_from("lrfkonsult.se")
messages:move_messages(account1["Company"])
