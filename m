Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 19079108B5E1
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2010 10:30:19 +0100 (CET)
Resent-Message-ID: <20100312093018.GH22282@soda.linbit>
Received: from g1t0027.austin.hp.com (g1t0027.austin.hp.com [15.216.28.34])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B5208107230A
	for <drbd-dev@lists.linbit.com>; Thu, 11 Mar 2010 23:25:09 +0100 (CET)
Date: Thu, 11 Mar 2010 15:18:08 -0700
From: dann frazier <dannf@dannf.org>
To: "Steven M. Christey" <coley@linus.mitre.org>
Message-ID: <20100311221808.GB14859@ldl.fc.hp.com>
References: <4AEEA8FD.2050601@kernel.sg>
 <0911021136010.7514@mjc.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0911021136010.7514@mjc.redhat.com>
Cc: oss-security@lists.openwall.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [oss-security] CVE request: kernel: connector
	security bypass
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Nov 02, 2009 at 11:37:21AM +0000, Mark J Cox wrote:
> On Mon, 2 Nov 2009, Eugene Teo wrote:
> 
> >1/ uvesafb/connector: Disallow unprivileged users to send netlink packets
> >upstream commit: cc44578b5a508889beb8ae3ccd4d2bbdf17bc86c
> >introduced in v2.6.24-rc1; fixed in v2.6.32-rc3
> >
> >2/ pohmelfs/connector: Disallow unprivileged users to configure pohmelfs
> >upstream commit: 98a5783af02f4c9b87b676d7bbda6258045cfc76
> >(staging/experimental)
> >
> >3/ dst/connector: Disallow unprivileged users to configure dst
> >upstream commit: 5788c56891cfb310e419c4f9ae20427851797431
> >(staging/experimental)
> >
> >4/ dm/connector: Only process connector packages from privileged processes
> >upstream commit: 24836479a126e02be691e073c2b6cad7e7ab836a
> >introduced in v2.6.31-rc1; fixed in v2.6.32-rc3
> 
> >References:
> >http://secunia.com/advisories/37113/
> >http://xorl.wordpress.com/2009/10/31/linux-kernel-multiple-capabilities-missing-checks/

Debian provides an out-of-tree drbd module (drbd8), and it appears to
be affected by this issue as well. I assume we need to allocate an
additional CVE ID for it?

Here's a link to the upstream fix:
http://git.drbd.org/?p=drbd-8.3.git;a=commitdiff;h=71915b0d267392c77fe0ae2309535333026cef66

The in-tree version that got merged for 2.6.33 looks fine.

-- 
dann frazier

