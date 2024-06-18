Return-Path: <chaitanyak@nvidia.com>
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 600A142010D
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2024 04:14:04 +0200 (CEST)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 11/26] block: freeze the queue in queue_attr_store
Date: Tue, 18 Jun 2024 01:41:36 +0000
Message-ID: <d0d47735-ca4d-4744-bb8a-607d59c67315@nvidia.com>
References: <20240617060532.127975-1-hch@lst.de>
	<20240617060532.127975-12-hch@lst.de>
In-Reply-To: <20240617060532.127975-12-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0E393A774C60C469B0101BC1E571406@namprd12.prod.outlook.com>
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

T24gNi8xNi8yNCAyMzowNCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IHF1ZXVlX2F0dHJf
c3RvcmUgdXBkYXRlcyBhdHRyaWJ1dGVzIHVzZWQgdG8gY29udHJvbCBnZW5lcmF0aW5nIEkvTywg
YW5kDQo+IGNhbiBjYXVzZSBtYWxmb3JtZWQgYmlvcyBpZiBjaGFuZ2VkIHdpdGggSS9PIGluIGZs
aWdodC4gIEZyZWV6ZSB0aGUgcXVldWUNCj4gaW4gY29tbW9uIGNvZGUgaW5zdGVhZCBvZiBhZGRp
bmcgaXQgdG8gYWxtb3N0IGV2ZXJ5IGF0dHJpYnV0ZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2No
ZTxidmFuYXNzY2hlQGFjbS5vcmc+DQo+IFJldmlld2VkLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVt
b2FsQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2U8aGFyZUBzdXNl
LmRlPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
