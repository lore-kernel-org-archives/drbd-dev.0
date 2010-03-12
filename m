Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1AA10105E8AE
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2010 23:18:56 +0100 (CET)
Resent-Message-ID: <20100312221855.GL22282@soda.linbit>
Date: Fri, 12 Mar 2010 09:47:11 -0700
From: dann frazier <dannf@dannf.org>
To: "Steven M. Christey" <coley@linus.mitre.org>,
	oss-security@lists.openwall.com, drbd-dev@lists.linbit.com,
	drbd-user@lists.linbit.com
Message-ID: <20100312164711.GF22141@lackof.org>
References: <4AEEA8FD.2050601@kernel.sg> <0911021136010.7514@mjc.redhat.com>
	<20100311221808.GB14859@ldl.fc.hp.com>
	<20100312093452.GI22282@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100312093452.GI22282@soda.linbit>
Subject: Re: [Drbd-dev] [oss-security] CVE request: kernel:
	connector	security bypass
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Mar 12, 2010 at 10:34:52AM +0100, Lars Ellenberg wrote:
> On Thu, Mar 11, 2010 at 03:18:08PM -0700, dann frazier wrote:
> > On Mon, Nov 02, 2009 at 11:37:21AM +0000, Mark J Cox wrote:
> > > On Mon, 2 Nov 2009, Eugene Teo wrote:
> > > 
> > > >1/ uvesafb/connector: Disallow unprivileged users to send netlink packets
> > > >upstream commit: cc44578b5a508889beb8ae3ccd4d2bbdf17bc86c
> > > >introduced in v2.6.24-rc1; fixed in v2.6.32-rc3
> > > >
> > > >2/ pohmelfs/connector: Disallow unprivileged users to configure pohmelfs
> > > >upstream commit: 98a5783af02f4c9b87b676d7bbda6258045cfc76
> > > >(staging/experimental)
> > > >
> > > >3/ dst/connector: Disallow unprivileged users to configure dst
> > > >upstream commit: 5788c56891cfb310e419c4f9ae20427851797431
> > > >(staging/experimental)
> > > >
> > > >4/ dm/connector: Only process connector packages from privileged processes
> > > >upstream commit: 24836479a126e02be691e073c2b6cad7e7ab836a
> > > >introduced in v2.6.31-rc1; fixed in v2.6.32-rc3
> > > 
> > > >References:
> > > >http://secunia.com/advisories/37113/
> > > >http://xorl.wordpress.com/2009/10/31/linux-kernel-multiple-capabilities-missing-checks/
> > 
> > Debian provides an out-of-tree drbd module (drbd8), and it appears to
> > be affected by this issue as well. I assume we need to allocate an
> > additional CVE ID for it?
> 
> Maybe just go to current upstream drbd 8.3.7?

Lars,
 Thanks for the suggestion. That is a possible solution for our next
release of Debian (as is moving to the in-tree version), but for our
current stable release we have backported "just-the-fix" as required
by our security update policy.

-- 
dann frazier

