Return-Path: <josef@toxicpanda.com>
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
	[209.85.219.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AF49D420231
	for <drbd-dev@lists.linbit.com>; Tue, 26 Jan 2021 16:01:38 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id 2so7955333qvd.0
	for <drbd-dev@lists.linbit.com>; Tue, 26 Jan 2021 07:01:38 -0800 (PST)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>
References: <20210126145247.1964410-1-hch@lst.de>
	<20210126145247.1964410-3-hch@lst.de>
From: Josef Bacik <josef@toxicpanda.com>
Message-ID: <d3717e48-9e42-fa7a-12c2-a6c97eaf4a7b@toxicpanda.com>
Date: Tue, 26 Jan 2021 10:01:34 -0500
MIME-Version: 1.0
In-Reply-To: <20210126145247.1964410-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Mike Snitzer <snitzer@redhat.com>, linux-mm@kvack.org, dm-devel@redhat.com,
	drbd-dev@lists.linbit.com, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-nilfs@vger.kernel.org, Chao Yu <chao@kernel.org>,
	linux-nfs@vger.kernel.org, Coly Li <colyli@suse.de>,
	linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, linux-block@vger.kernel.org,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 02/17] btrfs: use bio_kmalloc in
	__alloc_device
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 1/26/21 9:52 AM, Christoph Hellwig wrote:
> Use bio_kmalloc instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

yay I contributed,

Josef
