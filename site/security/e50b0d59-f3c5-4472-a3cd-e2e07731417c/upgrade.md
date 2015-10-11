How to upgrade to this patch
============================

1. Download the patch to your machine somehow
2. Go into the folder where you extracted the elemental-ircd tarball
3. `$ git apply /path/to/the/patch/file`
4. `$ make`
5. `$ make install`
6. Connect to the irc daemon and `OPER` up
7. `/MODRELOAD m_monitor.so`

The changes should take effect immediately, and any memory that was previously 
leaking should be freed in about 30 seconds.
