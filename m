Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 53DFF10571BD
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2011 23:16:22 +0100 (CET)
Resent-Message-ID: <20110303221620.GH25069@barkeeper1-xen.linbit>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 376B410571A0
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2011 22:39:11 +0100 (CET)
Date: Thu, 03 Mar 2011 13:39:46 -0800 (PST)
Message-Id: <20110303.133946.02287820.davem@davemloft.net>
To: chrisw@sous-sol.org
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110303201522.GT4988@sequoia.sous-sol.org>
References: <20110303173230.GP4988@sequoia.sous-sol.org>
	<20110303.105655.189705829.davem@davemloft.net>
	<20110303201522.GT4988@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org, dm-devel@redhat.com,
	zbr@ioremap.net, kaber@trash.net, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/2 v2] netlink: kill eff_cap from struct
 netlink_skb_parms
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Chris Wright <chrisw@sous-sol.org>
Date: Thu, 3 Mar 2011 12:15:22 -0800

> Here, I respun it so I could work on top of it
 ...
> I did not do exhaustive .config compile tests

Thanks a lot Chris, applied.
