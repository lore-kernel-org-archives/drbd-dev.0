Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 544C5101AC77
	for <drbd-dev@lists.linbit.com>; Fri,  4 Jul 2014 13:42:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 45C94391161
	for <drbd-dev@lists.linbit.com>; Fri,  4 Jul 2014 13:42:58 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0IN5lYl9YaWv for <drbd-dev@lists.linbit.com>;
	Fri,  4 Jul 2014 13:42:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 0A040391180
	for <drbd-dev@lists.linbit.com>; Fri,  4 Jul 2014 13:42:58 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hvht4W0Frbf0 for <drbd-dev@lists.linbit.com>;
	Fri,  4 Jul 2014 13:42:57 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E5C0C391161
	for <drbd-dev@lists.linbit.com>; Fri,  4 Jul 2014 13:42:57 +0200 (CEST)
Date: Fri, 4 Jul 2014 13:42:57 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140704114257.GK11700@soda.linbit>
References: <201407031507.18336.mmazur@kernel.pl>
	<20140703134417.GI11700@soda.linbit>
	<20140703135439.GJ11700@soda.linbit>
	<201407031949.10263.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <201407031949.10263.mmazur@kernel.pl>
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

On Thu, Jul 03, 2014 at 07:49:09PM +0200, Mariusz Mazur wrote:
> On Thu of July 3 2014, Lars Ellenberg wrote:
>=20
> > Would you please try this patch:
> >=20
> > diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
> > index 9e6adaa..88f480c 100644
> > --- a/drbd/drbd_nl.c
> > +++ b/drbd/drbd_nl.c
> > @@ -586,6 +586,7 @@ void conn_try_outdate_peer_async(struct drbd_conn=
ection
> > *connection) struct task_struct *opa;
> >=20
> >  	kref_get(&connection->kref);
> > +	flush_pending_signals();
> >  	opa =3D kthread_run(_try_outdate_peer_async, connection, "drbd_asyn=
c_h");
> >  	if (IS_ERR(opa)) {
> >  		drbd_err(connection, "out of mem, failed to invoke fence-peer
> > helper\n");
>=20
> There's no such function in the kernel.

Yeah, sorry, typo, leave off the pending-.

It's flush_signals(current);

diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index 9e6adaa..d8b83d7 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -586,6 +586,7 @@ void conn_try_outdate_peer_async(struct drbd_connecti=
on *connection)
 	struct task_struct *opa;
=20
 	kref_get(&connection->kref);
+	flush_signals(current);
 	opa =3D kthread_run(_try_outdate_peer_async, connection, "drbd_async_h"=
);
 	if (IS_ERR(opa)) {
 		drbd_err(connection, "out of mem, failed to invoke fence-peer helper\n=
");

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
