Return-Path: <song@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 40EB9420FF2
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 23:22:05 +0200 (CEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0E7F61165
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 21:14:45 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id j21so17933679lfe.0
	for <drbd-dev@lists.linbit.com>; Wed, 13 Oct 2021 14:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211013051042.1065752-1-hch@lst.de>
	<20211013051042.1065752-5-hch@lst.de>
	<202110122311.B43459E21@keescook>
In-Reply-To: <202110122311.B43459E21@keescook>
From: Song Liu <song@kernel.org>
Date: Wed, 13 Oct 2021 14:14:32 -0700
Message-ID: <CAPhsuW6MFRmKfpUxLL3=TRAgNTuTMFySc=_-NA7YOWDAvYAxyQ@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
	Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	linux-mtd@lists.infradead.org, reiserfs-devel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com,
	linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-ext4@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Coly Li <colyli@suse.de>, linux-raid <linux-raid@vger.kernel.org>,
	linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	linux-ntfs-dev@lists.sourceforge.net, Jan Kara <jack@suse.com>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 04/29] md: use bdev_nr_sectors instead of
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

On Tue, Oct 12, 2021 at 11:12 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 13, 2021 at 07:10:17AM +0200, Christoph Hellwig wrote:
> > Use the proper helper to read the block device size.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> I think it might make sense, as you suggest earlier, to add a "bytes"
> helper. This is the first user in the series needing:
>
>         bdev_nr_sectors(...bdev) << SECTOR_SHIFT
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Acked-by: Song Liu <song@kernel.org>
