Technical Details for CVE-2015-5290
===================================

Entries in the `MONITOR` lists are allocated but never freed. An attacker can 
trivially take out a server by doing the following:

1. Generate random nicknames that are of the `NICKLEN` length reported in the 
   target IRC daemon's `005` (`RPL_ISUPPORT`) reply
2. Add them to their `MONITOR` list by using something similar to the following
   chicken-scratch Haskell:
   `"MONITOR + " ++ $ intercalate "," $ take (quot (NICKLEN + 1) 502) genNicks`
   where `genNicks` is a lazy IO action producing a list of random nicknames 
   that are of `NICKLEN` for maximum leakage.
3. Add enough to match the `MONITOR` limit defined in `RPL_ISUPPORT`
4. Leak them all at once with `MONITOR c`.

The ircd does only allow you to run this about once per second, but given 
a large attacker pool this is fairly trivial to make into a devastating attack. 
about 512 bytes is leaked per instance of `MONITOR c`, meaning this grows in 
linear space complexity.
