Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 579DB1056445
	for <drbd-dev@lists.linbit.com>; Thu, 18 Aug 2016 13:51:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 46FDF40035C
	for <drbd-dev@lists.linbit.com>; Thu, 18 Aug 2016 13:51:35 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7ZHnPbRhI1m7 for <drbd-dev@lists.linbit.com>;
	Thu, 18 Aug 2016 13:51:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 21C64402AE9
	for <drbd-dev@lists.linbit.com>; Thu, 18 Aug 2016 13:51:35 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gqG1MvzoBT9c for <drbd-dev@lists.linbit.com>;
	Thu, 18 Aug 2016 13:51:35 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 4680B40035C
	for <drbd-dev@lists.linbit.com>; Thu, 18 Aug 2016 13:51:34 +0200 (CEST)
Date: Thu, 18 Aug 2016 13:51:34 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160818115134.GK5268@soda.linbit>
References: <CALLFrTT9N7bbikXJCaL6NGbMvM49D2Bguy0eyRydNB1_7Sk23w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALLFrTT9N7bbikXJCaL6NGbMvM49D2Bguy0eyRydNB1_7Sk23w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] Here's logs 3 volumes case
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

On Tue, Aug 16, 2016 at 10:14:07AM +0900, =EB=B0=95=EA=B2=BD=EB=AF=BC wro=
te:
> There're 3 node, and each had 100MB/100MB/95MB  volume, time synced
> Please ,Watch DRBD9_3 node's log carefully

> <DRBD9_1>
>=20
> ...
> Aug 16 09:32:30 DRBD9_1 kernel: drbd r0/0 drbd1: current_size: 204800

...

> Aug 16 09:32:56 DRBD9_1 kernel: drbd r0/0 drbd1: size =3D 95 MB (97280 =
KB)

> Aug 16 09:33:12 DRBD9_1 kernel: drbd r0/0 drbd1: disk( Inconsistent -> =
UpToDate )

> Aug 16 09:33:26 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: pdsk( UpToDate=
 -> DUnknown ) repl( Established -> Off )

...

> Aug 16 09:33:39 DRBD9_1 kernel: drbd r0 DRBD9_2: conn( Connecting -> Co=
nnected ) peer( Unknown -> Secondary )
> Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: current_size: 194560
> Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: c_size: 194560=
 u_size: 0 d_size: 204800 max_size: 204800
> Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: la_size: 19456=
0 my_usize: 0 my_max_size: 204800
> Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: my node_id: 0
> Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_2: node_id: 1 idx=
: 0 bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
> Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx=
: 1 bm-uuid: 0x0 flags: 0x10 max_size: 194560 (DUnknown)
> Aug 16 09:33:39 DRBD9_1 kernel: drbd r0/0 drbd1: Resize forced while no=
t fully connected!

Still knows that DRBD9_3 cannot support it,
but knowingly ignores it.
"Too bad".

> <DRBD9_2>
> ...
> Aug 16 09:32:27 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 204800

> Aug 16 09:32:56 DRBD9_2 kernel: drbd r0/0 drbd1: size =3D 95 MB (97280 =
KB)
> Aug 16 09:33:38 DRBD9_2 kernel: drbd r0/0 drbd1: size =3D 95 MB (97280 =
KB)

> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0 DRBD9_1: conn( Connecting -> Co=
nnected ) peer( Unknown -> Secondary )
> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: current_size: 194560
> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: c_size: 194560=
 u_size: 0 d_size: 204800 max_size: 204800
> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: la_size: 19456=
0 my_usize: 0 my_max_size: 204800

> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: calling drbd_d=
etermine_dev_size()
> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_1: node_id: 0 idx=
: 0 bm-uuid: 0x0 flags: 0x10 max_size: 204800 (DUnknown)
> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: my node_id: 1
> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1 DRBD9_3: node_id: 2 idx=
: 1 bm-uuid: 0x0 flags: 0x10 max_size: 0 (DUnknown)
> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: Resize forced while no=
t fully connected!
> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: drbd_bm_resize called =
with capacity =3D=3D 204800
> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D=
25600 words=3D800 pages=3D2
> Aug 16 09:33:39 DRBD9_2 kernel: drbd r0/0 drbd1: size =3D 100 MB (10240=
0 KB)

Does not know exactly anymore what DRBD9_3 can support,
but still knows that the last agreed size was 95, and that _3 is
currently not reachable. Still knowingly ignores it.

"Too bad".

Thanks for the logs.

As I said, the (re)size handshake is something we actively work on, but
have not come to a "nice" solution yet.

The code lines you pointed out earlier have already been changed
internally again (I think that'S not yet publically visible,
because we don't know yet if we keep it that way, or evenchange the wire
protocol for this).

In the code that you currently have,
it is entirely possible that what was meant
is the negated logic:
   add the flag only if it is NOT the handshake.

You should be able to work around it for now
by explicitly specifying the target size in the config file
(or by patching the line you indicated already).

The real fix for all "possible" cases of (re)size exchanges
turns out to be much more complicated than we would like it to be.

    Lars

