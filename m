Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A5EBD1011BFF
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 16:26:15 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id d18so17138161wrs.5
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 07:26:15 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219])
	by smtp.gmail.com with ESMTPSA id g8sm195373wmf.17.2019.06.12.07.26.13
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 12 Jun 2019 07:26:13 -0700 (PDT)
Date: Wed, 12 Jun 2019 16:26:12 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190612142612.GB5803@soda.linbit>
References: <28397d5c-72ca-e4b5-fb00-7b55466e7441@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28397d5c-72ca-e4b5-fb00-7b55466e7441@gmail.com>
Subject: Re: [Drbd-dev] main.c comments
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

On Wed, Jun 05, 2019 at 10:15:23AM -0600, David Butterfield wrote:
> These three comments about main.c are the end of what I have on DRBD for now.
> 
> Three more things I noticed in drbd_main.c:
> 
> (1) Isn't the third argument to module_param_named() supposed to be the type of
>     the second argument?  (But seems to require it as a single token??)

Yes and no ;-)
the type of the second argument in this case is a drbd_protocol_version,
so by naming that as third argument, we point to the "conversion and
validation functions" for that type.

See param_ops_drbd_protocol_version

again, "details depend on the kernel version"...

> (2) The cast avoids a compiler warning about signed/unsigned comparison.

As long as our kernel compiles complete without warnings, "boring".

> (3) q->queue_lock is needed by blk_queue_flag_set(), even if !defined(blk_queue_plugged),
>     so I would move its initialization outside the #ifdef blk_queue_plugged.

No. This is compat code, and needs to be that way.
See how the q->queue_lock evolved over time in the kernel,
used to be a pointer, without implicit initialization,
then was changed to implicit initialization "sometimes"
to an embeded struct, then was changed to implicit initialization
always to that embeded struct, then was changed to become that embeded
struct itself.

> diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
> index 4204deff..69245c57 100644
> --- a/drbd/drbd_main.c
> +++ b/drbd/drbd_main.c
> @@ -146,7 +153,7 @@ const struct kernel_param_ops param_ops_drbd_protocol_version = {
>  #endif
> 
>  unsigned int drbd_protocol_version_min = PRO_VERSION_MIN;
> -module_param_named(protocol_version_min, drbd_protocol_version_min, drbd_protocol_version, 0644);
> +module_param_named(protocol_version_min, drbd_protocol_version_min, uint, 0644);
> 
> 
>  /* in 2.6.x, our device mapping and config info contains our virtual gendisks
> @@ -1831,7 +1840,7 @@ static void dcbp_set_start(struct p_compressed_bm *p, int set)
>  static void dcbp_set_pad_bits(struct p_compressed_bm *p, int n)
>  {
>         BUG_ON(n & ~0x7);
> -       p->encoding = (p->encoding & (~0x7 << 4)) | (n << 4);
> +       p->encoding = (p->encoding & ((unsigned)~0x7 << 4)) | (n << 4);
>  }
> 
>  static int fill_bitmap_rle_bits(struct drbd_peer_device *peer_device,
> @@ -3760,8 +3769,9 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>  #ifdef COMPAT_HAVE_BLK_QUEUE_MERGE_BVEC
>         blk_queue_merge_bvec(q, drbd_merge_bvec);
>  #endif
> +       q->queue_lock = &resource->req_lock; /* used by blk_queue_flag_set() */
>  #ifdef blk_queue_plugged
> -       q->queue_lock = &resource->req_lock; /* needed since we use */
> +       /* needed since we use */
>         /* plugging on a queue, that actually has no requests! */
>         q->unplug_fn = drbd_unplug_fn;
>  #endif

