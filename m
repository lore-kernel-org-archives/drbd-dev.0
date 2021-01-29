Return-Path: <yuchao0@huawei.com>
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D4F6042061F
	for <drbd-dev@lists.linbit.com>;
	Fri, 29 Jan 2021 02:22:16 +0100 (CET)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Song Liu
	<song@kernel.org>
References: <20210126145247.1964410-1-hch@lst.de>
	<20210126145247.1964410-9-hch@lst.de>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <3301f2da-60c5-79ca-ab3b-0fe3345f0731@huawei.com>
Date: Fri, 29 Jan 2021 09:04:17 +0800
MIME-Version: 1.0
In-Reply-To: <20210126145247.1964410-9-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Mike Snitzer <snitzer@redhat.com>, linux-mm@kvack.org, dm-devel@redhat.com,
	drbd-dev@lists.linbit.com, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-nilfs@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Coly Li <colyli@suse.de>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [f2fs-dev] [PATCH 08/17] f2fs: remove FAULT_ALLOC_BIO
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

On 2021/1/26 22:52, Christoph Hellwig wrote:
> Sleeping bio allocations do not fail, which means that injecting an error
> into sleeping bio allocations is a little silly.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,

