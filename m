Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8: handling of concurrent writes with two
	primaries
Date: Wed, 16 Aug 2006 16:54:03 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103625529@EXNA.corp.stratus.com>
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

OK, so I was slightly wrong here:

> 2. If the UNIQE flag is set, then I don't see how the partner node
will
> make any progress - you never send an Ack and do not disconnect - if
> the
> partner also sees the conflict then he will do the Discard msg
> processing, but I don't think this is guaranteed - I'm probably
missing
> something, but if the partner gets the request and _then_ issues a
> write
> to the same location, I don't think it will do the right thing... the
> partner will simply discard and you are left hanging...
>=20

Since I've found the code that checks for collision on the write side
and adds the info to the list. I still think the other issue applies
(Ack and Data can be re-ordered which means there are cases where you
wont wait for the outstanding req to complete when you really should)...

Simon
