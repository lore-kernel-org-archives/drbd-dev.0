Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 17FCA1056451
	for <drbd-dev@lists.linbit.com>; Fri, 13 May 2016 14:48:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1239F40476C
	for <drbd-dev@lists.linbit.com>; Fri, 13 May 2016 14:48:57 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id dnWDrmwG_C3W for <drbd-dev@lists.linbit.com>;
	Fri, 13 May 2016 14:48:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B71D1406001
	for <drbd-dev@lists.linbit.com>; Fri, 13 May 2016 14:48:56 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0Z0Zdti8Bj6r for <drbd-dev@lists.linbit.com>;
	Fri, 13 May 2016 14:48:56 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 8A0D140476C
	for <drbd-dev@lists.linbit.com>; Fri, 13 May 2016 14:48:56 +0200 (CEST)
Resent-Message-ID: <20160513124856.GJ16459@soda.linbit>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BC2BB1056443
	for <drbd-dev@lists.linbit.com>;
	Tue, 10 May 2016 21:26:58 +0200 (CEST)
Date: Tue, 10 May 2016 15:26:54 -0400 (EDT)
Message-Id: <20160510.152654.2108832191252699071.davem@davemloft.net>
To: lars.ellenberg@linbit.com
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160510190902.GF16459@soda.linbit>
References: <20160510094023.GC16459@soda.linbit>
	<20160510.113949.2077250222547175741.davem@davemloft.net>
	<20160510190902.GF16459@soda.linbit>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
	philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Tue, 10 May 2016 21:09:03 +0200

> On Tue, May 10, 2016 at 11:39:49AM -0400, David Miller wrote:
>> From: Lars Ellenberg <lars.ellenberg@linbit.com>
>> Date: Tue, 10 May 2016 11:40:23 +0200
> 
> excuse me for reordering the original:
> 
>> Anyways, back to the topic, can you please just relent and come to
>> some kind of agreement about the fix for this alignment bug?
> 
> I thought we did?  I'm fine with the "v3",
> it even carries my signed-of-by.

My bad, I missed that, I'll apply v3 thanks a lot!
