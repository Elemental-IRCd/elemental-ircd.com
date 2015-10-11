Elemental-IRCd Security Release: 2015-10-07
===========================================

CVE-2015-5290

Elemental-IRCd reference code: e50b0d59-f3c5-4472-a3cd-e2e07731417c

[Permanent link](http://elemental-ircd.com/security/e50b0d59-f3c5-4472-a3cd-e2e07731417c)

Distribution of this document is unlimited and encouraged as long as it remains
unchanged.

Summary
-------

Elemental-IRCd is an Internet Relay Chat (IRC / RFC 1459) daemon intended for
stable, secure deployments for both private and public-facing users. It
provides quick messaging across servers, even when deployed on a global scale.
One of the recent goals of the project has been to limit memory leaks and test
functionality to ensure quality for all users.

While looking for resource leaks and other things to test inside Elemental-IRCd
git master, we stumbled on an unfortunate programming error in how the MONITOR
command was handled that can lead to a system out-of-memory event if an
attacker hammers at the MONITOR command over and over.

Affected Daemons
----------------

In our testing, the following IRC daemons were affected:

- ircd-ratbox 3.0.8, SVN trunk and older
- charybdis 3.5-dev and older
- ircd-seven 1.1.3 and older
- Elemental-IRCd 6.6.2 and older

Other derivatives of these daemons will be affected as well unless for some
reason they came across and fixed that issue before this release.

Vulnerability Information
-------------------------

- Public release date: 2015-10-10
- CVE: CVE-2015-5290
- CVSS v3: CVSS:3.0/AV:N/AC:L/PR:N/UI:R/S:U/C:H/I:H/A:H/E:H/RL:W/RC:C/CR:H/IR:L/AR:H/MAV:N/MAC:L/MPR:N/MUI:N/MC:L/MI:N/MA:H
- CVSS score: 8.8 / 8.6 / 9.5
- Attack complexity: Trivial (less than 30 lines of code)

Notes
-----

If applying these patches is somehow impossible, the attack can be completely
mitigated by unloading the m\_monitor.so module using the following command
provided you have permission to load and unload modules:

    /MODUNLOAD m_monitor.so

The required privilege to do this is defined as the `admin` flag inside the
flags section of the relevant operator{} block in the configuration
(OLD: O:Line).

This patch can be applied at runtime and will automatically garbage-collect any
memory that has been leaked in the past.

A full set of technical details will be released as soon as it is confirmed
that major IRC networks affected by this have been patched.

Patches
-------

### ircd-ratbox

Upstream is about to release ircd-ratbox 3.0.9 that removes `MONITOR`
completely as well as fixing some other obscure bugs, so we are providing no
patch for these users as it will be redundant. If you really need to patch,
apply the Charybdis patch (you will need to do things by hand unfortunately).

Otherwise, unload the module as directed above.

### charybdis

These patches apply cleanly to charybdis 3.4.2 as compared against the tarball
fetched from:

    https://www.stack.nl/~jilles/irc/charybdis-3.4.2.tbz2

with the md5 sum of

    54245396b829f8d19d3958cde9c3bd65

and the SHA 256 sum of

    8a38e67072d90147c40202918c82237765e339cbc849456da54994ce6e31b754

- [patch](./patches/Charybdis_3-4-2.patch)

This patch will also apply cleanly to ircd-seven (tested only against git
master from `https://github.com/freenode/ircd-seven`).

### Elemental-IRCd

The patch for Elemental-IRCd 6.6.2 and potentially older versions as well as
a set of upgrade directions is attached below:

- [patch](./patches/Elemental-IRCd_6-6-2.patch)
- [upgrade directions](./upgrade.html)

If your version of Elemental-IRCd is not taking this patch (in testing this is
only the case if your version is older than 6.6.x), please try to apply the
Charybdis patch instead.

etc
---

We would like to thank the following people for helping to test or otherwise
verify this patchset before it was released publicly:

- `ariscop` for initial discovery and verification of memory leaking
- `ahf` for helping with diagnosing the impact to a few places
- `Androsyn` for helping with EFNet mitigation and removal of the code from
upstream
- `evilthomas` for helping report to Freenode
- `marienz` for finding a much easier way to exploit this
