Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 513C1142F8
	for <drbd-dev@lists.linbit.com>; Tue, 27 Jul 2004 16:52:11 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.1 release...
Date: Tue, 27 Jul 2004 16:52:10 +0200
References: <200407271028.23677.philipp.reisner@linbit.com> <mSn8KetO2diY1eJq8Jc59iw=lge@web.de>
In-Reply-To: <mSn8KetO2diY1eJq8Jc59iw=lge@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407271652.10600.philipp.reisner@linbit.com>
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

On Tuesday 27 July 2004 15:05, Lars Ellenberg wrote:
> / 2004-07-27 10:28:23 +0200
>
> \ Philipp Reisner:
> > Hi,
> >
> > Ich habe vor gegen ende der Woche 0.7.1 zu taggen.
> >  * Damit XFS nun wirklich mit DRBD stable funktioniert
> >  * Damit ein upgrade Guide 0.6.x -> 0.7.x enthalten ist
> >
> > sonstige TODOs (soweit ich das bis jetzt sehe):
>
> * agree on the sprache die hier gespoken wird :-)
>

:) Ok, I bin for Englisch. Although all auf the list deutschsprachig sind.

> > * Increment the primary-count if someone types in "yes" at the user's
> >   dialog
>
> the "human" count?  or which one?

Oh, right, the human count of course.

> --> why? it is not primary yet...
> hm.
> maybe set some "mdf_inc_human_if_we_go_primary_while_unconnected",
> and ... you get the idea ...
> but this seems to be a litlle hackish.
>
> > * Make sure the timeout-count is increased if the timeout is expired
> >   at the user's dialog
>
> yes. but still, actually it only needs to increase these,
> when we go primary.
> so set here a flag "mdf_inc_timeout_cnt_if_we_go_primary_while_unconnected"
>
> be sure that nothing ugly can happen when
>  both go down. come back again, but link is broken.
>  both timeout / admin says yes to one of them.
>  one of the nodes is 0.7.0 ...
> eventually they connect... now they should still do the right thing.

My initial idea was that drbdadm should simply do a 

drbdsetup /dev/nbX primary --human | --timeout-expired
drbdsetup /dev/nbX secondary

The better implementation would be ( I guess this is what you mean)

drbdsteup /dev/nbX on_primary --increase-human
drbdsteup /dev/nbX on_primary --increase-timeout-expired

... I will go that way...


> > * Make the ":sendpage fallback/total: %lu/%lu\n" more aggressive towards
> >   XFS. "drbd0: XFS's erronous IO requests detected. Workaround engaged."
>
> and display that with every statistic report ...
> and increase that from INFO to WARN ...
> no problem with that one,
> the more people point at xfs, the more likely it is fixed sooner :)
>

Right.

>
> derzeit nur ein paar ideen, kein code.
>
> == VALID_POINTER ==
>
>  paranoia:
>  evtl. noch ein __range_ok(pointer,sizeof(whatever))
>  mit in das macro einbauen...
>
> == benchmark ==
>
>  was ist mit deinem "benchmark"?
>  willst du den rauswerfen, oder auf 0.7 updaten?
>  soll ich das in ein cth script umwandeln?
>
>  an alle: es wäre sicher nett, einen generischen benchmark zu haben.
>  was wäre sinnvoll zu sammeln?
>  nodeinfo:
>    /proc/cpuinfo (komplett?)
>    uname -a
>    lsmod ?
>    lspci ?
>  networkinfo:
>    ping?
>    bing?
>    ??
>  io-info:
>    hdparm ?
>    tiobench?
>    philipps "dm.c"?
>    mein "wbtest.c"?
>    ohne, unconnected, connected, on synctarget, on syncsource,
>     protocol A,B,C ?

Yes, a benchmark would be great. My old dm.c is very primitiv.
Its purpose is to show the difference between the performance
of the backing_device and the performance of DRBD on top of the
backing_device. --- And it measures a complete linear pattern
-> It does not meassure the latency of the disks, it measures
DRBD's overhead.

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
