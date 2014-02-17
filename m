Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C96FD101AC79
	for <drbd-dev@lists.linbit.com>; Tue, 18 Feb 2014 17:42:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 90BE72A9B8C
	for <drbd-dev@lists.linbit.com>; Tue, 18 Feb 2014 17:42:59 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id HgTOFgvwuI-Z for <drbd-dev@lists.linbit.com>;
	Tue, 18 Feb 2014 17:42:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 737392AA0F3
	for <drbd-dev@lists.linbit.com>; Tue, 18 Feb 2014 17:42:59 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uKJlxxE2yipX for <drbd-dev@lists.linbit.com>;
	Tue, 18 Feb 2014 17:42:59 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 5252E2A9B8C
	for <drbd-dev@lists.linbit.com>; Tue, 18 Feb 2014 17:42:59 +0100 (CET)
Resent-Message-ID: <20140218164259.GA29127@soda.linbit>
Date: Mon, 17 Feb 2014 22:43:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com
Message-ID: <20140217194340.GF26776@mwanda>
References: <20120608123128.GA18293@elgon.mountain>
	<20120608185008.GC8030@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120608185008.GC8030@soda.linbit>
Subject: Re: [Drbd-dev] [DRBD-user] [patch -resend] drbd: fix
	resync_dump_detail() output
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jun 08, 2012 at 08:50:08PM +0200, Lars Ellenberg wrote:
> On Fri, Jun 08, 2012 at 03:31:28PM +0300, Dan Carpenter wrote:
> > The tests here aren't correct.  It should be doing a shift before doing
> > the bitwise AND.  (bme->flags & BME_NO_WRITES) is always false and
> > (bme->flags & BME_LOCKED) checks for BME_NO_WRITES instead of checking
> > for locked.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Ack.
> 
> > ---
> > I sent this to the drbd-user list in March, but never recieved a
> > response.
> 
> Sorry, seems to have been lost :-(
> 

Still lost in 2014.  :P  Who is supposed to take this patch?  I assume
it's someone on the drbd list?

regards,
dan carpenter

> 	Lars
> 
> > diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
> > index 2959cdf..ffe1ee4 100644
> > --- a/drivers/block/drbd/drbd_proc.c
> > +++ b/drivers/block/drbd/drbd_proc.c
> > @@ -187,8 +187,10 @@ static void resync_dump_detail(struct seq_file *seq, struct lc_element *e)
> >  	struct bm_extent *bme = lc_entry(e, struct bm_extent, lce);
> >  
> >  	seq_printf(seq, "%5d %s %s\n", bme->rs_left,
> > -		   bme->flags & BME_NO_WRITES ? "NO_WRITES" : "---------",
> > -		   bme->flags & BME_LOCKED ? "LOCKED" : "------"
> > +		   test_bit(BME_NO_WRITES, &bme->flags) ?
> > +			"NO_WRITES" : "---------",
> > +		   test_bit(BME_LOCKED, &bme->flags) ?
> > +			"LOCKED" : "------"
> >  		   );
> >  }
> 
> -- 
> : Lars Ellenberg
> : LINBIT | Your Way to High Availability
> : DRBD/HA support and consulting http://www.linbit.com
