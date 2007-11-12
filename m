Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Handling on-disk caches
Date: Mon, 12 Nov 2007 10:59:24 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107074F83@EXNA.corp.stratus.com>
In-Reply-To: 200711121339.59824.philipp.reisner@linbit.com
References: <342BAC0A5467384983B586A6B0B376710707496D@EXNA.corp.stratus.com>
	200711121339.59824.philipp.reisner@linbit.com
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

>=20
> For item 3 I have an other opinion.
>=20
> On the primary we have a data structure called the "transfer log" or
tl
> in the code. Up to now this was mainly important for protocol A and B.
>=20
> It is a data structure conaining objects for all our self-generated
> drbd-barriers on the fly, and objects for all write requests between
> these barriers.
>=20
> If we loose connection in protocol A or B we need to mark everything
> we find in the transfer_log as out-of-sync in the bitmap.
>=20
> When we also do this for protocol C, _AND_ use BIO_RW_BARRIER for
> doing writing on the secondary we have solved the issue you
> described in the first part of the mail.
>=20

I like it! MUCH better than marking the GB's of data covered by the
AL...

I presume you will work on this as part of 8.2 rather than as a fix to
8.0? Since I am currently locked on 8.0, I will probably look at
implementing your suggestions as updates to 8.0 and submit them for
consideration in 8.2.

Simon
