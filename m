Return-Path: <lmb@suse.de>
Received: from mx.in-addr.de (gate.in-addr.de [212.8.193.158])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AA36510622AF
	for <drbd-dev@lists.linbit.com>; Fri, 25 Sep 2009 12:01:46 +0200 (CEST)
Date: Fri, 25 Sep 2009 11:59:08 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Neil Brown <neilb@suse.de>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20090925095908.GC28951@suse.de>
References: <20090922062034.GE22732@suse.de>
	<20090923203531C.fujita.tomonori@lab.ntt.co.jp>
	<19130.43495.807916.962040@notabene.brown>
	<20090924083617J.fujita.tomonori@lab.ntt.co.jp>
	<19132.21708.867658.970822@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19132.21708.867658.970822@notabene.brown>
Cc: bart.vanassche@gmail.com, kyle@moffetthome.net, sam@ravnborg.org,
	knikanth@suse.de, gregkh@suse.de, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com, hch@infradead.org,
	Mauelshagen@redhat.com, James.Bottomley@suse.de,
	kosaki.motohiro@jp.fujitsu.com, jens.axboe@oracle.com,
	davej@redhat.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, arjan@infradead.org
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2009-09-25T15:27:40, Neil Brown <neilb@suse.de> wrote:

> > Enterprise vendors don't pick up the latest kernel. So I think that we
> > need more.

Enterprise kernel providers tend to accept the burden of supporting
their enterprise releases. While I appreciate the thought from the
community, I think the enterprise kernels already including drbd would
be extremely happy to see it officially included.

> I don't really follow your logic, but that isn't important.  I think
> that we need to be open to deprecating old ABIs, particularly when the
> ABI is largely used by just one or two programs or libraries.  This is
> the case for md/dm/drbd and similar devices.

It is even one step beyond this here. The additional ABI effort is
raised as an objection to merging drbd, and the drbd developers and user
community is offering to depreciate it within a reasonable timeframe of
a better ABI existing (since this will be hidden in the user-space
tools), if this means that it can be merged earlier.

This is quite different from an ABI which is expected to be stable and
remain forever (even if it was just an implicit user assumption); the
expectations are set accordingly from day 0, and thus should not be a
hurdle to acceptance.


Regards,
    Lars

-- 
Architect Storage/HA, OPS Engineering, Novell, Inc.
SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

