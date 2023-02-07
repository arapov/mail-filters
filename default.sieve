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
  "subaddress",
  "variables"
];

# File noise from github into respective directory.
#
if address :detail "To" "github" {
  fileinto :create "GitHub Noise";
  stop;
}

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
if exists "List-Id" {
  if header :regex "List-Id" "<([a-z_0-9-]+)[.@]" {
    set :lower "listname" "${1}";
    fileinto :create "Lists.${listname}";
  }
}

# n.b. "keep" is executed automatically, if no other action is taken.
