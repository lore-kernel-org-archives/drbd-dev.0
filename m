Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1BBAE10571D6
	for <drbd-dev@lists.linbit.com>; Fri,  4 Mar 2011 16:05:07 +0100 (CET)
Resent-Message-ID: <20110304150504.GE8218@barkeeper1-xen.linbit>
Received: from sequoia.sous-sol.org (sous-sol.org [216.99.217.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 557B310571A2
	for <drbd-dev@lists.linbit.com>; Fri,  4 Mar 2011 00:53:22 +0100 (CET)
Date: Thu, 3 Mar 2011 15:53:05 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Chris Wright <chrisw@sous-sol.org>, David Miller <davem@davemloft.net>,
	linux-fbdev@vger.kernel.org, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org, dm-devel@redhat.com,
	Evgeniy Polyakov <zbr@ioremap.net>, kaber@trash.net,
	drbd-dev@lists.linbit.com
Message-ID: <20110303235305.GY4988@sequoia.sous-sol.org>
References: <4D6F6180.5030903@trash.net>
	<20110303173230.GP4988@sequoia.sous-sol.org>
	<20110303.105655.189705829.davem@davemloft.net>
	<20110303201522.GT4988@sequoia.sous-sol.org>
	<20110303223746.GI25069@barkeeper1-xen.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110303223746.GI25069@barkeeper1-xen.linbit>
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

* Lars Ellenberg (lars.ellenberg@linbit.com) wrote:
> Last time I checked, current() for connector based netlink message
> consumers was the work queue that is used for connector.
> 
> So unless that changed, or my understanding is wrong, current_cap()
> inside cn_queue_wrapper(), respectively the d->callback()
> will not be the userland sender process' capabilities, but the work
> queue capabilities.

Yes, you're right.

> If so, then this change introduces the possibility for normal users to
> send privileged commands to connector based subsystems, even if they
> may not be able to bind() to suitable sockets to receive any replies.
> 
> Am I missing something?

No, thanks for review.  This puts back the async issue.
