Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 52B891011BA2
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:18:51 +0200 (CEST)
Date: Tue, 26 Apr 2016 14:18:50 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
	davem@davemloft.net, sd@queasysnail.net, johannes@sipsolutions.net,
	kvalo@codeaurora.org, linux-wireless@vger.kernel.org, jack@suse.com,
	linux-kernel@vger.kernel.org, pshelar@nicira.com,
	dev@openvswitch.org, jhs@mojatatu.com, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Message-ID: <20160426121850.GC20950@soda.linbit>
References: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
	<20160426115427.GB20950@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160426115427.GB20950@soda.linbit>
Subject: Re: [Drbd-dev] [PATCH net-next 0/8] netlink: align attributes when
 needed (patchset #3)
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

On Tue, Apr 26, 2016 at 01:54:27PM +0200, Lars Ellenberg wrote:
> On Tue, Apr 26, 2016 at 10:06:10AM +0200, Nicolas Dichtel wrote:
> > 
> > This is the continuation (series #3) of the work done to align netlink
> > attributes when these attributes contain some 64-bit fields.
> > 
> > It's the last patchset from what I've seen.
> > 
> > The last user of nla_put_u64() is block/drbd. This module does not use
> > standard netlink API (see all the stuff in include/linux/genl_magic_struct.h
> > and include/linux/genl_magic_func.h). I didn't modify it because it's seems
> > hard to do it whithout testing and fully understanding the context
> 
> Something like this should just work.

> + * @attrtype: attribute type
> + * @value: numeric value
> + */
> +static inline int nla_put_u64_64bit_unspec(struct sk_buff *skb, int attrtype,
> +				    u64 value)
> +{
> +	return nla_put_64bit(skb, attrtype, sizeof(u64), &value, NLA_UNSPEC);

Ok, I confused attribute and policy type there for a sec.
Anyways, 0 works just fine,
all our nested attribute enums are != 0,
because nla_parse skips type 0.

    Lars

