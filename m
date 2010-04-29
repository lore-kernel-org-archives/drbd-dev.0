Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 86257105A7D3
	for <drbd-dev@lists.linbit.com>; Thu, 29 Apr 2010 23:26:00 +0200 (CEST)
Date: Thu, 29 Apr 2010 23:26:00 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20100429212600.GA32440@soda.linbit>
References: <BC2F8964429F14468EA0E6D6CF00E8C994839C@EXHQ.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2F8964429F14468EA0E6D6CF00E8C994839C@EXHQ.corp.stratus.com>
Subject: Re: [Drbd-dev] DRBD small synchronous writes performance
	improvements
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Apr 29, 2010 at 04:00:50PM -0400, Guzovsky, Eduard wrote:
> Hi guys,
> 
> We analyzed DRBD performance of small synchronous write operations on
> systems with RAID controllers.  This i/o pattern happens frequently in
> data base transaction processing workloads. Large RAID caches ensure
> that disk i/o overhead is small - about 100us per 32KB block - and
> network overhead turns into a dominant factor.  In addition to network
> stack processing time, network overhead has two large components
> 
> 1. "Wire time" - the actual time it takes to transmit data. On 1Gig
> network it takes about 270us to transmit 32KB block, on 10Gig - about
> 27us.
> 
> 2. "NIC latency" - the time it takes NIC to start transmitting a packet
> on the sending node plus the time on the receiving node between the
> packet reception by the NIC and delivering the packet to the driver. NIC
> latency is chip specific and depends on "packet/interrupt coalescing"
> setting configurable via "ethtool -C ". The default setting results in
> about a 100us to 125us "short packet round trip" latency.  We reduced it
> to about 50us by effectively disabling packet coalescing.  Have you or
> your customers experimented with this? We are obviously concerned with
> adverse side effects of disabling packet coalescing on whole system
> performance during high network loads.
> 
> We found in our testing that certain DRBD changes - see the patch bellow
> - improve performance of small synchronous writes.  For the reference,
> the testing was done in Xen environment on Dell T610 system with Xeon
> E5520 2.27 GHz CPU, and Dell PERC 6/I RAID controller.  DRBD code was
> running in the 2 way SMP Dom0.
> The patch is made against DRBD version 8.2.7, but it is equally relevant
> to 8.3.7 as corresponding parts of the code did not change
> significantly. This patch is a "rough draft request for comment". It
> contains several changes.
> 
> 1. TCP_QUICKACK option is set incorrectly. The goal was force TCP to
> send and ACK as a  "one time" event.  Instead the code permanently sets
> connection in the QUICKACK mode.

Oh, it is not permanent, tcp will re-enable "pingpong" mode
when it "feels like it".  But you are right, using val = 2 will
re-enter pingpong mode immediately if there actually
have been pending ACKs forced out.

> 2. Socket sndbufsize/rcvbufsize setting is done incorrectly. The code
> sets socket buffer sizes _after_ connection is established.  In order
> for these settings to take effect they should be set _before_ connection
> is established.  We made a quick and dirty change that makes identical
> setting for both meta and data connections.  It would require a bigger
> change to have separate settings because in the current code it is not
> known in advance which socket will be used for which connection.

Apparently I need to re-read some kernel code on this.
If you want to point me to a specific area of code?

> 3. We noticed that on the primary node it takes about 20us to schedule
> DRBD worker thread that packages and sends write request to the
> secondary node. We think it would be better to send request to the
> secondary ASAP and only then continue with primary node processing. So I
> added "schedule()"  hack to drbd_make_request_common() and raised the
> priority of the worker thread. That reduced worker thread scheduling
> delay to about 7us. I am not 100% if this hack is safe - would be very
> interested in your opinion on it.

That's an interessting hack ;-)
What priority do you chose?
What is your "cpu-mask" for the drbd threads?

> 4. We disabled TCP_CORK through drbdsetup utility and modified the code
> to do implicit corking using MSG_MORE flag. TCP code tries to postpone
> sending partial message until the whole message is assembled. So we try
> to send drbd request header first to let the secondary node start
> preparations to receive the data part while the primary node is still
> transmitting the data. May be this behavior  should be a configurable
> variant of tcp corking, because it might not be advantageous for every
> NIC/link speed configuration.

Ok.
We'll see what this does to our test hardware.  Anyways, if it seems to
be beneficial for you, we can certainly add some config option for it.

> We were also considering implementation of "zero copy" receive that
> should improve performance for 10Gig links - that is not part of the
> patch. The basic idea is to intercept incoming data before they get
> queued to the socket in the same way NFS and i-scsi  code do it through
> tcp_read_sock() api.

Yes. I recently suggested that as an enhancement for IET on the
iscsit-target mailing list myself, though to get rid of an additional
memcopy they do for their "fileio" mode.

I don't think it is that easy to adapt for DRBD (or their "block io"
mode), because:

> Then drbd could convert sk_buff chain to bio, if alignment is right,

that is a big iff.
I'm not at all sure how you want to achieve this.
Usually the alignment will be just wrong.

> and avoid expensive data copy. Do you plan to add something like this
> into you future DRBD release so we do not have to do it ourselves? ;-)

Something like this should be very beneficial, but I don't see how we
can achieve the proper alignment of the data pages in the sk_buff.

"native RDMA mode" for DRBD would be a nice thing to have, and possibly
solve this as well.  Maybe we find a feature sponsor for that ;-)

> We would appreciate your comments on the patch.

Will have to do actual review within the next few days.

Thanks,

>  	ok = (sizeof(p) ==
> -		drbd_send(mdev, mdev->data.socket, &p, sizeof(p), MSG_MORE));
> +		drbd_send(mdev, mdev->data.socket, &p, sizeof(p), 0));

> @@ -2234,7 +2241,7 @@
> -			ok = _drbd_send_zc_bio(mdev, req->master_bio);
> +			ok = _drbd_send_zc_bio(mdev, req->master_bio, MSG_MORE);

Ok, I see where you are going.
Maybe rather not have the flags in _drbd_send_zc_bio, but have the
_drbd_send_zc_bio itself add MSG_MORE to all but the last sendpage?

> @@ -2281,7 +2288,7 @@
> -		ok = _drbd_send_zc_bio(mdev, e->private_bio);
> +		ok = _drbd_send_zc_bio(mdev, e->private_bio, 0);

no MSG_MORE here?


> +
> +     /* give a worker thread a chance to pick up the request */
> +	if (remote) {
> +            if (!in_atomic())
> +                    schedule();

You may well drop the if (!in_atomic()),
it cannot possibly be in atomic context there.
Also, the immediately preceding spin_unlock_irq() is a pre-emption
point.  So actually this should not even be necessary.

> +     }
> +
>  	kfree(b); /* if someone else has beaten us to it... */
>  
>  	if (local) {
> diff -aur src.orig/drbd/drbd_worker.c src/drbd/drbd_worker.c
> --- src.orig/drbd/drbd_worker.c	2010-04-01 15:47:54.000000000 -0400
> +++ src/drbd/drbd_worker.c	2010-04-26 18:25:17.000000000 -0400
> @@ -1237,6 +1237,9 @@
>  
>  	sprintf(current->comm, "drbd%d_worker", mdev_to_minor(mdev));
>  
> +	current->policy = SCHED_RR;  /* Make this a realtime task! */
> +	current->rt_priority = 2;    /* more important than all other
> tasks */
> +

Not sure about this.
I don't really want to do crypto operations
from a real time kernel thread.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
