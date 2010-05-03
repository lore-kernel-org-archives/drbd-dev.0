Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3E1BC1089452
	for <drbd-dev@lists.linbit.com>; Mon,  3 May 2010 09:08:56 +0200 (CEST)
Date: Mon, 3 May 2010 09:08:55 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20100503070855.GB772@soda.linbit>
References: <BC2F8964429F14468EA0E6D6CF00E8C994839C@EXHQ.corp.stratus.com>
	<BC2F8964429F14468EA0E6D6CF00E8C99483A1@EXHQ.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2F8964429F14468EA0E6D6CF00E8C99483A1@EXHQ.corp.stratus.com>
Subject: Re: [Drbd-dev] DRBD small synchronous writes performanceimprovements
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Apr 30, 2010 at 06:11:13PM -0400, Guzovsky, Eduard wrote:
> > > 3. We noticed that on the primary node it takes about 20us to
> > > schedule DRBD worker thread that packages and sends write request
> > > to the secondary node. We think it would be better to send request
> > > to the secondary ASAP and only then continue with primary node
> > > processing.  So I added "schedule()"  hack to
> > > drbd_make_request_common() and raised the priority of the worker
> > > thread. That reduced worker thread scheduling delay to about 7us.
> > > I am not 100% if this hack is safe - would be very interested in
> > > your opinion on it.

> > What is your "cpu-mask" for the drbd threads?
> 
> We do not specify affinity - any cpu is up for grabs.

If you do not set cpu-mask with drbdsetup,
DRBD kernel threads of one specific minor
will pin themselves on the same single cpu.

So maybe try: drbdsetup 0 syncer --cpu-mask ff

> > > We were also considering implementation of "zero copy" receive
> > > that should improve performance for 10Gig links - that is not part
> > > of the patch. The basic idea is to intercept incoming data before
> > > they get queued to the socket in the same way NFS and i-scsi  code
> > > do it through tcp_read_sock() api.
> > 
> > Yes. I recently suggested that as an enhancement for IET on the
> > iscsit-target mailing list myself, though to get rid of an additional
> > memcopy they do for their "fileio" mode.
> > 
> > I don't think it is that easy to adapt for DRBD (or their "block io"
> > mode), because:
> > 
> > > Then drbd could convert sk_buff chain to bio, if alignment is right,
> > 
> > that is a big iff.
> > I'm not at all sure how you want to achieve this.
> > Usually the alignment will be just wrong.
> > 
> > > and avoid expensive data copy. Do you plan to add something like
> > > this into you future DRBD release so we do not have to do it
> > > ourselves? ;-)
> > 
> > Something like this should be very beneficial, but I don't see how we
> > can achieve the proper alignment of the data pages in the sk_buff.
> > 
> > "native RDMA mode" for DRBD would be a nice thing to have, and possibly
> > solve this as well.  Maybe we find a feature sponsor for that ;-)
> > 
> 
> Here is a plan for getting alignment right. I will assume usage of the
> Intel 82599 10Gig chip and the corresponding ixgbe driver. 
> 
> The nice thing about this chip and the driver is that by default they
> supports packet splitting. That means that Ethernet/TCP/IP header of
> the incoming packet is received in one memory buffer, while the data
> portion is received into another memory buffer. This second buffer is
> half-page (2KB) aligned. I guess they did not make it the whole page
> aligned to reduce memory waste. Still, AFAIK that should more than
> satisfy bio alignment requirements. Is it 512 bytes?
> 
> We set interface mtu to 9000. Let's say DRBD does a 32KB write. DRBD
> can control (or at least give a hint to TCP) how the whole request
> should be "packetized" using MSG_MORE flag. DRBD Request Header is
> sent as one packet (no MSG_MORE) flag. Then each even (counting from
> 0) data page is sent with MSG_MORE flag, each odd data page is sent
> without MSG_MORE flag. This should result in two data pages per packet
> transmits.
> 
> I instrumented DRBD to do just that. I also instrumented ixgbe driver
> to dump skb with the received data on the secondary node. Here is what
> I got for a 32KB write.
> 
>  skb 0xebc04c80 len 84 data_len 32 frags 1     <-- 52 bytes TCP/IP header
>   frag_page 0xc146ba40 offset 0 size 32        <-- 32 bytes Drbd_Data_Packet
> 
>  skb 0xe362b0c0 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP header
>   frag_page 0xc146ba60 offset 2048 size 2048   <-- 8KB of data
>   frag_page 0xc146baa0 offset 2048 size 2048
>   frag_page 0xc146bac0 offset 0 size 2048
>   frag_page 0xc146bae0 offset 2048 size 2048
> 
>  skb 0xe35a9440 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP header
>   frag_page 0xc146bb00 offset 2048 size 2048   <-- 8KB of data
>   frag_page 0xc146bb40 offset 2048 size 2048
>   frag_page 0xc146bb60 offset 0 size 2048
>   frag_page 0xc146bb80 offset 2048 size 2048
> 
>  skb 0xe99ada80 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP header
>   frag_page 0xc146bbc0 offset 0 size 2048      <-- 8KB of data
>   frag_page 0xc146bc00 offset 2048 size 2048
>   frag_page 0xc146bc20 offset 0 size 2048
>   frag_page 0xc146bc40 offset 2048 size 2048
> 
>  skb 0xebc4c300 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP header
>   frag_page 0xc146bc60 offset 0 size 2048      <-- 8KB of data
>   frag_page 0xc146bca0 offset 0 size 2048
>   frag_page 0xc146bcc0 offset 0 size 2048
>   frag_page 0xc146bce0 offset 2048 size 2048
> 
> As you can see the data is 2KB aligned.

