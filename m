Return-Path: <chaitanyak@nvidia.com>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 64F29422112
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2022 20:48:35 +0100 (CET)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: =?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Date: Wed, 9 Nov 2022 19:48:33 +0000
Message-ID: <709b545c-71a3-4b2b-8fd1-30c738e61743@nvidia.com>
References: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
	<20221109133453.51652-2-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221109133453.51652-2-christoph.boehmwalder@linbit.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <933314C9AC091C44A4AC3A0DC03E55F4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 1/3] drbd: use blk_queue_max_discard_sectors
	helper
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

T24gMTEvOS8yMiAwNTozNCwgQ2hyaXN0b3BoIELDtmhtd2FsZGVyIHdyb3RlOg0KPiBXZSBjdXJy
ZW50bHkgb25seSBzZXQgcS0+bGltaXRzLm1heF9kaXNjYXJkX3NlY3RvcnMsIGJ1dCB0aGF0IGlz
IG5vdA0KPiBlbm91Z2guIEFub3RoZXIgZmllbGQsIG1heF9od19kaXNjYXJkX3NlY3RvcnMsIHdh
cyBpbnRyb2R1Y2VkIGluDQo+IGNvbW1pdCAwMDM0YWYwMzY1NTQgKCJibG9jazogbWFrZSAvc3lz
L2Jsb2NrLzxkZXY+L3F1ZXVlL2Rpc2NhcmRfbWF4X2J5dGVzDQo+IHdyaXRlYWJsZSIpLg0KPiAN
Cj4gVGhlIGRpZmZlcmVuY2UgaXMgdGhhdCBtYXhfZGlzY2FyZF9zZWN0b3JzIGNhbiBiZSBjaGFu
Z2VkIGZyb20gdXNlcg0KPiBzcGFjZSB2aWEgc3lzZnMsIHdoaWxlIG1heF9od19kaXNjYXJkX3Nl
Y3RvcnMgaXMgdGhlICJoYXJkd2FyZSIgdXBwZXINCj4gbGltaXQuDQo+IA0KPiBTbyB1c2UgdGhp
cyBoZWxwZXIsIHdoaWNoIHNldHMgYm90aC4NCj4gDQo+IFRoaXMgaXMgYWxzbyBhIGZpeHVwIGZv
ciBjb21taXQgOTk4ZTljYmNkNjE1ICgiZHJiZDogY2xlYW51cA0KPiBkZWNpZGVfb25fZGlzY2Fy
ZF9zdXBwb3J0Iik6IGlmIGRpc2NhcmRzIGFyZSBub3Qgc3VwcG9ydGVkLCB0aGF0IGRvZXMNCj4g
bm90IG5lY2Vzc2FyaWx5IG1lYW4gd2UgYWxzbyB3YW50IHRvIGRpc2FibGUgd3JpdGVfemVyb2Vz
Lg0KPiANCj4gRml4ZXM6IDk5OGU5Y2JjZDYxNSAoImRyYmQ6IGNsZWFudXAgZGVjaWRlX29uX2Rp
c2NhcmRfc3VwcG9ydCIpDQo+IFJldmlld2VkLWJ5OiBKb2VsIENvbGxlZGdlIDxqb2VsLmNvbGxl
ZGdlQGxpbmJpdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBCw7ZobXdhbGRlciA8
Y2hyaXN0b3BoLmJvZWhtd2FsZGVyQGxpbmJpdC5jb20+DQo+IC0tLQ0KDQpVc2luZyBoZWxwZXIg
aXMgYWJzb2x1dGVseSByaWdodCB3YXkgb2Ygc2V0dGluZyB1cCBkaXNjYXJkDQp2YWx1ZXMuLi4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==
