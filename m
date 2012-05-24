Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 35F451005420
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 2BAEF1B4262
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:58 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrDd5-7ymu-f for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 09:03:58 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 0F8461B4206
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:03:58 +0200 (CEST)
Resent-Message-ID: <20120525070358.GG12726@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D563E1017A2C
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 21:43:07 +0200 (CEST)
Date: Thu, 24 May 2012 15:42:52 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Kent Overstreet <koverstreet@google.com>
Message-ID: <20120524194252.GF27550@redhat.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-8-git-send-email-koverstreet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337817771-25038-8-git-send-email-koverstreet@google.com>
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	bharrosh@panasas.com, linux-fsdevel@vger.kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 07/14] pktcdvd: Switch to bio_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, May 23, 2012 at 05:02:44PM -0700, Kent Overstreet wrote:

[..]
> @@ -567,10 +569,13 @@ static struct packet_data *pkt_alloc_packet_data(int frames)
>  		goto no_pkt;
>  
>  	pkt->frames = frames;
> -	pkt->w_bio = pkt_bio_alloc(frames);
> +	pkt->w_bio = bio_kmalloc(GFP_KERNEL, frames);

So previously bios allocated were being kfreed by pkt_bio_destructor().
Now where are we doing kfree() on bio being allocated by bio_kmalloc()?

Thanks
Vivek
