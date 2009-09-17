Return-Path: <BATV+82a027cf1159705faf65+2216+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B23C510623BA
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2009 18:11:17 +0200 (CEST)
Date: Thu, 17 Sep 2009 12:11:09 -0400
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@suse.de>
Message-ID: <20090917161108.GA3361@infradead.org>
References: <200909151645.14256.philipp.reisner@linbit.com>
	<20090915231931.GB7636@infradead.org>
	<20090917081251.GC8045@barkeeper1-xen.linbit>
	<1253203365.7845.14.camel@mulgrave.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1253203365.7845.14.camel@mulgrave.site>
Cc: Bart Van Assche <bart.vanassche@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Sam Ravnborg <sam@ravnborg.org>, Neil Brown <neilb@suse.de>,
	Nikanth Karthikesan <knikanth@suse.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph Hellwig <hch@infradead.org>, Lars Marowsky-Bree <lmb@suse.de>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Jens Axboe <jens.axboe@oracle.com>, Dave Jones <davej@redhat.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Sep 17, 2009 at 10:02:45AM -0600, James Bottomley wrote:
> So I think Christoph's NAK is rooted in the fact that we have a
> proliferation of in-kernel RAID implementations and he's trying to
> reunify them all again.
> 
> As part of the review, reusing the kernel RAID (and actually logging)
> logic did come up and you added it to your todo list.  Perhaps expanding
> on the status of that would help, since what's being looked for is that
> you're not adding more work to the RAID reunification effort and that
> you do have a plan and preferably a time frame for coming into sync with
> it.

Yes.  RDBD has spend tons of time out of tree, and if they want to put
it in now I think requiring them to do their homework is a good idea.

Note that the in-kernel raid implementation is just a rather small part
of this, what's much more important is the user interface.  A big part
of raid unification is that we can support on proper interface to deal
with raid vs volume management, and DRBD adds another totally
incompatible one to that.  We'd be much better off adding the drbd in
the write protocol (at least the most recent version) to DM instead of
adding another big chunk of framework.

