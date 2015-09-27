Elemental-IRCd 7.0-experimental
===============================

This release is pre-alpha. It is not intended to be used in production 
settings. Please be sure to report strange behavior or bugs.

This is one of the largest releases that we have done. It consists of 469 
commits and is still very much in progress. Because this is a major release, we 
are taking the opportunity to also start deprecating things or behaviors that 
are nonsensical or undesirable.

This is tested and known to be working normally with Atheme services (or 
a fork) and optionally Tetra for extended services.

This release is ABI-incompatible with previous releases of elemental-ircd. As 
a part of migrating to the new version, please run the following commands in 
your ircd prefix before running `make install`:

    #!/bin/sh

    mv modules modules-6.6.2
    mv bin bin-6.6.2
    mv lib lib-6.6.2
    mv help help-6.6.2

And be sure to recompile any custom modules with the new build system:
 - add your file to extensions/m\_foo.c
 - add m\_foo.la to the list of extensions in extensions/Makefile.am
 - rerun automake, ./configure, make and make install

changes
-------

 - autoconf -> automake [#86]
 - the system's sqlite is now used [bac8187]
 - MODE\_NOREPEAT, MODE\_NOCAPS, MODE\_NONOTICE, MODE\_NOCTCP and MODE\_NOCOLOR
   are now implemented as modules instead of in the core [411c3a3, 0f2ccf4, 9488ed1, 94dee35, dfc854d]
 - many upstream libratbox patches are applied
 - MONITOR is less inconsistent [#151, #157]
 - all SVN revision tags are normalized [8233df0]
 - GPL version 2 text normalized against FSF's copy [70bca7c8]
 - elemental-ircd runs as a shared library
 - many, many coverity fixes
 - a bit of useless code removed

additions
---------

 - channel and private message hooks [5d9cc5c]
 - extension added to block invalid UTF-8 messages from being sent to any channel [694c1d8]
 - user mode +W for WEBIRC clients [694c1d8, c910264]
 - user mode-based extban [671c21d]
 - a testing suite (still in development) [#113, #155, etc]
 - SASL EXTERNAL support [788565f]
 - support for Free/OpenBSD
 - theoretically can support windows and Mac OSX (we do not suggest you use either to maintain public-facing IRC servers)
 - the beginnings of IRCv3 tagged message support
 - automatic testing via travis on GCC and Clang on Linux and OSX
 - ircv3 away-notify, chghost client capabilities [6bec481, 83e31d1, 58f3d8c, e84f541]

removals
--------

 - remove channel mode +D (block /me) [a003556]
 - outdated ircd-hybrid migration tools removed [694c1d8]
 - remove extension module for when you are being WHOIS'd [678ac18]
 - multiple implementations of sprintf removed [#93, #76]
 - old or outdated documentation has been purged

[Download](https://github.com/Elemental-IRCd/elemental-ircd/archive/elemental-ircd-7.0-experimental.tar.gz)
