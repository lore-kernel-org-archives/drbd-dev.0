Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Stuck in WFBitMapS state even across reboot.
Date: Thu, 30 Nov 2006 10:38:33 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C84F@EXNA.corp.stratus.com>
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
This involves Xen Vm's.  I would create one vm, I would then put an i/o
load on there (Something that keeps reading and writing).  I would then
go to the host and do an ifdown on the heartbeat interface in an attempt
to force a split brain situation. I would then do an ifup. And every now
and then this
would happen (not all the time).  When it happens, it survives a reboot.
I actually have not figured out how to get out of it.

I will try to find a more automatic way to reproduce it.

Thanks,

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Thursday, November 30, 2006 10:12 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: Stuck in WFBitMapS state even across
reboot.

Am Montag, 27. November 2006 23:28 schrieb Montrose, Ernest:
> Hi all,
> I am seeing a problem where both nodes get stuck in the WFBitMaps
state
> even across a reboot.
> Dmesg also reveals this on both nodes:
> Drbd0: [drbd0_receiver/4800] sock_sendmsg time expired, ko =3D
4294967256
> .......
> Drbd0: Split-brain detected, manuall solved. Sync from this node
> Both nodes reports this split brain message.  My configuration for
> device 0 has the following new
> Settings NET:
> rr-conflict violently;
> after-sb-1pri violently-as0p;
> after-sb-2pri violently-as0p;
>
> Thanks for any help.
>

Hi Ernest,

Could you please give us a better description, how we can reproduce this
here ?

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
