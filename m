Return-Path: <snitzer@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 58FFB420FF4
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 18:49:23 +0200 (CEST)
Received: by mail-qt1-f197.google.com with SMTP id
	t9-20020a05622a180900b002a71f83a1cdso2478259qtc.17
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 09:43:14 -0700 (PDT)
Date: Wed, 13 Oct 2021 12:43:12 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <YWcMoCZxfpUzKZQ+@redhat.com>
References: <20211013051042.1065752-1-hch@lst.de>
	<20211013051042.1065752-4-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20211013051042.1065752-4-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	linux-mtd@lists.infradead.org, reiserfs-devel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-nilfs@vger.kernel.org,
	linux-scsi@vger.kernel.org, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-ext4@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
	linux-nfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	linux-ntfs-dev@lists.sourceforge.net, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 03/29] dm: use bdev_nr_sectors instead of
	open coding it
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

On Wed, Oct 13 2021 at  1:10P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

