Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 - crash due to NULL page* in drbd_send_page
Date: Tue, 15 Aug 2006 16:30:31 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103625314@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>,
	<drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Well, FWIW, I think my theory is correct -- I added an assert to
got_BlockAck that the ON_WIRE flag is set and it hit:

drbd1: data >>> Data (sector 12470, size ffffffe8, id e822dbe0, seq
10ea, f 0)
drbd1: meta <<< WriteAck (sector 12470, size 1000, id e822dbe0, seq
10ea)
drbd1: ASSERT( req->rq_status & RQ_DRBD_ON_WIRE ) in
/sandbox/sgraham/sn/trunk/platform/drbd/8.0/drbd/drbd_receiver.c:2785
drbd1: in got_BlockAck:2799: ap_pending_cnt =3D -1 < 0 !
drbd1: Sector 12470, id e822dbe0, seq 10ea

For example -- no crash in this case, but that's just dumb luck I think;
I know you guys are busy, but do you have any suggestions for the right
way to have got_BlockAck wait for the send thread to complete?

Simon

> -----Original Message-----
> From: Graham, Simon
> Sent: Tuesday, August 15, 2006 3:47 PM
> To: Graham, Simon; drbd-dev@linbit.com
> Subject: RE: [Drbd-dev] DRBD-8 - crash due to NULL page* in
> drbd_send_page
>=20
> Have now traced the network and I am very confused -- I'm still
> convinced that the problem is that we are still in drbd_send_zc_bio
> when the Ack for the write is received BUT the data is correctly and
> completely sent on the wire to the peer who turns around and sends a
> WriteAck to it.
>=20
> I suppose it's theoretically possible that sending the final portion
of
> the data from drbd_send_zc_bio might end up being pended; maybe the
> pipe is full when we go to send it which causes the worker thread to
> get suspended. That being the case, it's possible that this thread
> doesn't get rescheduled until waaaaay later - specifically, AFTER the
> Ack has been received and the bio completed and freed -- now we return
> to the worker thread and attempt to continue to loop through the (now
> free) bio with __bio_for_each_segment -- does this seem feasible?
>=20
> Assuming for the minute that this IS the cause, what would a suitable
> solution be? We really need to delay processing the Ack until the
send-
> dblock/send-block has finished -- i.e. we should wait until the
> RQ_DRBD_ON_WIRE flag is set in the request -- is there something
> suitable we could issue a wait_event_interruptible() on in
> got_BlockAck() to wait for this?
>=20
> /simgr
>=20
> > -----Original Message-----
> > From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-
> bounces@linbit.com]
> > On Behalf Of Graham, Simon
> > Sent: Tuesday, August 15, 2006 2:56 PM
> > To: drbd-dev@linbit.com
> > Subject: [Drbd-dev] DRBD-8 - crash due to NULL page* in
> drbd_send_page
> >
> > I've been seeing a fairly reproducible crash in _drbd_send_page due
> to
> > a
> > NULL page pointer; my working theory is that somehow the bio is
being
> > freed whilst it is still in use and I think I have some evidence of
> > this
> > now -- I modified drbd_send_page to print out info on the request in
> > progress when the error occurs and have the following trace:
> >
> > drbd1: data >>> Data (sector 1560250, id e7f15e10, seq b75, f 0)
> > drbd1: meta <<< WriteAck (sector 1560250, size 1000, id e7f15e10,
seq
> > b75)
> > drbd1: in got_BlockAck:2796: ap_pending_cnt =3D -1 < 0 !
> > drbd1: Sector 1560250, id e7f15e10, seq b75
> >
> > drbd1: drbd_send_zc_bio - NULL Page; bio eb49d380, bvec c07678fc
> > drbd1:     sector: 1560250, block_id: e7f15e10, seq b75
> >  [<c0105081>] show_trace+0x21/0x30
> >  [<c01051be>] dump_stack+0x1e/0x20
> >  [<f1291400>] _drbd_send_zc_bio+0x100/0x140 [drbd]
> >  [<f1291582>] drbd_send_dblock+0x142/0x230 [drbd]
> >  [<f127f8a6>] w_send_dblock+0x36/0x260 [drbd]
> >  [<f1280b16>] drbd_worker+0x186/0x4f7 [drbd]
> >  [<f128ffdd>] drbd_thread_setup+0x7d/0xe0 [drbd]
> >  [<c0102d85>] kernel_thread_helper+0x5/0x10
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000000
> >
> > The trace of send data happens before the data is actually sent, so
> it
> > would seem here that we received the Ack before we finished sending
> the
> > data!!!!!
> >
> > I searched back, and the specific block_id was recently used for a
> > request on a different device (not surprising) and the previous data
> > message on the drbd1 device had sequence number b74 as expected.
> >
> > You will also note that we hit the assert failure re ap_pending_cnt
> > when
> > processing the ack -- I think this is because w_send_dblock doesn't
> > increment ap_pending_cnt until drbd_send_dblock returns
successfully,
> > so
> > it's probably at zero at the moment the Ack is received...
> >
> > I'm still debugging but I thought it would be useful to post what
> I've
> > found in case anyone has any bright ideas...
> > /simgr
> >
> >
> > _______________________________________________
> > drbd-dev mailing list
> > drbd-dev@lists.linbit.com
> > http://lists.linbit.com/mailman/listinfo/drbd-dev
