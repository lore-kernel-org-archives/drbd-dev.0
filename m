Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 03B451056331
	for <drbd-dev@lists.linbit.com>; Tue,  5 Apr 2016 14:42:39 +0200 (CEST)
Date: Tue, 5 Apr 2016 14:42:38 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Ming Lei <tom.leiming@gmail.com>
Message-ID: <20160405124238.GV3078@soda.linbit>
References: <1459857443-20611-1-git-send-email-tom.leiming@gmail.com>
	<1459857443-20611-4-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459857443-20611-4-git-send-email-tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Boaz Harrosh <boaz@plexistor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@infradead.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 03/27] block: drbd: remove impossible failure
	handling
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

On Tue, Apr 05, 2016 at 07:56:48PM +0800, Ming Lei wrote:
> For a non-cloned bio, bio_add_page() only returns failure when
> the io vec table is full, but in that case, bio->bi_vcnt can't
> be zero at all.
> 
> So remove the impossible failure handling.

Before the immutable bvecs,
we did in fact see this trigger in the wild.
On "strange" deployments.

But for the current implementation of bio_add_page(),
you are correct, this is impossible now.

Ack.

Thanks,

    Lars

