Return-Path: <prvs=653b9936d=Chaitanya.Kulkarni@wdc.com>
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 23A834202F8
	for <drbd-dev@lists.linbit.com>; Tue, 26 Jan 2021 20:15:06 +0100 (CET)
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Song Liu
	<song@kernel.org>
Date: Tue, 26 Jan 2021 19:15:02 +0000
Message-ID: <BYAPR04MB4965E6615D7173005E4C634586BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210126145247.1964410-1-hch@lst.de>
	<20210126145247.1964410-6-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>, Mike Snitzer <snitzer@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>, Ryusuke,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
	Philipp, Chao Yu <chao@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Konishi <konishi.ryusuke@gmail.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Reisner <philipp.reisner@linbit.com>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Drbd-dev] [PATCH 05/17] block: use an on-stack bio in
	blkdev_issue_flush
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

On 1/26/21 7:07 AM, Christoph Hellwig wrote:=0A=
> There is no point in allocating memory for a synchronous flush.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
True, looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
