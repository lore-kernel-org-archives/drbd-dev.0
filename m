Return-Path: <lmb@suse.de>
Received: from mx.in-addr.de (gate.in-addr.de [212.8.193.158])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 254F410622A9
	for <drbd-dev@lists.linbit.com>; Tue, 22 Sep 2009 08:21:10 +0200 (CEST)
Date: Tue, 22 Sep 2009 08:20:34 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, lars.ellenberg@linbit.com
Message-ID: <20090922062034.GE22732@suse.de>
References: <20090921144308.GG8072@barkeeper1-xen.linbit>
	<20090921165252.04e335b1@infradead.org>
	<20090921165321.GJ8072@barkeeper1-xen.linbit>
	<20090922072617U.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090922072617U.fujita.tomonori@lab.ntt.co.jp>
Cc: bart.vanassche@gmail.com, kyle@moffetthome.net, sam@ravnborg.org,
	neilb@suse.de, knikanth@suse.de, gregkh@suse.de,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	hch@infradead.org, Mauelshagen@redhat.com,
	James.Bottomley@suse.de, kosaki.motohiro@jp.fujitsu.com,
	jens.axboe@oracle.com, davej@redhat.com,
	akpm@linux-foundation.org, drbd-dev@lists.linbit.com,
	torvalds@linux-foundation.org, arjan@infradead.org
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2009-09-22T07:27:21, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:

> > If it happens, once that happens, that _will_ be an ABI break.
> 
> You misunderstand the raid unification.
> 
> We will not unify the kernel<->userspace configuration interface
> because we can't break the kernel<->userspace ABI.

I disagree here. Who says we can't over time, and with due notice?

For sure, the new ABI needs to co-exist with the old ones for a while,
until it is proven and fully complete, but then, why can't the old one
be marked as depreciated and phased out over 1-2 years time?

Users won't notice. Modern distros will switch, and in cases of legacy
distros ("enterprise"), the vendors will backport appropriately.

This happens. There's precedence with the network filtering rules etc.

> We plan to unify the multiple device frameworks, but the unified
> framework must support the all existing ABIs.
> 
> So adding another 'drbd' ABI hurts us.

Even that doesn't really apply, I think. If the new framework is
powerful enough and a super-set of everything that came before, the shim
layer will be somewhat annoying, but harmless code.


Regards,
    Lars

-- 
Architect Storage/HA, OPS Engineering, Novell, Inc.
SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

