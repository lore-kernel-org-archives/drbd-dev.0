Return-Path: <lars.ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-063-108.arcor-ip.net [145.254.63.108])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1839B142F8
	for <drbd-dev@lists.linbit.com>; Tue, 27 Jul 2004 15:15:32 +0200 (CEST)
Date: Tue, 27 Jul 2004 15:05:27 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.1 release...
Message-ID: <mSn8KetO2diY1eJq8Jc59iw=lge@web.de>
References: <200407271028.23677.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407271028.23677.philipp.reisner@linbit.com>
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

/ 2004-07-27 10:28:23 +0200
\ Philipp Reisner:
> Hi,
> 
> Ich habe vor gegen ende der Woche 0.7.1 zu taggen. 
>  * Damit XFS nun wirklich mit DRBD stable funktioniert
>  * Damit ein upgrade Guide 0.6.x -> 0.7.x enthalten ist
> 
> sonstige TODOs (soweit ich das bis jetzt sehe):

* agree on the sprache die hier gespoken wird :-)

> 
> * Increment the primary-count if someone types in "yes" at the user's
>   dialog

the "human" count?  or which one?
--> why? it is not primary yet...
hm.
maybe set some "mdf_inc_human_if_we_go_primary_while_unconnected",
and ... you get the idea ...
but this seems to be a litlle hackish.

> * Make sure the timeout-count is increased if the timeout is expired
>   at the user's dialog

yes. but still, actually it only needs to increase these,
when we go primary.
so set here a flag "mdf_inc_timeout_cnt_if_we_go_primary_while_unconnected"

be sure that nothing ugly can happen when
 both go down. come back again, but link is broken.
 both timeout / admin says yes to one of them.
 one of the nodes is 0.7.0 ...
eventually they connect... now they should still do the right thing.

> * Make the ":sendpage fallback/total: %lu/%lu\n" more aggressive towards
>   XFS. "drbd0: XFS's erronous IO requests detected. Workaround engaged."

and display that with every statistic report ...
and increase that from INFO to WARN ...
no problem with that one,
the more people point at xfs, the more likely it is fixed sooner :)

> * Some fix to Martin Bene's "Child process does not terminate!" issue in
>   drbdadm.

yes...
it does not need to be a fixed time.
how do we want to guesstimate the time we want to wait?
 maybe we want to introduce a "write in one go, then sync and wait"
 for "bm_write_all" instead of foreach(bm_block) { write;sync;wait; } ?
 ( needs to alloc extra pages and bios, put them on some list,
   write them all out, wait for all of them ... )
 maybe we want to suspend _all_ devices while one device is writing its bitmap? 

> LGE: 
> * Hast du noch irgendwelche Dinge die in 0.7.1 rein sollten ?

derzeit nur ein paar ideen, kein code.

== VALID_POINTER ==

 paranoia:
 evtl. noch ein __range_ok(pointer,sizeof(whatever))
 mit in das macro einbauen...

== benchmark ==

 was ist mit deinem "benchmark"?
 willst du den rauswerfen, oder auf 0.7 updaten?
 soll ich das in ein cth script umwandeln?
 
 an alle: es wäre sicher nett, einen generischen benchmark zu haben.
 was wäre sinnvoll zu sammeln?
 nodeinfo:
   /proc/cpuinfo (komplett?)
   uname -a
   lsmod ?
   lspci ?
 networkinfo:
   ping?
   bing?
   ??
 io-info:
   hdparm ?
   tiobench?
   philipps "dm.c"?
   mein "wbtest.c"?
   ohne, unconnected, connected, on synctarget, on syncsource,
    protocol A,B,C ?
 
 
	Lars
