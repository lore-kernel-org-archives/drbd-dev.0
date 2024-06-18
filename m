Return-Path: <chaitanyak@nvidia.com>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BC1EE42032B
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2024 05:12:18 +0200 (CEST)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 02/26] sd: remove sd_is_zoned
Date: Tue, 18 Jun 2024 01:39:16 +0000
Message-ID: <117628c1-7378-4195-89d1-d5df7d3d22b2@nvidia.com>
References: <20240617060532.127975-1-hch@lst.de>
	<20240617060532.127975-3-hch@lst.de>
In-Reply-To: <20240617060532.127975-3-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA6754379EC35C49B5EFA1BCA5963450@namprd12.prod.outlook.com>
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
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

T24gNi8xNi8yNCAyMzowNCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFNpbmNlIGNvbW1p
dCA3NDM3YmI3M2YwODcgKCJibG9jazogcmVtb3ZlIHN1cHBvcnQgZm9yIHRoZSBob3N0IGF3YXJl
IHpvbmUNCj4gbW9kZWwiKSwgb25seSBaQkMgZGV2aWNlcyBleHBvc2UgYSB6b25lZCBhY2Nlc3Mg
bW9kZWwuICBzZF9pc196b25lZCBpcw0KPiB1c2VkIHRvIGNoZWNrIGZvciB0aGF0IGFuZCB0aHVz
IHJldHVybiBmYWxzZSBmb3IgaG9zdCBhd2FyZSBkZXZpY2VzLg0KPg0KPiBSZXBsYWNlIHRoZSBo
ZWxwZXIgd2l0aCB0aGUgc2ltcGxlIG9wZW4gY29kZWQgVFlQRV9aQkMgY2hlY2sgdG8gZml4IHRo
aXMuDQo+DQo+IEZpeGVzOiA3NDM3YmI3M2YwODcgKCJibG9jazogcmVtb3ZlIHN1cHBvcnQgZm9y
IHRoZSBob3N0IGF3YXJlIHpvbmUgbW9kZWwiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGgg
SGVsbHdpZzxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogQmFydCBWYW4gQXNzY2hlPGJ2YW5h
c3NjaGVAYWNtLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IERhbWllbiBMZSBNb2FsPGRsZW1vYWxAa2Vy
bmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZTxoYXJlQHN1c2UuZGU+DQo+
IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
