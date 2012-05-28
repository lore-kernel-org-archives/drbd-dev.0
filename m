Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EC63210003DC
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id BA8FF1B435B
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:05 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t3mYWxOXUjZ5 for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:41:05 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 254501B4365
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:05 +0200 (CEST)
Resent-Message-ID: <20120530084105.GO4141@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BCA9F1019A68
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 18:12:34 +0200 (CEST)
Date: Mon, 28 May 2012 12:12:23 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Kent Overstreet <koverstreet@google.com>
In-Reply-To: <1337977539-16977-9-git-send-email-koverstreet@google.com>
Message-ID: <Pine.LNX.4.64.1205281210450.3913@file.rdu.redhat.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-9-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, vgoyal@redhat.com,
	bharrosh@panasas.com, linux-fsdevel@vger.kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 08/16] block: Rework bio splitting
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>



On Fri, 25 May 2012, Kent Overstreet wrote:

> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index f8b6f14..0062326 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1001,15 +1001,9 @@ static void make_request(struct mddev *mddev, struct bio * bio)
>  		      > chunk_sects &&
>  		    conf->near_copies < conf->raid_disks)) {
>  		struct bio_pair *bp;
> -		/* Sanity check -- queue functions should prevent this happening */
> -		if (bio->bi_vcnt != 1 ||
> -		    bio->bi_idx != 0)
> -			goto bad_map;
> -		/* This is a one page bio that upper layers
> -		 * refuse to split for us, so we need to split it.
> -		 */
> +

That "Sanity check" should be removed from drivers/md/raid0.c too. Your 
patch only removes it from raid10.

Mikulas
