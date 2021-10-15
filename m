Return-Path: <konishi.ryusuke@gmail.com>
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
	[209.85.167.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4FF62420FE5
	for <drbd-dev@lists.linbit.com>; Fri, 15 Oct 2021 15:54:45 +0200 (CEST)
Received: by mail-lf1-f46.google.com with SMTP id n8so41896082lfk.6
	for <drbd-dev@lists.linbit.com>; Fri, 15 Oct 2021 06:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211015132643.1621913-1-hch@lst.de>
	<20211015132643.1621913-20-hch@lst.de>
In-Reply-To: <20211015132643.1621913-20-hch@lst.de>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 15 Oct 2021 22:54:32 +0900
Message-ID: <CAKFNMokH0ZU-zxMe3Wm87hZwVgXPv3nRYBx2gXU98GekaeDFRw@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
	Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Song Liu <song@kernel.org>,
	device-mapper development <dm-devel@redhat.com>,
	target-devel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-nilfs <linux-nilfs@vger.kernel.org>,
	linux-scsi@vger.kernel.org, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-ext4@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
	linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	David Sterba <dsterba@suse.com>, Anton Altaparmakov <anton@tuxera.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	linux-ntfs-dev@lists.sourceforge.net, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 19/30] nilfs2: use bdev_nr_bytes instead of
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

On Fri, Oct 15, 2021 at 10:27 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the proper helper to read the block device size.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
