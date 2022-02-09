Return-Path: <chaitanyak@nvidia.com>
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam08on2084.outbound.protection.outlook.com [40.107.101.84])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7B1AE4206C7
	for <drbd-dev@lists.linbit.com>; Wed,  9 Feb 2022 11:25:40 +0100 (CET)
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
Date: Wed, 9 Feb 2022 08:46:48 +0000
Message-ID: <7205acb7-8973-ffef-9e74-3477370aad4b@nvidia.com>
References: <20220209082828.2629273-1-hch@lst.de>
	<20220209082828.2629273-8-hch@lst.de>
In-Reply-To: <20220209082828.2629273-8-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <180381D39E6E5C498FD0D7B1DAEA46CC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 7/7] block: remove REQ_OP_WRITE_SAME support
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

T24gMi85LzIyIDEyOjI4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gTm8gbW9yZSB1
c2VycyBvZiBSRVFfT1BfV1JJVEVfU0FNRSBvciBkcml2ZXJzIGltcGxlbWVudGluZyBpdCBhcmUg
bGVmdCwNCj4gc28gcmVtb3ZlIHRoZSBpbmZyYXN0cnVjdHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
