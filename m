Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Stuck in WFBitMapS state even across reboot.
Date: Thu, 30 Nov 2006 15:12:13 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C850@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Lars Ellenberg" <Lars.Ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars,
Interesting...Actually I am currently investigating a situation where
from an initial creation state, two out of my 4 devices will sync the
other two
Will get stuck in Inconsistent/Inconsistent Dstate and would never sync,
of course.
Your analysis might hold for that case too.  Only happens when my net =20
configuration is:
rr-conflict violently;
after-sb-0pri discard-zero-changes
after-sb-1pri violently-as0p
after-sb-2pri violently-as0p

This situation is automatic after we first install and enabling of drbd
anew.
The configuration above works great if you install without them, sync
and
Then add them later and reboot.

EM--
-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Lars Ellenberg
Sent: Thursday, November 30, 2006 3:00 PM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] DRBD8: Stuck in WFBitMapS state even across
reboot.

/ 2006-11-30 10:38:33 -0500
\ Montrose, Ernest:
> Phil,
> This involves Xen Vm's.  I would create one vm, I would then put an
i/o
> load on there (Something that keeps reading and writing).  I would
then
> go to the host and do an ifdown on the heartbeat interface in an
attempt
> to force a split brain situation. I would then do an ifup. And every
now
> and then this
> would happen (not all the time).  When it happens, it survives a
reboot.
> I actually have not figured out how to get out of it.
>=20
> I will try to find a more automatic way to reproduce it.

drbd_receiver.c, drbd_asb_recover_0p

| 	ch_peer =3D mdev->p_uuid[UUID_SIZE];
|       ch_self =3D drbd_bm_total_weight(mdev); ### <=3D=3D

this ch_self may be different
from the one we communicated before, right?

|       switch ( mdev->net_conf->after_sb_0p ) {
|       ...
|
|       case DiscardZeroChg:

so, if we communicated ch_self =3D=3D 0, but now ch_self is > 0,
and ch_peer is 0 (inactive peer sees this reversed), then

|                if( ch_peer =3D=3D 0 && ch_self =3D=3D 0) {

inactive peer does this, and may decide he is the source;

|                        rv=3Dtest_bit(DISCARD_CONCURRENT,&mdev->flags) =
?
-1 : 1;
|                        break;
|                } else {

active peer does this branch,
and decides he is the source.

|                        if ( ch_peer =3D=3D 0 ) { rv =3D  1; break; }
|                        if ( ch_self =3D=3D 0 ) { rv =3D -1; break; }
|                }
|                if( mdev->net_conf->after_sb_0p =3D=3D DiscardZeroChg )
break;

doh. have to think about that...

--=20
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
