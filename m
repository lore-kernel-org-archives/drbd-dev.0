Return-Path: <chaitanyak@nvidia.com>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
	(mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 54DF84205EC
	for <drbd-dev@lists.linbit.com>; Wed,  9 Feb 2022 10:16:57 +0100 (CET)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"haris.iqbal@ionos.com" <haris.iqbal@ionos.com>, "jinpu.wang@ionos.com"
	<jinpu.wang@ionos.com>, "manoj@linux.ibm.com" <manoj@linux.ibm.com>,
	"mrochs@linux.ibm.com" <mrochs@linux.ibm.com>, "ukrishn@linux.ibm.com"
	<ukrishn@linux.ibm.com>
Date: Wed, 9 Feb 2022 08:43:30 +0000
Message-ID: <eea79469-a9d7-b80f-ef72-da9b4f4ecfff@nvidia.com>
References: <20220209082828.2629273-1-hch@lst.de>
	<20220209082828.2629273-2-hch@lst.de>
In-Reply-To: <20220209082828.2629273-2-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB74BD47A71E634E956120B732D5F90A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 1/7] cxlflash: query write_zeroes limit for
	zeroing
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

T24gMi85LzIyIDEyOjI4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gVGhlIHdyaXRl
X3NhbWUgYW5kIHdyaXRlX3plcm9lcyBsaW1pdHMgZm9yIFNDU0kgYXJlIGVmZmVjdGl2ZWx5IHRo
ZQ0KPiBzYW1lLCBzbyB0aGUgY3VycmVudCBjb2RlIHdvcmtzIGp1c3QgZmluZS4gIEJ1dCB3ZSBw
bGFuIHRvIHJlbW92ZQ0KPiBSRVFfT1BfV1JJVEVfU0FNRSBzdXBwb3J0LCBzbyBzd2l0Y2ggdG8g
cXVlcmluZyB0aGUgd3JpdGUgemVyb2VzDQo+IGxpbWl0IGZvciBhIHplcm9pbmcgV1JJVEUgU0FN
RSBvcGVyYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEg
S3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQo=
