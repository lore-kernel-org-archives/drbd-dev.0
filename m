Return-Path: <lars@linbit.com>
Date: Fri, 3 Sep 2004 15:02:01 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.4 on Wednesday the 8th...
Message-ID: <20040903130201.GC32355@nudl>
References: <200409031315.24317.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409031315.24317.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Sep 03, 2004 at 01:15:24PM +0200, Philipp Reisner wrote:
> Hi,
> 
> I plan to release 0.7.4 on Wednesday... 
> 
> BTW, I think we should _not_ define DRBD_DISABLE_SENDPAGE by
> default. I will try to test sendpage() on 2.4.x on bloody/mary
> on Tuesday. If it works I will comment it our in drbd_config.h

we try to get hand on the suse test cluster(s) here,
and I'm going to run all my test cases in both their current 2.6 and
their 2.4 SLES8 kernel, and I'm going to do that with reiserfs and xfs
as well. so if it goes havock, I'll tell those fs guys what I think
about it. in case we in fact have a DRBD internal error (the reportet
oopsen on 2.4 has been at sync start), then we have to review that part
of the code (waiting for page_count of our private ee pages to drop to
one again, that stuff.)
I'm not yet sure when we will have time to do so, the conference
schedule here seems a little bit loaded, but we really need to do that
while I am here. so we will ;)

	lge
