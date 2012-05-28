Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8AAC41013803
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 03:23:24 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so5016129pbb.27
	for <drbd-dev@lists.linbit.com>; Sun, 27 May 2012 18:23:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 28 May 2012 10:23:07 +0900
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120528012307.GC9891@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-4-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337977539-16977-4-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 03/16] block: Add bio_reset()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, May 25, 2012 at 01:25:26PM -0700, Kent Overstreet wrote:
> Reusing bios is something that's been highly frowned upon in the past,
> but driver code keeps doing it anyways. If it's going to happen anyways,
> we should provide a generic method.
> 
> This'll help with getting rid of bi_destructor - drivers/block/pktcdvd.c
> was open coding it, by doing a bio_init() and resetting bi_destructor.
> 
> Signed-off-by: Kent Overstreet <koverstreet@google.com>
> Change-Id: Ib0a43dfcb3f6c22a54da513d4a86be544b5ffd95
> ---
>  fs/bio.c                  |    8 ++++++++
>  include/linux/bio.h       |    1 +
>  include/linux/blk_types.h |    6 ++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/fs/bio.c b/fs/bio.c
> index 3667cef..240da21 100644
> --- a/fs/bio.c
> +++ b/fs/bio.c
> @@ -259,6 +259,14 @@ void bio_init(struct bio *bio)
>  }
>  EXPORT_SYMBOL(bio_init);
>  

Function comment please.

> +void bio_reset(struct bio *bio)
> +{
> +	memset(bio, 0, BIO_RESET_BYTES);
> +	bio->bi_flags = 1 << BIO_UPTODATE;
> +
> +}
> +EXPORT_SYMBOL(bio_reset);

-- 
tejun
