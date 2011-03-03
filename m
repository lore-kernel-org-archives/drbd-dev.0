Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B030A10571BE
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2011 23:16:06 +0100 (CET)
Resent-Message-ID: <20110303221604.GG25069@barkeeper1-xen.linbit>
Received: from sequoia.sous-sol.org (sous-sol.org [216.99.217.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7136810571A8
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2011 21:17:30 +0100 (CET)
Date: Thu, 3 Mar 2011 12:17:26 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Chris Wright <chrisw@sous-sol.org>
Message-ID: <20110303201726.GU4988@sequoia.sous-sol.org>
References: <4D6F6180.5030903@trash.net>
	<20110303173230.GP4988@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110303173230.GP4988@sequoia.sous-sol.org>
Cc: NetDev <netdev@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, dm-devel@redhat.com,
	Patrick McHardy <kaber@trash.net>, drbd-dev@lists.linbit.com
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

* Chris Wright (chrisw@sous-sol.org) wrote:
> Ideally, we'd consolidate those into a variant of security_netlink_recv().
> However the issue is with types.  Inside connector callback we only have
> netlink_skb_params (seems inapproriate to cast back out to skb).
> 
> We could change the lsm hook to only pass nsp, but SELinux actually
> cares about the netlink type.  Any ideas?

Actually I misremembered, it only cares on the send path.

We could completely drop skb from recv lsm hook, will send an RFC
momentarily with example.

thanks,
-chris
