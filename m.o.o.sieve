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

# File noise into respective directory.
#
#if address "From" "noisy@mail.yo" {
#  fileinto "Noise";
#  stop;
#}

# GitHub notifications from private instance
#
if address :detail "Delivered-To" "github" {
  if exists "List-Id" {
    if header :regex "List-Id" "<([a-z_0-9.-]+).github" {
      set :lower "reponame" "${1}";
      fileinto :create "GitPriv.${reponame}";
    }
  }
  stop;
}

# GitHub notifications from public instance
#
if address :detail "Delivered-To" "github-public" {
  if exists "List-Id" {
    if header :regex "List-Id" "<([a-z_0-9.-]+).github" {
      set :lower "reponame" "${1}";
      fileinto :create "GitPub.${reponame}";
    }
  }
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
