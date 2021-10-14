Return-Path: <dave.kleikamp@oracle.com>
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
	[205.220.165.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7F5AE4202B8
	for <drbd-dev@lists.linbit.com>; Thu, 14 Oct 2021 16:55:09 +0200 (CEST)
Message-ID: <a5eb3c18-deb2-6539-cc24-57e6d5d3500c@oracle.com>
Date: Thu, 14 Oct 2021 08:13:59 -0500
Content-Language: en-US
To: Anton Altaparmakov <anton@tuxera.com>, Christoph Hellwig <hch@lst.de>
References: <20211013051042.1065752-1-hch@lst.de>
	<20211014062844.GA25448@lst.de>
	<3AB8052D-DD45-478B-85F2-BFBEC1C7E9DF@tuxera.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <3AB8052D-DD45-478B-85F2-BFBEC1C7E9DF@tuxera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Cc: "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>, Mike Snitzer <snitzer@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Song Liu <song@kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	David Sterba <dsterba@suse.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jens Axboe <axboe@kernel.dk>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, "linux-ntfs-dev@lists.sourceforge.net"
	<linux-ntfs-dev@lists.sourceforge.net>, Jan Kara <jack@suse.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Drbd-dev] don't use ->bd_inode to access the block device size
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

On 10/14/21 4:32AM, Anton Altaparmakov wrote:
> Hi Christoph,
> 
>> On 14 Oct 2021, at 07:28, Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Wed, Oct 13, 2021 at 07:10:13AM +0200, Christoph Hellwig wrote:
>>> I wondered about adding a helper for looking at the size in byte units
>>> to avoid the SECTOR_SHIFT shifts in various places.  But given that
>>> I could not come up with a good name and block devices fundamentally
>>> work in sector size granularity I decided against that.
>>
>> So it seems like the biggest review feedback is that we should have
>> such a helper.  I think the bdev_size name is the worst as size does
>> not imply a particular unit.  bdev_nr_bytes is a little better but I'm
>> not too happy.  Any other suggestions or strong opinions?
> 
> bdev_byte_size() would seem to address your concerns?
> 
> bdev_nr_bytes() would work though - it is analogous to bdev_nr_sectors() after all.
> 
> No strong opinion here but I do agree with you that bdev_size() is a bad choice for sure.  It is bound to cause bugs down the line when people forget what unit it is in.

I don't really mind bdev_size since it's analogous to i_size, but 
bdev_nr_bytes seems good to me.

Shaggy

> Best regards,
> 
> 	Anton
> 
