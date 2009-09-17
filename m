Return-Path: <lars.ellenberg@linbit.com>
Date: Thu, 17 Sep 2009 10:12:51 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20090917081251.GC8045@barkeeper1-xen.linbit>
References: <200909151645.14256.philipp.reisner@linbit.com>
	<20090915231931.GB7636@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090915231931.GB7636@infradead.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Sam Ravnborg <sam@ravnborg.org>, Neil Brown <neilb@suse.de>,
	Nikanth Karthikesan <knikanth@suse.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Bart Van Assche <bart.vanassche@gmail.com>,
	Lars Marowsky-Bree <lmb@suse.de>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Jens Axboe <jens.axboe@oracle.com>, Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


I took the liberty to extend the CC list again a little bit.

On Tue, Sep 15, 2009 at 07:19:31PM -0400, Christoph Hellwig wrote:
> On Tue, Sep 15, 2009 at 04:45:13PM +0200, Philipp Reisner wrote:
> > Hi Linus,
> > 
> > Please pull
> > git://git.drbd.org/linux-2.6-drbd.git drbd
> > 
> > DRBD is a shared-nothing, replicated block device. It is designed to
> > serve as a building block for high availability clusters and
> > in this context, is a "drop-in" replacement for shared storage.
> > 
> > It has been discussed and reviewed on the list since March,
> > and Andrew has asked us to send a pull request for 2.6.32-rc1.


This has been discussed before on LKML.

To contrast your NACK by a few previous posts
I perceived effectively as ACKS:
e.g.

Andrew Morton:
http://lkml.org/lkml/2009/5/1/307

	"Oh.  Thanks.  Well we should all get cracking on it then."

Lars Marowsky-Bree:
http://lkml.org/lkml/2009/5/5/224

	"I would suggest at this time, we may want to refocus on the remaining
	objections to merging drbd as a driver in the short-term."

In reply to that,

	James Bottomley:
	http://lkml.org/lkml/2009/5/5/226

		"I'd agree with that.  drbd essentially qualifies as a
		driver under our new merge rules, so we should be
		thinking about blockers to getting it into the tree
		first (serious issues) and working out kinks
		(like raid unification) after it gets in."

	Neil Brown:
	http://lkml.org/lkml/2009/5/5/332

		"I cannot imagine that there would be any. Given its
		history, its popularity, and its modularity, there can
		be no question about merging it"

hch:
> 
> The last thing we need is another bloody raid-reimplementation,

It is not RAID, it is replication, see also that blog post below.

> coupled with a propritary on the wire protocol.

http://www.openformats.org/en1
proprietary:
"the mode of presentation of its data is opaque
 and its specification is not publicly available"

Which does not apply to DRBD.

So lets settle for "homegrown".

Besides, what was the non-proprietary, generally accepted,
link layer agnostic block-level replication protocol again?

And in case you're referring to MD/NBD or MD/iSCSI or some such,
http://fghaas.wordpress.com/2009/09/16/alternatives-to-drbd/ may be a
worthy read. Certainly not deeply technical, but sufficient to
illustrate the most important points.

> NACK as far as I am concerned.

Too bad :(
What can we do to have that revised?


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
