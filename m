Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5877C101E048
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2014 16:48:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4B88A2AF640
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2014 16:48:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id SPlbHQoLOAcV for <drbd-dev@lists.linbit.com>;
	Fri, 19 Sep 2014 16:48:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2E8912AF643
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2014 16:48:06 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RBlyjSnQCKdz for <drbd-dev@lists.linbit.com>;
	Fri, 19 Sep 2014 16:48:06 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 01B092AF640
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2014 16:48:05 +0200 (CEST)
Date: Fri, 19 Sep 2014 16:48:05 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140919144805.GS13125@soda.linbit>
References: <20140919094909.GA21578@schiffbauer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20140919094909.GA21578@schiffbauer.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] drbd 8.4.3: refcounter overflow on re-sync
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

On Fri, Sep 19, 2014 at 11:49:09AM +0200, Marc Schiffbauer wrote:
> Hi,
>=20
> about a year ago I encountered a problem with drbd: On long running
> re-syncs a refcounter overflow happens in the drbd module resulting
> in loss of network connection (and reconnect).
>=20
> I am running a linux kernel that is hardened with grsecurity and
> PaX.  It has a feature to detect such recounter overflows
> (CONFIG_PAX_REFCOUNT)
>=20
> Now I encountered that same Probleem egain with a much newer kernel.
>=20
> There may be two causes that can trigger those cases:
> 1) real bug in a part of the kernel (drbd in that case)
> 2) false positive in PAX
>=20
> The developer of PAX had a look at this issue and assumes a real bug
> in drbd but asked me to ask the drbd developer for details.
>=20
> Please see [1].
>=20
> Now today, with a newer kernel the issue looks like that:
>=20
> [63999.116870] PAX: refcount overflow detected in: drbd_r_ms03:6378, ui=
d/euid: 0/0
> [63999.116875] CPU: 0 PID: 6378 Comm: drbd_r_ms03 Not tainted 3.14.18-h=
ardened-r2 #1
> [63999.116876] Hardware name: Supermicro X9DRi-LN4+/X9DR3-LN4+/X9DRi-LN=
4+/X9DR3-LN4+, BIOS 3.0b 05/27/2014
> [63999.116878] task: ffff882f8b599010 ti: ffff882f8b599730 task.ti: fff=
f882f8b599730
> [63999.116879] RIP: 0010:[<ffffffffa00663ca>]  [<ffffffffa00663ca>] fff=
fffffa00663ca
> [63999.116882] RSP: 0000:ffffc90016483dd8  EFLAGS: 00000a02
> [63999.116883] RAX: 0000000000000000 RBX: 000000027fd7cb00 RCX: ffff883=
06c17e6a0
> [63999.116884] RDX: 0000000000000100 RSI: ffffffff818d2101 RDI: ffff882=
fb6c9d650
> [63999.116884] RBP: ffff882f9c577010 R08: ffff88306c17e6a0 R09: ffff882=
fb6e76cc0
> [63999.116885] R10: ffff882fb6e76cc0 R11: ffff882fb6e76cc0 R12: ffffc90=
016483e50
> [63999.116886] R13: ffff882fb617f228 R14: ffff882f35028200 R15: ffff882=
fb617f000
> [63999.116888] FS:  0000000000000000(0000) GS:ffff88307f200000(0000) kn=
lGS:0000000000000000
> [63999.116889] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [63999.116889] CR2: 00000320a5073008 CR3: 000000000154d000 CR4: 0000000=
0001607f0
> [63999.116890] Stack:
> [63999.116891]  ffff882f8b85d800 0000000000000018 0000000000000018 0000=
010000000018
> [63999.116893]  0000000000000000 ffff882f8b85d800 0000000000000009 0000=
0000000000d8
> [63999.116895]  0000000000000018 0000000000000018 0000000000000000 ffff=
ffffa0068134
> [63999.116896] Call Trace:
> [63999.116907]  [<ffffffffa0068134>] ? drbdd_init+0x147/0x1d7 [drbd]

If you resolve that to a code line,
I may be able to figure out what PAX is talking about.

But from this stack trace alone, I have absolutely no idea what PAX
is trying to say, which refcount could possibly be meant there,
let alone why it could possibly overflow or.

Ah, ok. Looking at [1], "PaX Team" says:
.---
| after having looked at the drbd code a bit i think this could be a
| real bug in drbd but only upstream can tell for sure so you'll have to
| contact them. you can show them the following that i figured out so far=
:
|=20
| the refcount overflow was detected in
| drivers/block/drbd/drbd_bitmap.c:bm_page_io_async at the
|=20
| atomic_add(len >> 9, &mdev->rs_sect_ev)