So you suggest we could "sometimes" (maybe even "most of the time")
get_page, assign to bvec, submit, and on completion adjust skb for the
"recvmsg" that never happens.
We'd still need the "slowpath" memcpy code for those fragments that
happen to be not aligned.
And we'd need ot convert DRBDs currently blocking network IO
into something that uses the sk_*_callbacks directly.

But yes, this seems to be possible.

> > > +     /* give a worker thread a chance to pick up the request */
> > > +	if (remote) {
> > > +            if (!in_atomic())
> > > +                    schedule();
> > 
> > You may well drop the if (!in_atomic()),
> > it cannot possibly be in atomic context there.
> 
> if (!in_atomic()) is paranoia ;-)

It there are several potentially sleeping functions called before from
this context, so it probably had BUG()ed before if it was atomic.

> > Also, the immediately preceding spin_unlock_irq() is a pre-emption
> > point.  So actually this should not even be necessary.
> 
> It is necessary in our case - our kernel is compiled without
> CONFIG_PREEMPT so threads are not preemptable in the kernel. So may be
> another drbd configuration option would be useful here.
> 
> > > diff -aur src.orig/drbd/drbd_worker.c src/drbd/drbd_worker.c
> > > --- src.orig/drbd/drbd_worker.c	2010-04-01 15:47:54.000000000
> -0400
> > > +++ src/drbd/drbd_worker.c	2010-04-26 18:25:17.000000000 -0400
> > > @@ -1237,6 +1237,9 @@
> > >
> > >  	sprintf(current->comm, "drbd%d_worker", mdev_to_minor(mdev));
> > >
> > > +	current->policy = SCHED_RR;  /* Make this a realtime task! */
> > > +	current->rt_priority = 2;    /* more important than all other
> > > tasks */
> > > +
> > 
> > Not sure about this.
> > I don't really want to do crypto operations
> > from a real time kernel thread.
> 
> Sure, I agree. Though in our case we do not use crypto stuff. So how
> about one more drbd configuration option? ;-)

We'll talk this through.  But please try the mentioned drbdsetup
cpu-mask stuff, that should make the drbd worker thread send the request
from an other cpu even while this context is still submitting it locally.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
