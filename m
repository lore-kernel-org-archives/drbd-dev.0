Return-Path: <lmb@suse.de>
Received: from mx.in-addr.de (gate.in-addr.de [212.8.193.158])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 49FAB1069373
	for <drbd-dev@lists.linbit.com>; Sun, 20 Sep 2009 00:03:02 +0200 (CEST)
Date: Sun, 20 Sep 2009 00:02:32 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	jens.axboe@oracle.com
Message-ID: <20090919220232.GB31849@suse.de>
References: <20090917161108.GA3361@infradead.org>
	<19122.65335.126937.476968@notabene.brown>
	<20090918200803.GM23126@kernel.dk>
	<20090919141334N.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090919141334N.fujita.tomonori@lab.ntt.co.jp>
Cc: bart.vanassche@gmail.com, kyle@moffetthome.net, sam@ravnborg.org,
	neilb@suse.de, knikanth@suse.de, gregkh@suse.de,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	hch@infradead.org, James.Bottomley@suse.de,
	kosaki.motohiro@jp.fujitsu.com, davej@redhat.com,
	lars.ellenberg@linbit.com, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2009-09-19T14:14:30, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:

> I guess that Christoph is worry about adding another user interface
> for kinda device management; once we merge this, we can't fix it (for
> the raid unification).

Why can't it be fixed?

Either

a) there's going to be a transition period during which the "old"
interface is supported but depreciated and scheduled to be removed (all
driving the new unified same back-end),

or b) there's going to be a new kernel which requires new user-space
tools sharp.

In either case, dm/md are affected by this, so a third interface doesn't
really make much difference. The refactoring needs to happen in the
back-end anyway, and that actually becomes easier when all concurrent
implementations are present and can be reworked at the same time.

> BTW, DM already has something like drbd? I thought that there is a
> talk about that new target at LinuxCon.

dm-replicator is nowhere near as usable as DRBD, and not upstream yet
either. (Further, it's another independent implementation, pursued
instead of unifying any of the existing ones or helping to merge drbd -
don't get me started on my thoughts of that.)


Regards,
    Lars

-- 
Architect Storage/HA, OPS Engineering, Novell, Inc.
SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

