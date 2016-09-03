Elemental-IRCd Security Release: 2016-09-03
===========================================

CVE not assigned yet

Elemental-IRCd reference code a91793ab-92ce-4c15-90d9-0a1937065aa0

[Permanent link](https://elemental-ircd.com/security/a91793ab-92ce-4c15-90d9-0a1937065aa0)

Distribution of this document is unlimited and encouraged as long as it remains
unchanged.

Summary
-------

Elemental-IRCd is an Internet Relay Chat (IRC / RFC 1459) daemon intended for
stable, secure deployments for both private and public-facing users. It
provides quick messaging across servers, even when deployed on a global scale.

This is a unspecified and not fully researched vulnerability in SASL handling
that Elemental needs a patch for. Elemental-IRCd 6.6.4 (to be released today)
contains this patch. In the meantime, users are asked to patch AS SOON AS
POSSIBLE.

This could let users take over services accounts by malforming SASL EXTERNAL
login requests.

Notes
-----

If for some reason you cannot apply these patches, please unload SASL EXTERNAL
support from your IRC services.
