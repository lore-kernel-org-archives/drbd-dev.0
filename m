Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 96F8B1051881
	for <drbd-dev@lists.linbit.com>; Wed, 27 Apr 2016 10:34:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8738840541E
	for <drbd-dev@lists.linbit.com>; Wed, 27 Apr 2016 10:34:07 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id L5HVXKogQ1X7 for <drbd-dev@lists.linbit.com>;
	Wed, 27 Apr 2016 10:34:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6522F405425
	for <drbd-dev@lists.linbit.com>; Wed, 27 Apr 2016 10:34:07 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kav4JbZE9kjz for <drbd-dev@lists.linbit.com>;
	Wed, 27 Apr 2016 10:34:07 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 38F3140541E
	for <drbd-dev@lists.linbit.com>; Wed, 27 Apr 2016 10:34:07 +0200 (CEST)
Resent-Message-ID: <20160427083406.GN20950@soda.linbit>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EC5C71056332
	for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 18:25:17 +0200 (CEST)
Date: Tue, 26 Apr 2016 12:25:15 -0400 (EDT)
Message-Id: <20160426.122515.1389035390419695445.davem@davemloft.net>
To: lars.ellenberg@linbit.com
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160426115427.GB20950@soda.linbit>
References: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
	<20160426115427.GB20950@soda.linbit>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: dev@openvswitch.org, sd@queasysnail.net, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	jhs@mojatatu.com, pshelar@nicira.com, jack@suse.com,
	nicolas.dichtel@6wind.com, philipp.reisner@linbit.com,
	johannes@sipsolutions.net, kvalo@codeaurora.org, drbd-dev@lists.linbit.com
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Tue, 26 Apr 2016 13:54:27 +0200

> On Tue, Apr 26, 2016 at 10:06:10AM +0200, Nicolas Dichtel wrote:
>> 
>> This is the continuation (series #3) of the work done to align netlink
>> attributes when these attributes contain some 64-bit fields.
>> 
>> It's the last patchset from what I've seen.
>> 
>> The last user of nla_put_u64() is block/drbd. This module does not use
>> standard netlink API (see all the stuff in include/linux/genl_magic_struct.h
>> and include/linux/genl_magic_func.h). I didn't modify it because it's seems
>> hard to do it whithout testing and fully understanding the context
> 
> Something like this should just work.

Unfortunately we had problems using unspec, that's why an explicit new
padding attribute is added for each netlink attribute set.
