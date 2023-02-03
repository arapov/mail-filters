# Sieve filter

# Declare the extensions used by this script.
#
require [
  "copy",
  "envelope",
  "fileinto",
  "imap4flags",
  "mailbox",
  "regex",
  "variables"
];

# Mark all the mails from me as seen/read.
#
if envelope "From" "anton@openssl.org" {
  setflag "\\Seen";
}

# Mark mails to me with a Blue flag.
#
if address "To" "anton@openssl.org" {
  setflag "\\Flagged";
  addflag "$MailFlagBit2";
}

# Organize mailing list emails in dedicated directories.
#
if anyof(
         header "Precedence" ["list", "bulk"],
         exists "List-Id") {
  if header :regex "List-Id" "<([a-z_0-9-]+)[.@]" {
    set :lower "listname" "${1}";
    fileinto :create "Lists.${listname}";
  }
}
