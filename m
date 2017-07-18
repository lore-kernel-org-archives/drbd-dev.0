Return-Path: <nwang@suse.com>
Received: from prv-mh.provo.novell.com (prv-mh.provo.novell.com
	[137.65.248.74])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A37DB1057FE2
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 11:35:17 +0200 (CEST)
Message-Id: <596E46CD02000070000C4BBC@prv-mh.provo.novell.com>
Date: Tue, 18 Jul 2017 03:35:09 -0600
From: "Nick Wang" <nwang@suse.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
References: <20170718031615.18985-1-nwang@suse.com>
	<20170718082217.GD4122@soda.linbit>
In-Reply-To: <20170718082217.GD4122@soda.linbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Drbd-dev] [PATCH] drbdadm: Fix handler called from kernel
 always invalid for stacking resource
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

>>> On 2017-7-18 at 16:22, in message <20170718082217.GD4122@soda.linbit>, =
Lars
Ellenberg <lars.ellenberg@linbit.com> wrote:
> On Tue, Jul 18, 2017 at 11:16:15AM +0800, Nick Wang wrote:
> >Handler like "before-resync-target" called from kernel
> >space does not have "-S" option for stacking resource, it
> >always return as invalid usage for stacking resource in
> >normal mode, then the connection will be dropped. Add "-S"
> >option for stacking resource automatically if the handler
> >is called from kernel.
>=20
> I think the intention was to no longer have stacked with 9,
> stacked was a kludge anyways, because that was the only way
> to add additional nodes with a two-node only replication.
>=20
Agree, it is more useful and effective in 8 stage:) Stack still can be=20
used in some simple migration without changing any configuration,
for sure the meta data must be converted/replaced to 9 format.
But for two clusters (2 nodes per site) in long distance(cities), only=20
need to replicate the same data once to the DR, which is more=20
efficiency configure in a plain multiple nodes when the bandwidth=20
hit the bottleneck.

And stack is worked with 9. It should not fail/drop connection due to=20
an internal call for snapshot of resync target from kernel space.

> That we did not patch it out was probably just being lazy.

:)

Best regards,
Nick

