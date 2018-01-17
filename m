Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8D3A910575A4
	for <drbd-dev@lists.linbit.com>; Wed, 17 Jan 2018 01:43:41 +0100 (CET)
Date: Wed, 17 Jan 2018 00:43:35 +0000 (UTC)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20180116072615.GA3940@infradead.org>
Message-ID: <alpine.LRH.2.11.1801170041330.27949@mail.ewheeler.net>
References: <15124635.GA4107@soda.linbit>
	<1516057231-21756-1-git-send-email-drbd-dev@lists.ewheeler.net>
	<20180116072615.GA3940@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	stable@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: fix discard_zeroes_if_aligned
	regression
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

On Mon, 15 Jan 2018, Christoph Hellwig wrote:

> NAK.  Calling a discard and expecting zeroing is simply buggy.

But of course, that would be silly.

We don't expect discard to zero---but we do expect discard to discard!

> And double NAK for patches like this without a linux-block Cc.

My appologies, I thought this was internal to DRBD.  

What is the general rule here?

Should linux-block always be Cc'ed with a patch?

--
Eric Wheeler

