Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B0DB01056332
	for <drbd-dev@lists.linbit.com>; Mon,  9 May 2016 15:15:49 +0200 (CEST)
Date: Mon, 9 May 2016 15:15:48 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <20160509131547.GX16459@soda.linbit>
References: <20160503100644.GE16459@soda.linbit>
	<1462786820-15519-1-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462786820-15519-1-git-send-email-nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org, drbd-dev@lists.linbit.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com
Subject: Re: [Drbd-dev] [PATCH net-next v3] block/drbd: align properly u64
	in nl messages
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, May 09, 2016 at 11:40:20AM +0200, Nicolas Dichtel wrote:
> The attribute 0 is never used in drbd, so let's use it as pad attribute
> in netlink messages. This minimizes the patch.
> 
> Note that this patch is only compile-tested.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> ---
> 
> v2 -> v3:
>   use 0 as padattr instead of adding new attributes

Thanks.

> v1 -> v2:
>  rework the patch to handle all cases
> 
> Maybe prefixing genl_magic_func.h and genl_magic_struct.h by 'drbd_'
> could be interesting so that new module won't use it. What is your
> opinion?

This was supposed to not be DRBD specific.  But it might even still
need some massaging before it was truly generic. And obviously,
it does not meet the taste of genetlink folks, to say the least :(

I don't care either way.

    Lars Ellenberg

