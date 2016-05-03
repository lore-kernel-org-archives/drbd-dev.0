Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9FCD5105644F
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:34:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 831CE3743BD
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:34:13 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Uqy9X-zYmDBy for <drbd-dev@lists.linbit.com>;
	Wed,  4 May 2016 14:34:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 849563743C0
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:34:12 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zpamKr5DyrYW for <drbd-dev@lists.linbit.com>;
	Wed,  4 May 2016 14:34:12 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 5EE483743BD
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:34:12 +0200 (CEST)
Resent-Message-ID: <20160504123412.GM16459@soda.linbit>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8E43E1056445
	for <drbd-dev@lists.linbit.com>;
	Tue,  3 May 2016 18:05:59 +0200 (CEST)
Date: Tue, 03 May 2016 12:05:56 -0400 (EDT)
Message-Id: <20160503.120556.1317913903199470646.davem@davemloft.net>
To: lars.ellenberg@linbit.com
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160503100644.GE16459@soda.linbit>
References: <57286F49.8050107@6wind.com>
	<1462268358-19044-1-git-send-email-nicolas.dichtel@6wind.com>
	<20160503100644.GE16459@soda.linbit>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
	philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH net-next v2] block/drbd: use
	nla_put_u64_64bit()
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
Date: Tue, 3 May 2016 12:06:44 +0200

> Please just NOT use an additional "field",
> but always use 0 to pad.

You can't, it doesn't work.

We are adding a new field to every netlink protocol family that has this
alignment problem.
