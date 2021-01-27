Return-Path: <axboe@kernel.dk>
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
	[209.85.214.173])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 02CA34202D8
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2021 17:52:15 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id u15so1371993plf.1
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2021 08:52:15 -0800 (PST)
To: Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
References: <20210126145247.1964410-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <53e9b2e0-7169-f2fe-3c33-5f8a28cbd01b@kernel.dk>
Date: Wed, 27 Jan 2021 09:52:10 -0700
MIME-Version: 1.0
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Mike Snitzer <snitzer@redhat.com>, linux-mm@kvack.org, dm-devel@redhat.com,
	drbd-dev@lists.linbit.com, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-nilfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Chao Yu <chao@kernel.org>, linux-nfs@vger.kernel.org,
	Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, linux-block@vger.kernel.org,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] misc bio allocation cleanups
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

On 1/26/21 7:52 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series contains various cleanups for how bios are allocated or
> initialized plus related fallout.

Applied, thanks.

-- 
Jens Axboe

