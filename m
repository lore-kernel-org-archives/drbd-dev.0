Return-Path: <prvs=8854759ac=Johannes.Thumshirn@wdc.com>
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 084074208FB
	for <drbd-dev@lists.linbit.com>; Tue, 11 Jun 2024 12:57:44 +0200 (CEST)
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 01/26] sd: fix sd_is_zoned
Date: Tue, 11 Jun 2024 10:50:30 +0000
Message-ID: <b9b02f22-6835-4a9c-a1b7-790fa6c0afb5@wdc.com>
References: <20240611051929.513387-1-hch@lst.de>
	<20240611051929.513387-2-hch@lst.de>
In-Reply-To: <20240611051929.513387-2-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <050DDD6DB6C2124FA3F8ED9DC37A34A4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: Lars, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "Michael
	S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Song Liu <song@kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Yu Kuai <yukuai3@huawei.com>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	"nbd@other.debian.org" <nbd@other.debian.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Martin K.
	Petersen" <martin.petersen@oracle.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Ellenberg <lars.ellenberg@linbit.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	=?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>
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

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
