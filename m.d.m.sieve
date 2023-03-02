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


# Organize mailing list emails in dedicated directories.
#
if exists "List-Id" {
  if header :regex "List-Id" "<([a-z_0-9-]+)[.@]" {
    set :lower "listname" "${1}";
    fileinto :create "Lists.${listname}";
  }
}

# n.b. "keep" is executed automatically, if no other action is taken.
