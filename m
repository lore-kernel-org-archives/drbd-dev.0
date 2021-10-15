Return-Path: <anton@tuxera.com>
Received: from mgw-01.mpynet.fi (mgw-01.mpynet.fi [82.197.21.90])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 90B40421002
	for <drbd-dev@lists.linbit.com>; Fri, 15 Oct 2021 16:37:51 +0200 (CEST)
From: Anton Altaparmakov <anton@tuxera.com>
To: Christoph Hellwig <hch@lst.de>
Date: Fri, 15 Oct 2021 14:37:41 +0000
Message-ID: <7C4AC4BD-B62D-41B3-AAF7-46125D1A1146@tuxera.com>
References: <20211015132643.1621913-1-hch@lst.de>
	<20211015132643.1621913-3-hch@lst.de>
In-Reply-To: <20211015132643.1621913-3-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA141EBD26CA2142955225C1A7459553@ex13.tuxera.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: Dave Kleikamp <shaggy@kernel.org>, "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>, Mike Snitzer <snitzer@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Song Liu <song@kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	David Sterba <dsterba@suse.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, "linux-ntfs-dev@lists.sourceforge.net"
	<linux-ntfs-dev@lists.sourceforge.net>, Jan Kara <jack@suse.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Drbd-dev] [PATCH 02/30] block: add a bdev_nr_bytes helper
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

Hi Christoph,

> On 15 Oct 2021, at 14:26, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Add a helpe to query the size of a block device in bytes.  This
> will be used to remove open coded access to ->bd_inode.

Matthew already pointed out the return type for bdev_nr_bytes() but also yo=
ur commit message has a typo: "Add a helpe" -> "Add a helper".

Best regards,

	Anton

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> include/linux/genhd.h | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 082a3e5fd8fa1..f67db3c5a04b3 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -235,9 +235,14 @@ static inline sector_t get_start_sect(struct block_d=
evice *bdev)
> 	return bdev->bd_start_sect;
> }
>=20
> +static inline sector_t bdev_nr_bytes(struct block_device *bdev)
> +{
> +	return i_size_read(bdev->bd_inode);
> +}
> +
> static inline sector_t bdev_nr_sectors(struct block_device *bdev)
> {
> -	return i_size_read(bdev->bd_inode) >> 9;
> +	return bdev_nr_bytes(bdev) >> SECTOR_SHIFT;
> }
>=20
> static inline sector_t get_capacity(struct gendisk *disk)
> --=20
> 2.30.2
>=20

