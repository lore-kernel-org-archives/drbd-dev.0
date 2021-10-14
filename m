Return-Path: <antlists@youngman.org.uk>
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0B53F42002A
	for <drbd-dev@lists.linbit.com>; Thu, 14 Oct 2021 21:10:10 +0200 (CEST)
To: Kees Cook <keescook@chromium.org>, Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20211013051042.1065752-1-hch@lst.de>
	<20211014062844.GA25448@lst.de>
	<3AB8052D-DD45-478B-85F2-BFBEC1C7E9DF@tuxera.com>
	<a5eb3c18-deb2-6539-cc24-57e6d5d3500c@oracle.com>
	<202110140813.44C95229@keescook>
From: Wol <antlists@youngman.org.uk>
Message-ID: <e3d2f358-be1a-3413-fdb8-2e86718cde3e@youngman.org.uk>
Date: Thu, 14 Oct 2021 16:35:49 +0100
MIME-Version: 1.0
In-Reply-To: <202110140813.44C95229@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Cc: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>,
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-ntfs-dev@lists.sourceforge.net"
	<linux-ntfs-dev@lists.sourceforge.net>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
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

On 14/10/2021 16:14, Kees Cook wrote:
>> I don't really mind bdev_size since it's analogous to i_size, but
>> bdev_nr_bytes seems good to me.

> I much prefer bdev_nr_bytes(), as "size" has no units.

Does it mean size IN bytes, or size OF A byte? :-)

Cheers,
Wol
