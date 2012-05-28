Return-Path: <htejun@gmail.com>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9F7BF10000B6
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 03:36:25 +0200 (CEST)
Received: by dadv36 with SMTP id v36so4353796dad.27
	for <drbd-dev@lists.linbit.com>; Sun, 27 May 2012 18:36:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 28 May 2012 10:36:08 +0900
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120528013608.GE9891@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-6-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337977539-16977-6-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 05/16] block: Kill bi_destructor
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, May 25, 2012 at 01:25:28PM -0700, Kent Overstreet wrote:
> Now that we've got generic code for freeing bios allocated from bio
> pools, this isn't needed anymore.
> 
> This also changes the semantics of bio_free() a bit - it now also frees
> bios allocated by bio_kmalloc(). It's also no longer exported, as
> without bi_destructor there should be no need for it to be called
> anywhere else.

I like this patch but I'd *really* like to see the patch description
giving some background and explains *why* this is a good change.

> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 6b7daf3..b6ddbf1 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -74,11 +74,8 @@ struct bio {
>  	struct bio_integrity_payload *bi_integrity;  /* data integrity */
>  #endif
>  
> -	/* If bi_pool is non NULL, bi_destructor is not called */
>  	struct bio_set		*bi_pool;

Maybe explain that %NULL bi_pool indicates kmalloc backed allocation?

-- 
tejun
