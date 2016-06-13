Return-Path: <nwang@suse.com>
Received: from prv-mh.provo.novell.com (prv-mh.provo.novell.com
	[137.65.248.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 66DBE1056447
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jun 2016 11:58:28 +0200 (CEST)
Message-Id: <575EF34A0200007000091BC1@prv-mh.provo.novell.com>
Date: Mon, 13 Jun 2016 03:54:18 -0600
From: "Nick Wang" <nwang@suse.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>
References: <1465483189-22696-4-git-send-email-nwang@suse.com>
	<1465483189-22696-3-git-send-email-nwang@suse.com>
	<1465483189-22696-2-git-send-email-nwang@suse.com>
	<1465483189-22696-1-git-send-email-nwang@suse.com>
	<20160613091906.GI3235@soda.linbit>
In-Reply-To: <20160613091906.GI3235@soda.linbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Cc: Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH-drbd9] compat patches
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

Hi Lars,

Thanks for your review:)

>>> On 2016-6-13 at 17:19, in message <20160613091906.GI3235@soda.linbit>, =
Lars
Ellenberg <lars.ellenberg@linbit.com> wrote:
> On Thu, Jun 09, 2016 at 10:39:46PM +0800, Nick Wang wrote:
> > [PATCH-drbd9] compat: i_mutex is replaced by i_rwsem
>=20
> trivial, taken as is, though we need some backwards compat
> for some older kernels (anyways), due to
>    avoid error: 'inode_lock' redeclared as different kind of symbol
>
I thought have_inode_lock.c have already considering the old kernels, and =
inode_lock have already used in DRBD9.

> > [PATCH-drbd9] compat: blk_queue_flush() is replaced
> > [PATCH-drbd9] compat: nla_put_u64() is removed
> > [PATCH-drbd9] compat: align nla_put_u64
>=20
> All solved in a slightly different way.
I learnt a lot from your code and can keep learning :)

> Still thank you for using v9 on "bleeding upstream" kernels :-)
lol, sorry for the early try. Just thought it need to compatible sooner or =
later, hoping my work can do little help in any cases.

Best regards,
Nick

