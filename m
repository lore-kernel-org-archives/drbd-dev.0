Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id ED3B61056471
	for <drbd-dev@lists.linbit.com>; Mon, 31 Oct 2016 11:58:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id AB188482933
	for <drbd-dev@lists.linbit.com>; Mon, 31 Oct 2016 11:58:52 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OVKqUsKpyrh1 for <drbd-dev@lists.linbit.com>;
	Mon, 31 Oct 2016 11:58:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 89FE7482934
	for <drbd-dev@lists.linbit.com>; Mon, 31 Oct 2016 11:58:52 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HrlbSfSsdbbH for <drbd-dev@lists.linbit.com>;
	Mon, 31 Oct 2016 11:58:52 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 61E55482933
	for <drbd-dev@lists.linbit.com>; Mon, 31 Oct 2016 11:58:52 +0100 (CET)
Date: Mon, 31 Oct 2016 11:58:52 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20161031105852.GC1382@soda.linbit>
References: <36D1AB4E1AAC4541A1C88167C7231D0B01409F69FA@G08CNEXMBPEKD02.g08.fujitsu.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36D1AB4E1AAC4541A1C88167C7231D0B01409F69FA@G08CNEXMBPEKD02.g08.fujitsu.local>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] DRBD Bug Report
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

On Tue, Oct 25, 2016 at 01:23:42AM +0000, Guo, Lei wrote:
> Version=EF=BC=9A9.0.5/9.0.4
> File=EF=BC=9Adrbd_state.c
>=20
> Two nodes are setup, Node 1 is primary, node 2 is secondary.
> On node 2 , command =E2=80=9Cdrbdadm down r0=E2=80=9D returns error.
>=20
> [error] Failed to disconnected or detach the r0.
>                                                  cmd_result=3D[11], cmd=
_output=3D[r0: State change failed: (-10) State change was refused by pee=
r node
>                                                  additional info from k=
ernel:failed to disconnect
>=20
>=20
> The possible bug is as follows.
> static enum outdate_what outdate_on_disconnect(struct drbd_connection *=
connection)
> {
>         struct drbd_resource *resource =3D connection->resource;
>=20
>         if (connection->fencing_policy >=3D FP_RESOURCE &&
>             resource->role[NOW] !=3D connection->peer_role[NOW]) {
>                 if (resource->role[NOW] =3D=3D R_PRIMARY)
>                         return OUTDATE_PEER_DISKS;
>                 if (connection->peer_role[NOW] !=3D R_PRIMARY)         =
  <--------- should be =E2=80=9Cif (connection->peer_role[NOW] =3D=3D R_P=
RIMARY)=E2=80=9D

Yes.
And I thought I fixed that some weeks ago.
But apparently I did not push a test case,
and it got lost during the last merge/release cycle.
Pushed now.

Note though that this is by far not the only thing
that is broken with enabled fencing-policies on DRBD 9.

I was operating on the assumption that there had been only a few missing
missing parts regarding pacemaker (and other) integration.  Turned out I
was wrong, and DRBD 9 + fencing policies is pretty much completely
broken in the module itself still.  We are working on it.

--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=C2=AE and LINBIT=C2=AE are registered trademarks of LINBIT
