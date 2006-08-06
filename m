Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 trunk crashes if NegDReply received in reply
	toRSDataRequest
Date: Sun, 6 Aug 2006 12:18:13 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103471180@EXNA.corp.stratus.com>
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

Oh wait... that wont work -- the call to send the negative ack takes the
epoch_entry* as a parameter...

How about having a new routine that can send a negative ack based on a
Data packet pointer? I don't like the idea of making drbd_aloc_ee able
to handle this case as you will get a partially initialized epoch_entry*
back in that case...

/simgr

> -----Original Message-----
> From: Graham, Simon
> Sent: Sunday, August 06, 2006 12:14 PM
> To: Graham, Simon; drbd-dev@linbit.com
> Subject: RE: [Drbd-dev] DRBD-8 trunk crashes if NegDReply received in
> reply toRSDataRequest
>=20
> And another one -- receive_DataRequest calls drbd_alloc_ee _before_
> testing if it has a local disk; this craps out in bio_add_page because
> bi_bdev is NULL (I think -- it's a bit hard to read the optimized
> disassembly) -- certainly, when we go diskless because of an error,
> after_state_ch frees the drbd_backing_dev and sets the bc pointer in
> mdev to NULL -- a data request received after that will call
> drbd_alloc_ee which will do the wrong thing.
>=20
> I think the fix is to move the test for having good data to before the
> call to drbd_alloc_ee; does that seem reasonable?
>=20
> /simgr
>=20
>=20
> > -----Original Message-----
> > From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-
> bounces@linbit.com]
> > On Behalf Of Graham, Simon
> > Sent: Saturday, August 05, 2006 10:29 PM
> > To: drbd-dev@linbit.com
> > Subject: [Drbd-dev] DRBD-8 trunk crashes if NegDReply received in
> reply
> > toRSDataRequest
> >
> > When an RSDataRequest is sent, the block_id field in the request is
> set
> > to SYNCER_ID (-1) - if the receiver is unable to process the request
> > (e.g. if the receiver doesn't have good data) then it sends back a
> > NegDReply with the same block_id - on the origin side, got_NegDReply
> > attempts to validate the block_id value using drbd_pr_verify which
> > promptly crashes attempting to reference the master_bio field to get
> > the
> > sector (drbd_req_get_sector()).
> >
> > I found this testing my fixes for removing panic() calls on meta
data
> > read/write failures but I thought it was worth bugging separately;
> > clearly this routine needs to validate the request pointer before
> > attempting to access it at all, but also we should have got a
> > NedRSDreply in this case - so there are at least two bugs here:
> >
> > 1. The target side should have send a NegRSDreply in this case;
> > receive_DataRequest should switch on h->command
> >    to decide what response to send when it bails early
> > 2. drbd_pr_verify should NOT call drbd_req_get_sector() before
> > validating the pointer - is there any reason why
> >    it shouldn't use the sector value passed in as a parameter?
> >
> > I can make patches for these when we agree on the right solution...
> >
> > Simon
> >
> > _______________________________________________
> > drbd-dev mailing list
> > drbd-dev@lists.linbit.com
> > http://lists.linbit.com/mailman/listinfo/drbd-dev
