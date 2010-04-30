Return-Path: <Eduard.Guzovsky@stratus.com>
Received: from mailhub5.stratus.com (mailhub5.stratus.com [134.111.1.18])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D9ED5105A933
	for <drbd-dev@lists.linbit.com>; Sat,  1 May 2010 00:12:17 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Apr 2010 18:11:13 -0400
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C99483A1@EXHQ.corp.stratus.com>
In-Reply-To: 20100429212600.GA32440@soda.linbit
References: <BC2F8964429F14468EA0E6D6CF00E8C994839C@EXHQ.corp.stratus.com>
	20100429212600.GA32440@soda.linbit
From: "Guzovsky, Eduard" <Eduard.Guzovsky@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] DRBD small synchronous writes performanceimprovements
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Lars, thank you for your quick response. My answers/comments are
inline.

>=20
> > 2. Socket sndbufsize/rcvbufsize setting is done incorrectly. The
code
> > sets socket buffer sizes _after_ connection is established.  In
order
> > for these settings to take effect they should be set _before_
connection
> > is established.  We made a quick and dirty change that makes
identical
> > setting for both meta and data connections.  It would require a
bigger
> > change to have separate settings because in the current code it is
not
> > known in advance which socket will be used for which connection.
>=20
> Apparently I need to re-read some kernel code on this.
> If you want to point me to a specific area of code?
>=20

I never had a chance to track this behavior to a specific area of the
linux tcp code, but I was burned by this problem before.=20

Here is a quote from tcp(7) man page.

 "On individual  connections,  the  socket buffer size must be
 set prior to the listen() or connect() calls in order to=20
 have  it  take  effect"

I verified via a simple experiment that this problem exists in DRBD and
that the suggested patch fixes it.

Just configure large DRBD socket buffer size, let say 4MB. Initiate
large disk writes. You can see in the tcpdump capture that the secondary
node never advertizes receive window above 128KB. With the suggested
patch receive window will go up to 2MB.=20

Goes without saying that the patch is kind of crude - it sets the socket
buffer size on both data and meta connections. It would require more
significant code changes to only fix data connection because it is not
known a priory which of the two sockets will be used for the data
connection.

Also, auto-tuning alleviates the whole problem.=20


> > 3. We noticed that on the primary node it takes about 20us to
schedule
> > DRBD worker thread that packages and sends write request to the
> > secondary node. We think it would be better to send request to the
> > secondary ASAP and only then continue with primary node processing.
So I
> > added "schedule()"  hack to drbd_make_request_common() and raised
the
> > priority of the worker thread. That reduced worker thread scheduling
> > delay to about 7us. I am not 100% if this hack is safe - would be
very
> > interested in your opinion on it.
>=20
> That's an interessting hack ;-)
> What priority do you chose?

Real time, RR, 2 - the same as asender thread.

> What is your "cpu-mask" for the drbd threads?

We do not specify affinity - any cpu is up for grabs.

>=20
> > 4. We disabled TCP_CORK through drbdsetup utility and modified the
code
> > to do implicit corking using MSG_MORE flag. TCP code tries to
postpone
> > sending partial message until the whole message is assembled. So we
try
> > to send drbd request header first to let the secondary node start
> > preparations to receive the data part while the primary node is
still
> > transmitting the data. May be this behavior  should be a
configurable
> > variant of tcp corking, because it might not be advantageous for
every
> > NIC/link speed configuration.
>=20
> Ok.
> We'll see what this does to our test hardware.  Anyways, if it seems
to
> be beneficial for you, we can certainly add some config option for it.

DRBD config option would be great because this method might not be
advantageous in all configurations.

>=20
> > We were also considering implementation of "zero copy" receive that
> > should improve performance for 10Gig links - that is not part of the
> > patch. The basic idea is to intercept incoming data before they get
> > queued to the socket in the same way NFS and i-scsi  code do it
through
> > tcp_read_sock() api.
>=20
> Yes. I recently suggested that as an enhancement for IET on the
> iscsit-target mailing list myself, though to get rid of an additional
> memcopy they do for their "fileio" mode.
>=20
> I don't think it is that easy to adapt for DRBD (or their "block io"
> mode), because:
>=20
> > Then drbd could convert sk_buff chain to bio, if alignment is right,
>=20
> that is a big iff.
> I'm not at all sure how you want to achieve this.
> Usually the alignment will be just wrong.
>=20
> > and avoid expensive data copy. Do you plan to add something like
this
> > into you future DRBD release so we do not have to do it ourselves?
;-)
>=20
> Something like this should be very beneficial, but I don't see how we
> can achieve the proper alignment of the data pages in the sk_buff.
>=20
> "native RDMA mode" for DRBD would be a nice thing to have, and
possibly
> solve this as well.  Maybe we find a feature sponsor for that ;-)
>=20

Here is a plan for getting alignment right. I will assume usage of the
Intel 82599 10Gig chip and the corresponding ixgbe driver.=20

