Return-Path: <nwang@suse.com>
Received: from prv-mh.provo.novell.com (prv-mh.provo.novell.com
	[137.65.248.74])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E23DC1057FE2
	for <drbd-dev@lists.linbit.com>; Fri, 11 Aug 2017 10:08:16 +0200 (CEST)
Message-Id: <598DD66A02000070000C76C2@prv-mh.provo.novell.com>
Date: Fri, 11 Aug 2017 02:08:10 -0600
From: "Nick Wang" <nwang@suse.com>
To: "Roland Kammerer" <roland.kammerer@linbit.com>
References: <20170811042610.3956-1-nwang@suse.com>
	<20170811074557.GD15992@rck.sh>
In-Reply-To: <20170811074557.GD15992@rck.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Cc: Jim Fehlig <JFEHLIG@suse.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block-drbd: Fix block-drbd remove command
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

>>> On 2017-8-11 at 15:45, in message <20170811074557.GD15992@rck.sh>, =
Roland
Kammerer <roland.kammerer@linbit.com> wrote:
> On Fri, Aug 11, 2017 at 12:26:10PM +0800, Nick Wang wrote:
> > Similar to a previous fix for the add command, strip any 'drbd:'
> > prefix from the resource identifier read from xenstore. Otherwise
> > the remove command can fail, leaving the resource in Primary role.
> > This presents a data hazard if a VM is migrated to another host,
> > where the resource will also be placed in Primary role.
> >=20
> > Signed-off-by: Jim Fehlig <jfehlig@suse.com>
> > Signed-off-by: Nick Wang <nwang@suse.com>
> > CC: Lars Ellenberg <lars.ellenberg@linbit.com>
> > CC: Roland Kammerer <roland.kammerer@linbit.com>
> > CC: drbd-dev@lists.linbit.com=20
> >=20
> > ---
> >  scripts/block-drbd | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/scripts/block-drbd b/scripts/block-drbd
> > index 11ec057f..23364cd6 100755
> > --- a/scripts/block-drbd
> > +++ b/scripts/block-drbd
> > @@ -284,7 +284,7 @@ case "$command" in
> >      case $t in=20
> >        drbd|phy)
> >          p=3D$(xenstore_read "$XENBUS_PATH/params")
> > -        drbd_resource=3D$p
> > +        drbd_resource=3D${p#drbd:}
> >          drbd_role=3D"$(drbdadm role $drbd_resource)"
> >          drbd_lrole=3D"${drbd_role%%/*}"
> >          drbd_dev=3D"$(drbdadm sh-dev $drbd_resource)"
>=20
> I squashed that with your previous one.

Sorry for the miss in the previous patch and thanks for the help.

Best regards,
Nick

