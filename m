Return-Path: <BATV+a44557d646e720d5a26d+5259+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 587B71057968
	for <drbd-dev@lists.linbit.com>;
	Tue, 16 Jan 2018 08:47:43 +0100 (CET)
Date: Mon, 15 Jan 2018 23:26:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Wheeler <drbd-dev@lists.ewheeler.net>
Message-ID: <20180116072615.GA3940@infradead.org>
References: <15124635.GA4107@soda.linbit>
	<1516057231-21756-1-git-send-email-drbd-dev@lists.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516057231-21756-1-git-send-email-drbd-dev@lists.ewheeler.net>
Cc: Eric Wheeler <drbd@linux.ewheeler.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Eric Wheeler <git@linux.ewheeler.net>, drbd-dev@lists.linbit.com
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

NAK.  Calling a discard and expecting zeroing is simply buggy.

And double NAK for patches like this without a linux-block Cc.
