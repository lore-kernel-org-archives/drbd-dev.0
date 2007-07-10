Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: An attach after a disk fault on the sync target
	causes a deadlock in WFBitMapT
Date: Tue, 10 Jul 2007 10:05:39 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47977@EXNA.corp.stratus.com>
In-Reply-To: 200707101548.16674.philipp.reisner@linbit.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
OK..Interesting..I'll have to fully understand the explanation later :)
Let me test the fix first. I'll let you know if anything bad happens. =20

Thanks!

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Tuesday, July 10, 2007 9:48 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: An attach after a disk fault on the sync
target causes a deadlock in WFBitMapT

On Monday 09 July 2007 17:25:08 Montrose, Ernest wrote:
> Hi all,
> We are seeing a problem where while syncing if the sync target
detaches
> then attempts to attach, both nodes end up in cs:WABitMapT state.
This
> happens if both nodes where in Secondary/Secondary state and the
dettach
> happened on the SyncTarget.
>

Hi Ernest,

Thanks for pointing this out.

The cause for this was that the UUIDs...

Node1:       C:0:H:H
Node2:       C:0:H:H

upon start of resync an "S" gets created.

sync target: S:0:C:H
sync source: C:S:H:H

but it should be

sync target: S:0:H:H
sync source: C:S:H:H

On the sync target side we got S left of C while on the sync=20
source side we had C left of S. This was bad. The should not
appear in different order!

C should be left of S on sync source, and nowhere on the sync
target. (=3D even further left =3D in the future )

Ok, I guess the explanation is sufficient incomprehensible ;)


Index: drbd_receiver.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drbd_receiver.c     (revision 2965)
+++ drbd_receiver.c     (revision 2966)
@@ -2474,7 +2474,9 @@
        if (drbd_recv(mdev, h->payload, h->length) !=3D h->length)
                return FALSE;

-       drbd_uuid_set(mdev,Current,be64_to_cpu(p->uuid));
+       /* Here the _drbd_uuid_ functions are right, current should
+          _not_ be rotated into the history */
+       _drbd_uuid_set(mdev,Current,be64_to_cpu(p->uuid));
        _drbd_uuid_set(mdev,Bitmap,0UL);

        drbd_start_resync(mdev,SyncTarget);

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
