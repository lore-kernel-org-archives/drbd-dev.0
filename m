Return-Path: <josef@toxicpanda.com>
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
	[209.85.160.170])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C74974207E4
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jan 2021 16:02:05 +0100 (CET)
Received: by mail-qt1-f170.google.com with SMTP id h19so13798850qtq.13
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jan 2021 07:02:05 -0800 (PST)
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	cluster-devel@redhat.com
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
From: Josef Bacik <josef@toxicpanda.com>
Message-ID: <6eab7373-3c7f-fccf-8a6f-b02519258d23@toxicpanda.com>
Date: Tue, 19 Jan 2021 10:00:59 -0500
MIME-Version: 1.0
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net, snitzer@redhat.com,
	gustavo@embeddedor.com, clm@fb.com, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, hch@lst.de, agk@redhat.com,
	naohiro.aota@wdc.com, sagi@grimberg.me, darrick.wong@oracle.com,
	osandov@fb.com, kent.overstreet@gmail.com, efremov@linux.com,
	colyli@suse.de, tj@kernel.org, viro@zeniv.linux.org.uk,
	dsterba@suse.com, bvanassche@acm.org, agruenba@redhat.com,
	axboe@kernel.dk, damien.lemoal@wdc.com, tytso@mit.edu,
	martin.petersen@oracle.com, song@kernel.org,
	philipp.reisner@linbit.com, jefflexu@linux.alibaba.com,
	rpeterso@redhat.com, lars.ellenberg@linbit.com, jth@kernel.org,
	asml.silence@gmail.com
Subject: Re: [Drbd-dev] [RFC PATCH 00/37] block: introduce bio_init_fields()
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

On 1/19/21 12:05 AM, Chaitanya Kulkarni wrote:
> Hi,
> 
> This is a *compile only RFC* which adds a generic helper to initialize
> the various fields of the bio that is repeated all the places in
> file-systems, block layer, and drivers.
> 
> The new helper allows callers to initialize various members such as
> bdev, sector, private, end io callback, io priority, and write hints.
> 
> The objective of this RFC is to only start a discussion, this it not
> completely tested at all.

It would help to know what you're trying to accomplish here.  I'd echo Mike's 
comments about how it makes it annoying to update things in the future.  In 
addition, there's so many fields that I'm not going to remember what each one is 
without having to look it up, which makes it annoying to use and to review.  If 
it's simply to make sure fields are initialized then you could add debug sanity 
checks to submit_bio().  If it's to clean up duplication, well I'd argue that 
the duplication is much clearer than positional arguments in a giant function 
call.  If you are wanting to change a particular part of the bio to be 
initialized properly, like Dennis's work to make sure the bi_blkg was 
initialized at bi_bdev set time, then a more targeted patch series with a 
specific intent will be more useful and more successful.  Thanks,

Josef
