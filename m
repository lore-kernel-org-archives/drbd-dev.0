Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8: recent regression causing corruption andcrashes
Date: Fri, 11 Aug 2006 15:11:38 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103624F87@EXNA.corp.stratus.com>
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

> / 2006-08-11 12:01:23 -0400
> \ Graham, Simon:
> > Quick update:
> >
>=20
> How exactly do you "test"?
> Kernel and hardware?
> (sorry, if you posted that earlier, just point me to it)

In this case, this happens only when I install a pair of systems from
scratch and it is doing initial synchronization of one specific DRBD
partition which is also being written to by our applications at the same
time. I did post the sequence at the end of a previous message, but it's
basically:

1. on both systems use drbdmeta to wipe the meta data with no network
connection established
2. on one system, mount the drbd disk, make a file system and untar some
stuff on to it (still with no network connection)
3. reboot both systems - when they come up, resync starts. On one
system, mount the file system (which causes reads/writes
   at the same time as the resync)

Once I'm in this state (and have had the crash which happens everytime),
I'm not able to manually resync the disks -- I suspect I don't
understand enough about this yet, but it always says there is a
split-brain and it's not able to fix it even if I set the after-sb-xpri
options.

The hardware is a pair of Dell servers, software is 2.6.16.13 with Xen
3.0.2 patches; this all worked fine until about 1 week ago when I
upgraded to the latest trunk version of drbd 8.

Simon

BTW: I have also checked carefully that I'm running the latest trunk
version (as of last night).