Well, yes, why would it not overflow.
It is *not* a refcount.
It is an atomic counter.
It is meant to overflow.

| statement. rs_sect_ev is an atomic_t in struct drbd_conf declared in
| drivers/block/drbd/drbd_int.h (i'll note here that i think the
| rs_sect_in field is simiarly affected by this problem).
|=20
| based on the code, these two fields don't look like refcounts, nor are
| they free-running counters or statistics either (the usual cases for
| false positives). instead they're some sector counts that get reset on
| certain events (the details of which i can't tell as i don't know the
| drbd code). therefore my feeling is that these counts are not supposed
| to overflow as they'd otherwise lead to incorrect calculations in
| drbd_rs_should_slow_down and drbd_rs_controller (the latter reads
| rs_sect_in into an unsigned int btw, this is mixing up signed/unsigned
| integers, that can't be good...).

But yes, it *is* a "free running counter".
For IO that has to be accounted to the resyncer.
They are reset whenever a new resync starts.

Apparently you are syncing more than 2*41 byte.
That's ok.  Others do too.
Having a lot of storage is no reason to drop the connection.

| so what happened to you is that somehow rs_sect_ev reached 2G (that
| corresponds to about 1TB of traffic between two counter resets or
| 'events') and the signed overflow detection triggered on it (if that's
| too unrealistic traffic for drbd then there was some other problem
| calculating the sector counts that resulted in some big enough value to
| trigger a signed overflow, though at the moment of the overflow 'len'
| had a value of 8 only). in any case it looks that an atomic_t is not
| enough to store real life sector counts and will have to be enlarged
| probably (or the counters will have to be reset more frequently).
`---

It is perfectly ok for rs_sect_ev to overflow, it is meant to overflow.
It is used in some signed modulo 32bit calculation only.

> [63999.116913]  [<ffffffffa006f617>] ? drbd_thread_setup+0x4e/0x117 [dr=
bd]
> [63999.116917]  [<ffffffffa006f5c9>] ? conn_destroy+0x86/0x86 [drbd]
> [63999.116922]  [<ffffffff8107fbfc>] ? kthread+0xd5/0xdd
> [63999.116924]  [<ffffffff8107fb27>] ? kthread_worker_fn+0xf9/0xf9
> [63999.116929]  [<ffffffff81535f74>] ? ret_from_fork+0x74/0xa0
> [63999.116930]  [<ffffffff8107fb27>] ? kthread_worker_fn+0xf9/0xf9
> [63999.116931] Code: 48 89 de 4c 89 ff e8 c3 80 00 00 85 c0 0f 85 b2 00=
 00 00 8b 54 24 1c f0 41 01 97 d0 04 00 00 71 0a f0 41 29 97 d0 04 00 00 =
cd 04 <bb> 03 00 00 00 f0 41 ff 87 24 02 00 00 71 0a f0 41 ff 8f 24 02
>=20
>=20
> and drbd itself says:
>=20
> [63999.116965] block drbd0: drbd_alloc_pages interrupted!

Um, I'd guess it does say some things before that, too.
Also, the other node will likely have something to say.

Can you give some more context?

Interrupted by whom?
Is PAX delivering some signal?
Which?
Why would it do that?
If so, stop it :-)

> [63999.116968] d-con ms03: error receiving RSDataRequest, e: -12 l: 0!
> [63999.116986] d-con ms03: peer( Secondary -> Unknown ) conn( SyncSourc=
e -> ProtocolError )
> [63999.117021] d-con ms03: asender terminated
> [63999.117025] d-con ms03: Terminating drbd_a_ms03
> [63999.130575] d-con ms03: Connection closed
> [63999.130599] d-con ms03: conn( ProtocolError -> Unconnected )
> [63999.130601] d-con ms03: receiver terminated
> [63999.130602] d-con ms03: Restarting receiver thread
> [63999.130603] d-con ms03: receiver (re)started
> [63999.130614] d-con ms03: conn( Unconnected -> WFConnection )
> [64000.116691] d-con ms03: initial packet S crossed
> [64009.195530] d-con ms03: Handshake successful: Agreed network protoco=
l version 101
> [64009.195807] d-con ms03: Peer authenticated using 64 bytes HMAC
> [64009.195834] d-con ms03: conn( WFConnection -> WFReportParams )
> [64009.195843] d-con ms03: Starting asender thread (from drbd_r_ms03 [6=
378])
> [ ... and continues to sync ... ]
>=20
>=20
> Is this a real bug in drbd?
>=20
> Thanks
> -Marc
>=20
>=20
>=20
> [1] https://forums.grsecurity.net/viewtopic.php?f=3D3&t=3D3786&p=3D1355=
8&hilit=3DREFCOUNT#p13558
> --=20

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
