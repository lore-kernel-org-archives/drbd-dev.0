Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BD1B21055700
	for <drbd-dev@lists.linbit.com>; Fri, 26 Aug 2011 14:31:28 +0200 (CEST)
Resent-Message-ID: <20110826123128.GQ14479@barkeeper1-xen.linbit>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F038B10556B5
	for <drbd-dev@lists.linbit.com>; Fri, 26 Aug 2011 03:53:06 +0200 (CEST)
Date: Thu, 25 Aug 2011 21:30:53 -0400 (EDT)
Message-Id: <20110825.213053.2158489778661112155.davem@davemloft.net>
To: philipp.reisner@linbit.com
From: David Miller <davem@davemloft.net>
In-Reply-To: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC 000/118] drbd: part 1 of adding multiple volume
 support to drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Please do not ever post such an enourmous number of patches at one
time.  Instead, break up your submittion into more manageable sets of
patches, say 10 or so at a time.
