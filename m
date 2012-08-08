Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4B7271050577
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 01:30:13 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so2727617pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 16:30:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 8 Aug 2012 16:30:07 -0700
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120808233007.GM6983@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-13-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344290921-25154-13-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 12/12] block: Only clone bio vecs that are
	in use
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On Mon, Aug 06, 2012 at 03:08:41PM -0700, Kent Overstreet wrote:
> @@ -459,10 +460,10 @@ void __bio_clone(struct bio *bio, struct bio *bio_src)
>  	bio->bi_sector = bio_src->bi_sector;
>  	bio->bi_bdev = bio_src->bi_bdev;
>  	bio->bi_flags |= 1 << BIO_CLONED;
> +	bio->bi_flags &= ~(1 << BIO_SEG_VALID);

This isn't obvious at all.  Why no explanation anywhere?  Also it
would be nice to update comments of the updated functions so that it's
clear that only partial cloning happens.

Thanks.

-- 
tejun
