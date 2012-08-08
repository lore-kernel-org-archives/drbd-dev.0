Return-Path: <htejun@gmail.com>
Received: from mail-gh0-f182.google.com (mail-gh0-f182.google.com
	[209.85.160.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EDC5C1013804
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 00:11:36 +0200 (CEST)
Received: by ghrr13 with SMTP id r13so2047605ghr.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 15:11:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 8 Aug 2012 15:11:29 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120808221129.GB6983@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-4-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344290921-25154-4-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 03/12] block: Add bio_reset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On Mon, Aug 06, 2012 at 03:08:32PM -0700, Kent Overstreet wrote:
> Reusing bios is something that's been highly frowned upon in the past,
> but driver code keeps doing it anyways. If it's going to happen anyways,
> we should provide a generic method.
> 
> This'll help with getting rid of bi_destructor - drivers/block/pktcdvd.c
> was open coding it, by doing a bio_init() and resetting bi_destructor.
> 
> v5: Add a define BIO_RESET_BITS, to be very explicit about what parts of
> bio->bi_flags are saved.
> 
> Signed-off-by: Kent Overstreet <koverstreet@google.com>
> Change-Id: I4eb2975bd678d3be811d5423d0620b08020be9ff

Please drop Change-Id.  Die gerrit die.

> +void bio_reset(struct bio *bio)
> +{
> +	unsigned long flags = bio->bi_flags & (~0UL << BIO_RESET_BITS);

How many flags are we talking about?  If there aren't too many, I'd
prefer explicit BIO_FLAGS_PRESERVED or whatever.

Thanks.

-- 
tejun
