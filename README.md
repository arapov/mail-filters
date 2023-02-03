# mail-filters

# apple mail flags and imap
Apple has incorporated colored flags as IMAP keywords using bit-mapping,
allowing for the creation of six additional colors beyond the standard red flag.

```
Orange = $MailFlagBit0 (001)
Yellow = $MailFlagBit1 (010)
Green = $MailFlagBit0, $MailFlagBit1 (011)
Blue = $MailFlagBit2 (100)
Purple = $MailFlagBit0, $MailFlagBit2 (101)
Grey = $MailFlagBit1, $MailFlagBit2 (110)
```