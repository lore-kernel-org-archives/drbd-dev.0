Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 68229101AC71
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:54:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 5A392392A26
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:54:40 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fSND9Xom-t_j for <drbd-dev@lists.linbit.com>;
	Thu,  3 Jul 2014 15:54:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3D079392C38
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:54:40 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jIM4L8HHSwIT for <drbd-dev@lists.linbit.com>;
	Thu,  3 Jul 2014 15:54:40 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 23E5E392A26
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:54:40 +0200 (CEST)
Date: Thu, 3 Jul 2014 15:54:40 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140703135439.GJ11700@soda.linbit>
References: <201407031507.18336.mmazur@kernel.pl>
	<20140703134417.GI11700@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20140703134417.GI11700@soda.linbit>
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

On Thu, Jul 03, 2014 at 03:44:17PM +0200, Lars Ellenberg wrote:
> On Thu, Jul 03, 2014 at 03:07:18PM +0200, Mariusz Mazur wrote:
> > My setup is two nodes with drbd double master, corosync, pacemaker, c=
lvmd, xen=20
> > 4.4.0.
> >=20
> > Here's what happens when I reboot -f one of the nodes and the survivi=
ng node=20
> > is kernel 3.12.23 or earlier (oldest tested was 3.6.something):
>=20
> Yep, someone changed the in kernel kthread api
> to use wait_for_completion_killable()
> where it used to be wait_for_completion().
>=20
> Which has some bad interactions with how DRBD handles things.
> This is being fixed.

Would you please try this patch:

diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
index 9e6adaa..88f480c 100644
--- a/drbd/drbd_nl.c
+++ b/drbd/drbd_nl.c
@@ -586,6 +586,7 @@ void conn_try_outdate_peer_async(struct drbd_connecti=
on *connection)
 	struct task_struct *opa;
=20
 	kref_get(&connection->kref);
+	flush_pending_signals();
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
