Return-Path: <axboe@kernel.dk>
Received: from mail-pl0-f68.google.com (mail-pl0-f68.google.com
	[209.85.160.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EDC47101AC56
	for <drbd-dev@lists.linbit.com>; Thu, 31 May 2018 00:30:45 +0200 (CEST)
Received: by mail-pl0-f68.google.com with SMTP id n10-v6so11934879plp.0
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2018 15:30:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Kent Overstreet <kent.overstreet@gmail.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	hch@infradead.org, colyli@suse.de, snitzer@redhat.com,
	darrick.wong@oracle.com, clm@fb.com, bacik@fb.com,
	linux-xfs@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org, neilb@suse.com
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
Message-ID: <234774e0-38d8-77ea-ca40-88da8b3c5ec6@kernel.dk>
Date: Wed, 30 May 2018 16:24:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180520222558.7053-1-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH 00/13] convert block layer to
	bioset_init()/mempool_init()
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

On 5/20/18 4:25 PM, Kent Overstreet wrote:
> Jens - this series does the rest of the conversions that Christoph wanted, and
> drops bioset_create().
> 
> Only lightly tested, but the changes are pretty mechanical. Based on your
> for-next tree.
> 
> It's also in the for-jens branch at https://evilpiepirate.org/git/bcachefs.git
> 
> Kent Overstreet (12):
>   block: convert bounce, q->bio_split to bioset_init()/mempool_init()
>   drbd: convert to bioset_init()/mempool_init()
>   pktcdvd: convert to bioset_init()/mempool_init()
>   lightnvm: convert to bioset_init()/mempool_init()
>   bcache: convert to bioset_init()/mempool_init()
>   md: convert to bioset_init()/mempool_init()
>   dm: convert to bioset_init()/mempool_init()
>   target: convert to bioset_init()/mempool_init()
>   fs: convert block_dev.c to bioset_init()
>   btrfs: convert to bioset_init()/mempool_init()
>   xfs: convert to bioset_init()/mempool_init()
>   block: Drop bioset_create()

With the reviews, I've queued this up for 4.18.

-- 
Jens Axboe

