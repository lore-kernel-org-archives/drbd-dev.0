Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-212-144-120-171.arcor-ip.net
	[212.144.120.171])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 27DEA14329
	for <drbd-dev@lists.linbit.com>; Mon,  4 Oct 2004 15:25:03 +0200 (CEST)
Date: Mon, 4 Oct 2004 15:20:14 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Message-ID: <uIL/2eWT70b0jHBPleL+GiI=lge@web.de>
References: <200410041456.21841.philipp.reisner@linbit.com>
	<20041004130158.GP1542@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004130158.GP1542@marowsky-bree.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-04 15:01:58 +0200
\ Lars Marowsky-Bree:
> On 2004-10-04T14:56:21, Philipp Reisner <philipp.reisner@linbit.com> wrote:
> 
> > This is intended as food for thought on how we should design our
> > support for shared disk file systems.
> 
> I'm still not sure what kind of special support you need. The only
> guarantee you need to provide is that after a barrier all reads on all
> nodes return the same data for those blocks affected by the flush.
> 
> The shared disk file system itself will take care of issueing
> appropriate barrier and flushing the OS caches.
> 
> Am I missing something? ;-)

"In case our user goes up the wall",
we need to guarantee that whatever our users do,
out lower level devices are identical. allways.

so *in case* gfs had a bug, or something other does strange things with
us, we can not trust it to not write concurrently on both nodes to the
same block at the same time.

we have to assume that this can indeed happen,
and do some serialization stuff internally. just in case.

and if we know the expected access pattern of our users,
we can optimize our own internal serialization stuff to
not conflict and degrade performance,
but to only be there as a safety net.

and the (wanted) side effect is, that we always know
which regions of the device have been active,
so we can do the resync correctly eventually.

	lge
