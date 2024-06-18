Return-Path: <chaitanyak@nvidia.com>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
	(mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4F9124200BE
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2024 04:16:37 +0200 (CEST)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 12/26] block: remove blk_flush_policy
Date: Tue, 18 Jun 2024 01:42:13 +0000
Message-ID: <1060c01c-febc-40d0-95ad-0be879c05545@nvidia.com>
References: <20240617060532.127975-1-hch@lst.de>
	<20240617060532.127975-13-hch@lst.de>
In-Reply-To: <20240617060532.127975-13-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C038F52BEFB8F419B64CC739CDBAAE2@namprd12.prod.outlook.com>
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
	Bart Van Assche <bvanassche@acm.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Yu Kuai <yukuai3@huawei.com>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	"nbd@other.debian.org" <nbd@other.debian.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
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

T24gNi8xNi8yNCAyMzowNCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEZvbGQgYmxrX2Zs
dXNoX3BvbGljeSBpbnRvIHRoZSBvbmx5IGNhbGxlciB0byBwcmVwYXJlIGZvciBwZW5kaW5nIGNo
YW5nZXMNCj4gdG8gaXQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFj
bS5vcmc+DQo+IFJldmlld2VkLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3Jn
Pg0KPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0K
PiAgIA0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
