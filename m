Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 74B1A1011BA2
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 14:00:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6268B3F1956
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 14:00:51 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id vrpT__PmAChk for <drbd-dev@lists.linbit.com>;
	Wed, 30 Mar 2016 14:00:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 45E9B3F1DAB
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 14:00:51 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SrhdKk0Bxhuj for <drbd-dev@lists.linbit.com>;
	Wed, 30 Mar 2016 14:00:51 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 1ED2F3F1956
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 14:00:51 +0200 (CEST)
Date: Wed, 30 Mar 2016 14:00:50 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160330120050.GO15579@soda.linbit>
References: <alpine.LRH.2.11.1603300137590.2225@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.11.1603300137590.2225@mail.ewheeler.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] NULL pointer derefernce in 8.4.7-1
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Mar 30, 2016 at 02:19:07AM +0000, Eric Wheeler wrote:
> Hello all,
>=20
> We are getting kernel crashes in linux 4.1.20 with the drbd-8.4.git tre=
e=20
> at commit 3a6a769340ef93b1ba2792c6461250790795db49 . =20
>=20
> I don't see anything in the newer commits that addresses this issue so=20
> I'm posting---but I'll try the latest commit in master, too, just in ca=
se.
>=20
> Please see the backtrace below.  I also included our global_common.conf=
=20
> further down.  This is protocol A and the link is quite slow.  This NUL=
L=20
> ptr dereference appears to show up when the drbd kernel thread is block=
ed=20
> for a long time.  It might happen at reconnect time because the BUG did=
n't=20
> show up until 13 seconds after the P_BARRIER error.
>=20
> The problem is pretty reproducable, so I can probably test patches. =20
> Please let me know what I can do to help test.

DRBD logs of both peers leading up to the incident may be useful.

check if older kernel versions are ok?
as in 2.6.32, 3.10, ...
if older seems to be ok, figure out which version breaks.

maybe check if older DRBD is still ok (maybe this is a more recent regres=
sion?)

try to resolve addresses to source code lines.

> [ 2480.751713]  [<ffffffffa06b0f26>] drbd_send+0xe6/0x200 [drbd]
> [ 2480.753608]  [<ffffffffa06b2b81>] _drbd_no_send_page.isra.40+0x71/0x=
b0 [drbd]
> [ 2480.755463]  [<ffffffffa06b3178>] drbd_send_dblock+0x3e8/0x7a0 [drbd=
]
> [ 2480.757263]  [<ffffffffa06a5874>] ? complete_master_bio+0x94/0x170 [=
drbd]
> [ 2480.759073]  [<ffffffffa06935cf>] w_send_dblock+0xaf/0x1e0 [drbd]
> [ 2480.760844]  [<ffffffffa06949a9>] drbd_worker+0xf9/0x3a0 [drbd]
> [ 2480.762567]  [<ffffffffa06aed00>] ? drbd_destroy_connection+0x190/0x=
190 [drbd]
> [ 2480.764181]  [<ffffffffa06aed1d>] drbd_thread_setup+0x1d/0x110 [drbd=
]
> [ 2480.765777]  [<ffffffffa06aed00>] ? drbd_destroy_connection+0x190/0x=
190 [drbd]
> [ 2480.767337]  [<ffffffff810c0b08>] kthread+0xd8/0xf0
> [ 2480.768873]  [<ffffffff810c0a30>] ? kthread_create_on_node+0x1b0/0x1=
b0
> [ 2480.770409]  [<ffffffff816e94e2>] ret_from_fork+0x42/0x70
> [ 2480.771868]  [<ffffffff810c0a30>] ? kthread_create_on_node+0x1b0/0x1=
b0
>=20
>=20
> =3D=3D=3D> /etc/drbd.d/global_common.conf <=3D=3D=3D
> common {
> 	startup {
> 		wfc-timeout 30;
> 		outdated-wfc-timeout 20;
> 		degr-wfc-timeout 30;
> 	}
> 	options {
> 		on-no-data-accessible suspend-io;
> 	}
> 	syncer {
> 		rate 500M;
> 	}
> 	disk {
> 		al-extents 3389;
> 		c-fill-target 10240;
> 		c-delay-target 100;
> 		c-plan-ahead 70;
> 		c-min-rate 1024;
> 		c-max-rate 400M;
> 		on-io-error pass_on;
> 		read-balancing when-congested-remote;
> 	}
> 	net {
> 		after-sb-0pri discard-zero-changes;
> 		after-sb-1pri call-pri-lost-after-sb;
> 		after-sb-2pri disconnect;
> 		allow-two-primaries no;
> 		protocol A;
> 		cram-hmac-alg sha1;
> 		verify-alg crc32c;
> 		csums-alg crc32c;
> 		max-buffers 8192;
> 		max-epoch-size 8192;
> 		tcp-cork yes;
> 		sndbuf-size 1M;
> 		rcvbuf-size 2M;
> 		unplug-watermark 128;=20
> 		ko-count 3;
> 		timeout 90;
> 	=09
> 		ping-int 10;
> 		ping-timeout 30;
> 	}
> }

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
