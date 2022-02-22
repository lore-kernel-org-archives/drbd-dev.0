Return-Path: <chaitanyak@nvidia.com>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
	(mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0333F421787
	for <drbd-dev@lists.linbit.com>; Tue, 22 Feb 2022 17:41:17 +0100 (CET)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Date: Tue, 22 Feb 2022 16:25:07 +0000
Message-ID: <9f289490-f8f9-d8da-15d5-f2eaa81bd4df@nvidia.com>
References: <20220222155156.597597-1-hch@lst.de>
In-Reply-To: <20220222155156.597597-1-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8544CB4F6678C24E9021B7BB2E8D7853@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: Chris Zankel <chris@zankel.net>, Sanders <justin@coraid.com>, Justin,
	Minchan Kim <minchan@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	"linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Denis Efremov <efremov@linux.com>, Coly Li <colyli@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Dan Williams <dan.j.williams@intel.com>, Nitin Gupta <ngupta@vflare.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] remove opencoded kmap of bio_vecs
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

T24gMi8yMi8yMiAwNzo1MSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEhpIGFsbCwNCj4g
DQo+IHRoaXMgc2VyaWVzIHJlcGxhY2VzIHZhcmlvdXMgb3BlbiBjb2RlZCBrbWFwcyBvZiBiaW9f
dmVjcyB3aXRoIGhpZ2hlcg0KPiBsZXZlbCBoZWxwZXJzIHRoYXQgdXNlIGttYXBfbG9jYWxfcGFn
ZSB1bmRlcm5lYXRoLg0KPiANCg0KDQp0aGlzIHNlcmllcyBsb29rcyBnb29kIHRvIG1lLCBsb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KDQo=
