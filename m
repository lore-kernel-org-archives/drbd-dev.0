Return-Path: <Lars.Ellenberg@linbit.com>
Date: Tue, 27 Jul 2004 20:32:09 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: XFS on DRBD
Message-ID: <TNTwJCwDj1uhUP6Xn5YBaX4=lge@web.de>
References: <200405251206.11287.philipp.reisner@linbit.com> <20040526073608.GA21855@infradead.org> <200407271015.53469.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407271015.53469.philipp.reisner@linbit.com>
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

/ 2004-07-27 10:15:53 +0200
\ Philipp Reisner:
> On Wednesday 26 May 2004 09:36, you wrote:
> > XFS does I/O on slab-allocated pages, which not a lot other code in
> > the kernel does, and it seems drbd doesn't like that.  Do you have
> > a pointer to the drbd code for Linux 2.6 so I can take a look?
> 
> Hi Christoph,
> 
> Drbd reached release status and finally everything works, but we have a
> rather uggly workaround for XFS.
> 
> We usually use sendpage() to send the data blocks over the network.
> But when XFS hands us its slab-allocated pages over, we may not
> use sendpage. 
> 
>   If we call sendpage on such a page it will crash, since sendpage()
... first does a get_page(), and then ...
>   calls put_page() after the job is done.
 --> but PageSlab(), so: BOOM.
this all happens _before_ any bio_endio is called on the associated bio.

> Christoph,
> 
> IMHO XFS should only pass pages down the IO path which have a correct
> page_count. 
> 
> Which is the right forum to discuss this issue ?

I suggest we either can solve this right here,
or we move this to lkml ...
maybe we should move to lkml anyways, since actually this
is a generic issue: how to pass slab pages around to other
sub systems, which do not know anything about that page,
but expect to be able to
  get_page(); queue_some_asynchronous_work_and_return();
      ... later ... put_page();

	Lars Ellenberg
