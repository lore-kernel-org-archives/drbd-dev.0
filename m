Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2A5161056448
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jun 2016 11:19:08 +0200 (CEST)
Date: Mon, 13 Jun 2016 11:19:07 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Nick Wang <nwang@suse.com>
Message-ID: <20160613091906.GI3235@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1465483189-22696-4-git-send-email-nwang@suse.com>
	<1465483189-22696-3-git-send-email-nwang@suse.com>
	<1465483189-22696-2-git-send-email-nwang@suse.com>
	<1465483189-22696-1-git-send-email-nwang@suse.com>
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 09, 2016 at 10:39:46PM +0800, Nick Wang wrote:
> [PATCH-drbd9] compat: i_mutex is replaced by i_rwsem

trivial, taken as is, though we need some backwards compat
for some older kernels (anyways), due to
   avoid error: 'inode_lock' redeclared as different kind of symbol

> [PATCH-drbd9] compat: blk_queue_flush() is replaced
> [PATCH-drbd9] compat: nla_put_u64() is removed
> [PATCH-drbd9] compat: align nla_put_u64

All solved in a slightly different way.
Still thank you for using v9 on "bleeding upstream" kernels :-)

Cheers,

	Lars


--=20
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT
