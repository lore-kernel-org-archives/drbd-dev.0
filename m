Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 - crash due to NULL page* in drbd_send_page
Date: Wed, 16 Aug 2006 09:37:48 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671036253BF@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> > > RQ_DRBD_ON_WIRE flag is set in the request -- is there something
> > > suitable we could issue a wait_event_interruptible() on in
> > > got_BlockAck() to wait for this?
> [...]
> > I attached the patch. I guess you will rerun your tests with this
> > patch. [ it is completely untested ]
> >
>=20
> And the second version of that patch...
>=20

I like it -- simple and elegant; wish I'd thought of it!

I just tried this and it's spot on - no crash plus, to be sure, I added
some trace in drbd_end_req to print the stack if it is called with the
on-wire flag set and this actually completes the request - here's a
sample of the output (and note how much goes on between the time the ack
is received and the time the request is finally completed from the
worker context - I wonder if the fact that a different socket is used
for the ack might also contribute to the odd timing):

drbd1: data >>> Data (sector 12618, size 8000, id e81b8f28, seq 766b1, f
0)	<<< started send data for drbd1/12618
drbd1: meta <<< WriteAck (sector 125b8, size 8000, id e81b8208, seq
1298)
drbd1: meta <<< WriteAck (sector 125f8, size 3000, id ec1cae48, seq
1299)
drbd1: meta <<< WriteAck (sector 12610, size 1000, id e81b8cf8, seq
129a)
drbd0: data >>> Data (sector 129d0, size 3000, id e81b8ba8, seq 142f, f
0)	<<< started send data for drbd0/129d0
drbd0: meta <<< WriteAck (sector 129b8, size 3000, id e81b8da0, seq
142e)
drbd2: meta >>> WriteAck (sector 11af8, size 8000, id ea5acc88, seq
767f3)
drbd2: meta >>> WriteAck (sector 11b38, size 3000, id ea5aca90, seq
767f4)
drbd2: meta >>> WriteAck (sector 11b50, size 1000, id ea5ac320, seq
767f5)
drbd2: meta >>> WriteAck (sector 11b58, size 8000, id ea5acbe0, seq
767f6)
drbd2: meta >>> WriteAck (sector 11b98, size 3000, id ea5ac128, seq
767f7)
drbd2: meta >>> WriteAck (sector 11bb0, size 8000, id ea5ace80, seq
767f8)
drbd2: meta >>> WriteAck (sector 11bf0, size 3000, id ea5ac588, seq
767f9)
drbd2: meta >>> WriteAck (sector 11c08, size 3000, id ea5ac898, seq
767fa)
drbd2: data <<< UnplugRemote (7)
drbd0: meta <<< WriteAck (sector 129d0, size 3000, id e81b8ba8, seq
142f)	<<< received Ack for drbd0/129d0
drbd0: ASSERT( req->rq_status & RQ_DRBD_ON_WIRE ) in
/sandbox/sgraham/sn/trunk/platform/drbd/8.0/drbd/drbd_receiver.c:2785
drbd0: in got_BlockAck:2799: ap_pending_cnt =3D -1 < 0 !
drbd0: Sector 129d0, id e81b8ba8, seq 142f
drbd1: meta <<< WriteAck (sector 12618, size 8000, id e81b8f28, seq
129b)	<<< received Ack for drbd1/12618
drbd1: ASSERT( req->rq_status & RQ_DRBD_ON_WIRE ) in
/sandbox/sgraham/sn/trunk/platform/drbd/8.0/drbd/drbd_receiver.c:2785
drbd1: in got_BlockAck:2799: ap_pending_cnt =3D -1 < 0 !
drbd1: Sector 12618, id e81b8f28, seq 129b
drbd2: data <<< Data (sector 3f1b0000300763ec, size 1000, id ea5ac898,
seq 1409, f 0)
drbd2: meta >>> WriteAck (sector 11c20, size 1000, id ea5ac898, seq
767fb)
drbd2: data <<< Barrier (barrier 0)
drbd2: meta >>> BarrierAck (barrier 6976)
drbd2: data <<< Data (sector 401b0000300763ec, size 1000, id ea5ac898,
seq 140a, f 0)
drbd2: data <<< UnplugRemote (7)
drbd0: Request completed from send - Ack must have arrived early
<<< finally finished sending drbd0/129d0
 [<c0105081>] show_trace+0x21/0x30
 [<c01051be>] dump_stack+0x1e/0x20
 [<f128900d>] drbd_end_req+0x2fd/0x570 [drbd]
 [<f127f999>] w_send_dblock+0x129/0x280 [drbd]
 [<f1280b36>] drbd_worker+0x186/0x4f7 [drbd]
 [<f129006d>] drbd_thread_setup+0x7d/0xe0 [drbd]
 [<c0102d85>] kernel_thread_helper+0x5/0x10
drbd0: data >>> UnplugRemote (7)
drbd0: data >>> Barrier (barrier 4882)
drbd0: meta <<< BarrierAck (barrier 4882)
drbd1: Request completed from send - Ack must have arrived early
<<< finally finished drbd1/12618
 [<c0105081>] show_trace+0x21/0x30
 [<c01051be>] dump_stack+0x1e/0x20
 [<f128900d>] drbd_end_req+0x2fd/0x570 [drbd]
 [<f127f999>] w_send_dblock+0x129/0x280 [drbd]
 [<f1280b36>] drbd_worker+0x186/0x4f7 [drbd]
 [<f129006d>] drbd_thread_setup+0x7d/0xe0 [drbd]
 [<c0102d85>] kernel_thread_helper+0x5/0x10

Thanks for the fix!
Simon