The nice thing about this chip and the driver is that by default they
supports packet splitting. That means that Ethernet/TCP/IP header of the
incoming packet is received in one memory buffer, while the data portion
is received into another memory buffer. This second buffer is half-page
(2KB) aligned. I guess they did not make it the whole page aligned to
reduce memory waste. Still, AFAIK that should more than satisfy bio
alignment requirements. Is it 512 bytes?

We set interface mtu to 9000. Let's say DRBD does a 32KB write. DRBD can
control (or at least give a hint to TCP) how the whole request should be
"packetized" using MSG_MORE flag. DRBD Request Header is sent as one
packet (no MSG_MORE) flag. Then each even (counting from 0) data page is
sent with MSG_MORE flag, each odd data page is sent without MSG_MORE
flag. This should result in two data pages per packet transmits.

I instrumented DRBD to do just that. I also instrumented ixgbe driver to
dump skb with the received data on the secondary node. Here is what I
got for a 32KB write.

 skb 0xebc04c80 len 84 data_len 32 frags 1     <-- 52 bytes TCP/IP
header
  frag_page 0xc146ba40 offset 0 size 32        <-- 32 bytes
Drbd_Data_Packet

 skb 0xe362b0c0 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP
header
  frag_page 0xc146ba60 offset 2048 size 2048   <-- 8KB of data
  frag_page 0xc146baa0 offset 2048 size 2048
  frag_page 0xc146bac0 offset 0 size 2048
  frag_page 0xc146bae0 offset 2048 size 2048

 skb 0xe35a9440 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP
header
  frag_page 0xc146bb00 offset 2048 size 2048   <-- 8KB of data
  frag_page 0xc146bb40 offset 2048 size 2048
  frag_page 0xc146bb60 offset 0 size 2048
  frag_page 0xc146bb80 offset 2048 size 2048

 skb 0xe99ada80 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP
header
  frag_page 0xc146bbc0 offset 0 size 2048      <-- 8KB of data
  frag_page 0xc146bc00 offset 2048 size 2048
  frag_page 0xc146bc20 offset 0 size 2048
  frag_page 0xc146bc40 offset 2048 size 2048

 skb 0xebc4c300 len 8244 data_len 8192 frags 4 <-- 52 bytes TCP/IP
header
  frag_page 0xc146bc60 offset 0 size 2048      <-- 8KB of data
  frag_page 0xc146bca0 offset 0 size 2048
  frag_page 0xc146bcc0 offset 0 size 2048
  frag_page 0xc146bce0 offset 2048 size 2048

As you can see the data is 2KB aligned.


>=20
> >  	ok =3D (sizeof(p) =3D=3D
> > -		drbd_send(mdev, mdev->data.socket, &p, sizeof(p),
MSG_MORE));
> > +		drbd_send(mdev, mdev->data.socket, &p, sizeof(p), 0));
>=20
> > @@ -2234,7 +2241,7 @@
> > -			ok =3D _drbd_send_zc_bio(mdev, req->master_bio);
> > +			ok =3D _drbd_send_zc_bio(mdev, req->master_bio,
MSG_MORE);
>=20
> Ok, I see where you are going.
> Maybe rather not have the flags in _drbd_send_zc_bio, but have the
> _drbd_send_zc_bio itself add MSG_MORE to all but the last sendpage?

Sure, that should work too.

>=20
> > @@ -2281,7 +2288,7 @@
> > -		ok =3D _drbd_send_zc_bio(mdev, e->private_bio);
> > +		ok =3D _drbd_send_zc_bio(mdev, e->private_bio, 0);
>=20
> no MSG_MORE here?
>=20

May be. I have not played with "remote reads" performance.

>=20
> > +
> > +     /* give a worker thread a chance to pick up the request */
> > +	if (remote) {
> > +            if (!in_atomic())
> > +                    schedule();
>=20
> You may well drop the if (!in_atomic()),
> it cannot possibly be in atomic context there.

if (!in_atomic()) is paranoia ;-)


> Also, the immediately preceding spin_unlock_irq() is a pre-emption
> point.  So actually this should not even be necessary.

It is necessary in our case - our kernel is compiled without
CONFIG_PREEMPT so threads are not preemptable in the kernel. So may be
another drbd configuration option would be useful here.

> > diff -aur src.orig/drbd/drbd_worker.c src/drbd/drbd_worker.c
> > --- src.orig/drbd/drbd_worker.c	2010-04-01 15:47:54.000000000
-0400
> > +++ src/drbd/drbd_worker.c	2010-04-26 18:25:17.000000000 -0400
> > @@ -1237,6 +1237,9 @@
> >
> >  	sprintf(current->comm, "drbd%d_worker", mdev_to_minor(mdev));
> >
> > +	current->policy =3D SCHED_RR;  /* Make this a realtime task! */
> > +	current->rt_priority =3D 2;    /* more important than all other
> > tasks */
> > +
>=20
> Not sure about this.
> I don't really want to do crypto operations
> from a real time kernel thread.

Sure, I agree. Though in our case we do not use crypto stuff. So how
about one more drbd configuration option? ;-)

Thanks again,

-Ed



