Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CC01710571B7
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2011 23:15:44 +0100 (CET)
Resent-Message-ID: <20110303221542.GE25069@barkeeper1-xen.linbit>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id ADAB610571A4
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2011 20:06:02 +0100 (CET)
Date: Thu, 03 Mar 2011 10:56:55 -0800 (PST)
Message-Id: <20110303.105655.189705829.davem@davemloft.net>
To: chrisw@sous-sol.org
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110303173230.GP4988@sequoia.sous-sol.org>
References: <4D6F6180.5030903@trash.net>
	<20110303173230.GP4988@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: netdev@vger.kernel.org, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
	kaber@trash.net, linux-security-module@vger.kernel.org
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

From: Chris Wright <chrisw@sous-sol.org>
Date: Thu, 3 Mar 2011 09:32:30 -0800

> * Patrick McHardy (kaber@trash.net) wrote:
> 
>> commit 8ff259625f0ab295fa085b0718eed13093813fbc
>> Author: Patrick McHardy <kaber@trash.net>
>> Date:   Thu Mar 3 10:17:31 2011 +0100
>> 
>>     netlink: kill eff_cap from struct netlink_skb_parms
>>     
>>     Netlink message processing in the kernel is synchronous these days,
>>     capabilities can be checked directly in security_netlink_recv() from
>>     the current process.
>>     
>>     Signed-off-by: Patrick McHardy <kaber@trash.net>
> 
> Thanks for doing that Patrick.  I looked at this earlier and thought
> there was still an async path, but I guess that's just to another
> userspace process.
> 
> BTW, I think you missed a couple connector based callers:
> 
> drivers/staging/pohmelfs/config.c:      if (!cap_raised(nsp->eff_cap, CAP_SYS_AD
> drivers/video/uvesafb.c:        if (!cap_raised(nsp->eff_cap, CAP_SYS_ADMIN))
> 
> Fix those and:
> 
> Acked-by: Chris Wright <chrisw@sous-sol.org>

Patrick, I'll apply your first patch, please respin this second patch with
the changes mentioned here.

Thanks!
