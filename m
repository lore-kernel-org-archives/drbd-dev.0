Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Panic in _drbd_send_page() again.
Date: Fri, 4 May 2007 10:37:32 -0400
Message-ID: <342BAC0A5467384983B586A6B0B376710563693E@EXNA.corp.stratus.com>
In-Reply-To: 20070504133411.GA14895@barkeeper1.linbit
References: <BD7042533C2F8943A6A4257A9E31C45439C994@EXNA.corp.stratus.com><342BAC0A5467384983B586A6B0B37671056365AC@EXNA.corp.str
	atus.com> 20070504133411.GA14895@barkeeper1.linbit
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

>=20
> all pieces of information we have about this seem to indicate that the
> xen block device code builds up its own bios, tries to be smart
> there...
>=20
> and possibly outsmarts itself.
>=20

It's of course possible and we're looking at it but it's actually a
pretty standard piece of code that builds the bio and I don't see any
trickiness in it.

I also have a theory on the cause of this -- it's another tiny timing
window I think similar to ones we fixed earlier where the ack for a
packet would be received whilst we were still processing inside
drbd_send_zc_bio -- here's my hypothesis:

1. We're in drbd_send_zc_bio, we've sent the last segment but have not
yet looped back to
   the top of the loop to __bio_for_each_segment.
2. Ack arrives for last segment - clears RQ_NET_PENDING
3. Local IO completes, clears RQ_LOCAL_PENDING and calls req_may_be_done
=3D=3D> completes bio
   because both RQ_NET_PENDING and RQ_LOCAL_PENDING are clear.

NOW we come back to the thread running drbd_send_zc_bio and the bio has
been freed... KABLOOIE!

I realize this is a very small window but, as the saying goes, where
there's a window there's a bug...

Seems to me that req_may_be_done should not complete the master bio
unless RQ_NET_SENT is set... maybe the completed_ok: case in req_mod
should test this similar to what is done in recv_acked_by_peer:...
although it seems to me that this test should actually be buried in
req_may_be_done since if this flag is not set, the request is not done!

Simon
