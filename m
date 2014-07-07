Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A040D101AC78
	for <drbd-dev@lists.linbit.com>; Mon,  7 Jul 2014 11:03:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 96B8F2A15D4
	for <drbd-dev@lists.linbit.com>; Mon,  7 Jul 2014 11:03:07 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 4U4o8T9Okp69 for <drbd-dev@lists.linbit.com>;
	Mon,  7 Jul 2014 11:03:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 7AE1C2A6EA6
	for <drbd-dev@lists.linbit.com>; Mon,  7 Jul 2014 11:03:07 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PWyaqPjEkDFg for <drbd-dev@lists.linbit.com>;
	Mon,  7 Jul 2014 11:03:07 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 618422A15D4
	for <drbd-dev@lists.linbit.com>; Mon,  7 Jul 2014 11:03:07 +0200 (CEST)
Date: Mon, 7 Jul 2014 11:03:07 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140707090307.GC1229@soda.linbit>
References: <201407031507.18336.mmazur@kernel.pl>
	<201407031949.10263.mmazur@kernel.pl>
	<20140704114257.GK11700@soda.linbit>
	<201407071041.33545.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <201407071041.33545.mmazur@kernel.pl>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] stonith-related regression introduced around kernel
 3.13, with 3.15.3 still affected
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

On Mon, Jul 07, 2014 at 10:41:33AM +0200, Mariusz Mazur wrote:
> On Fri of July 4 2014, Lars Ellenberg wrote:
>=20
> > Yeah, sorry, typo, leave off the pending-.
> >=20
> > It's flush_signals(current);
> >=20
> > diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
> > index 9e6adaa..d8b83d7 100644
> > --- a/drbd/drbd_nl.c
> > +++ b/drbd/drbd_nl.c
> > @@ -586,6 +586,7 @@ void conn_try_outdate_peer_async(struct drbd_conn=
ection
> > *connection) struct task_struct *opa;
> >=20
> >  	kref_get(&connection->kref);
> > +	flush_signals(current);
> >  	opa =3D kthread_run(_try_outdate_peer_async, connection, "drbd_asyn=
c_h");
> >  	if (IS_ERR(opa)) {
> >  		drbd_err(connection, "out of mem, failed to invoke fence-peer
> > helper\n");
>=20
> Yup, this worked. Should it maybe get sent upstream to the kernel? :)

Yes Sir Captain Obvious Sir.

 ;-)

Thanks for confirming, anyways.

	Lars

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
