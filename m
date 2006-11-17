Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Split-brain false positive on
	Primary/primarypotential patch
Date: Fri, 17 Nov 2006 09:28:50 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767104034A6B@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <Lars.Ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> I agree here.
> But see below why I still think Philipp is "right", too :)
>=20
>   But I think the provided patch (doing it only in al_begin_io) is
> wrong.
>   actually it needs to be done as soon as the bitmap is touched,
>   so it needs be done in "set_out_of_sync", which may be called in the
>   cleanup code after connection loss, too, and will be, typically, on
> the
>   actually active node.
>=20

Yes, you are, of course, quite right -- any modification should result
in the UUID update and not just updates by the file system above DRBD.

> one alternative would be to update the uuids where it is done now,
>   but only if we have been opened RW (we have that information anyways
>   somewhere), and do it again (unless already done) as soon as we are
>   opened rw. that would be correct, I think, and easy.

I agree - that's actually a much better solution that is more in line
with Phil's desire to protect against mounting a 1-node fs on both
nodes; this decouples primaryness from the reality of which nodes are
_actually_ using the volume.

We can rework the patch to do it this way if this is acceptable.

>=20
> Why we could leave the code as is, anyways:
>=20
>   we can leave it like it is right now, because the "after split brain
>   recovery" strategy "discard least changes" would do the same thing:
>   your assumtion was that the "inactive" node does no changes.
>   zero is less than anything else...
>=20

Yes - if this is actually possible in a 2p case then it would work - I
see that the current behavior of this setting is based on bit-0 of the
current UUID which is set based on primaryness; since in a 2p case both
will have the bit set I don't think this works. I'm not sure how you
would track updates to be able to calculate 'least changes'...

Simon
