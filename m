Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2DD1710571BD
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2011 23:15:34 +0100 (CET)
Resent-Message-ID: <20110303221533.GD25069@barkeeper1-xen.linbit>
Received: from sequoia.sous-sol.org (sous-sol.org [216.99.217.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 37D96108D4D4
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2011 19:06:30 +0100 (CET)
Date: Thu, 3 Mar 2011 09:32:30 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Patrick McHardy <kaber@trash.net>
Message-ID: <20110303173230.GP4988@sequoia.sous-sol.org>
References: <4D6F6180.5030903@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D6F6180.5030903@trash.net>
Cc: NetDev <netdev@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
	Chris Wright <chrisw@sous-sol.org>, dm-devel@redhat.com,
	"David S. Miller" <davem@davemloft.net>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/2] netlink: kill eff_cap from struct
	netlink_skb_parms
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

* Patrick McHardy (kaber@trash.net) wrote:

> commit 8ff259625f0ab295fa085b0718eed13093813fbc
> Author: Patrick McHardy <kaber@trash.net>
> Date:   Thu Mar 3 10:17:31 2011 +0100
> 
>     netlink: kill eff_cap from struct netlink_skb_parms
>     
>     Netlink message processing in the kernel is synchronous these days,
>     capabilities can be checked directly in security_netlink_recv() from
>     the current process.
>     
>     Signed-off-by: Patrick McHardy <kaber@trash.net>

Thanks for doing that Patrick.  I looked at this earlier and thought
there was still an async path, but I guess that's just to another
userspace process.

BTW, I think you missed a couple connector based callers:

drivers/staging/pohmelfs/config.c:      if (!cap_raised(nsp->eff_cap, CAP_SYS_AD
drivers/video/uvesafb.c:        if (!cap_raised(nsp->eff_cap, CAP_SYS_ADMIN))

Fix those and:

Acked-by: Chris Wright <chrisw@sous-sol.org>

Ideally, we'd consolidate those into a variant of security_netlink_recv().
However the issue is with types.  Inside connector callback we only have
netlink_skb_params (seems inapproriate to cast back out to skb).

We could change the lsm hook to only pass nsp, but SELinux actually
cares about the netlink type.  Any ideas?
