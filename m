Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C4A181056446
	for <drbd-dev@lists.linbit.com>; Tue, 27 Dec 2016 16:54:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7C08A463429
	for <drbd-dev@lists.linbit.com>; Tue, 27 Dec 2016 16:54:05 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 93Y8_AXLUXeY for <drbd-dev@lists.linbit.com>;
	Tue, 27 Dec 2016 16:54:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5BCBE46343C
	for <drbd-dev@lists.linbit.com>; Tue, 27 Dec 2016 16:54:05 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g9-7WkzgstTA for <drbd-dev@lists.linbit.com>;
	Tue, 27 Dec 2016 16:54:05 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 0C8E7463424
	for <drbd-dev@lists.linbit.com>; Tue, 27 Dec 2016 16:54:04 +0100 (CET)
Date: Tue, 27 Dec 2016 16:54:04 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20161227155404.GQ4138@soda.linbit>
References: <CAAiCvkj-Z=vcp7MpOCRZwhrv_CLd2EmyvM=z=-6n54Ks1at8KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAAiCvkj-Z=vcp7MpOCRZwhrv_CLd2EmyvM=z=-6n54Ks1at8KQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] NULL pointer derefernce in 8.4.7-1 during
 drbd_destroy_connection()
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

On Sun, Dec 25, 2016 at 11:58:32PM +0800, Feng Sun wrote:
> On Wed, 30 Mar 2016, Lars Ellenberg wrote:
>=20
> >* On Wed, Mar 30, 2016 at 02:19:07AM +0000, Eric Wheeler wrote:
> *>* > Hello all,
> *>* >
> *>* > We are getting kernel crashes in linux 4.1.20 with the drbd-8.4.g=
it tree
> *>* > at commit 3a6a769340ef93b1ba2792c6461250790795db49 .
> *>* >
> *>* > I don't see anything in the newer commits that addresses this iss=
ue so
> *>* > I'm posting---but I'll try the latest commit in master, too, just=
 in case.
> *>* >
> *>* > Please see the backtrace below.  I also included our global_commo=
n.conf
> *>* > further down.  This is protocol A and the link is quite slow.  Th=
is NULL
> *>* > ptr dereference appears to show up when the drbd kernel thread is=
 blocked
> *>* > for a long time.  It might happen at reconnect time because the
> BUG didn't
> *>* > show up until 13 seconds after the P_BARRIER error.
> *>* >
> *>* > The problem is pretty reproducable, so I can probably test patche=
s.
> *>* > Please let me know what I can do to help test.
> *> >* DRBD logs of both peers leading up to the incident may be useful.=
*
>=20
>=20
> *I have met same issue with 8.4.9, but I cannot reproduce this easily.c=
an

You likely want to apply this:
http://git.linbit.com/drbd-8.4.git/commitdiff/e0645836e870346cafe688cbdd8=
ec29092f6cdb5

> you help to share about the reproduce steps? *

Provoke:
you need a kernel >=3D 4.0,
you need to to hit congestion, but have "ko-count" set "high enough",
and DRBD pings on our meta socket need to still "feel" responsive
(ping-timeout is high enough).

It helps if DRBD does not use sendpage, which means you use protocol A,
or have "data-integrity-alg" enabled,
or have explicitly disabled sendpage (drbd module parameter)
or have some file system or other user that keeps submitting slab pages
or other pages with a reference count of zero.

Thanks,

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
