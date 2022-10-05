Return-Path: <chaitanyak@nvidia.com>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 57EC7420668
	for <drbd-dev@lists.linbit.com>; Wed,  5 Oct 2022 19:24:25 +0200 (CEST)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: =?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?=
	<christoph.boehmwalder@linbit.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Date: Wed, 5 Oct 2022 17:24:22 +0000
Message-ID: <1e2cbfd0-6136-df9e-58fb-60f1375b2e79@nvidia.com>
References: <20221005050027.39591-1-kch@nvidia.com>
	<20221005050027.39591-6-kch@nvidia.com>
	<e23e94f8-13ad-4a10-62de-33e63a62831f@linbit.com>
In-Reply-To: <e23e94f8-13ad-4a10-62de-33e63a62831f@linbit.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FBCCCB66932BD4F8A146135657B57AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
	"vigneshr@ti.com" <vigneshr@ti.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
	"tim@cyberelk.net" <tim@cyberelk.net>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"richard@nod.at" <richard@nod.at>,
	"damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"ogeert@linux-m68k.org" <ogeert@linux-m68k.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"efremov@linux.com" <efremov@linux.com>,
	"nbd@other.debian.org" <nbd@other.debian.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
	"hare@suse.de" <hare@suse.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>
Subject: Re: [Drbd-dev] [RFC PATCH 05/18] drbd: use init disk helper
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

DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfbWFpbi5jIGIvZHJpdmVy
cy9ibG9jay9kcmJkL2RyYmRfbWFpbi5jDQo+PiBpbmRleCBmM2U0ZGIxNmZkMDcuLjU4ZmFlMTIy
ZGUxNiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmxvY2svZHJiZC9kcmJkX21haW4uYw0KPj4g
KysrIGIvZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfbWFpbi5jDQo+PiBAQCAtMjcwNiwxMyArMjcw
Niw5IEBAIGVudW0gZHJiZF9yZXRfY29kZSBkcmJkX2NyZWF0ZV9kZXZpY2Uoc3RydWN0IGRyYmRf
Y29uZmlnX2NvbnRleHQgKmFkbV9jdHgsIHVuc2lnDQo+PiAgIA0KPj4gICAJc2V0X2Rpc2tfcm8o
ZGlzaywgdHJ1ZSk7DQo+PiAgIA0KPj4gLQlkaXNrLT5tYWpvciA9IERSQkRfTUFKT1I7DQo+PiAt
CWRpc2stPmZpcnN0X21pbm9yID0gbWlub3I7DQo+PiAtCWRpc2stPm1pbm9ycyA9IDE7DQo+PiAt
CWRpc2stPmZvcHMgPSAmZHJiZF9vcHM7DQo+PiAgIAlkaXNrLT5mbGFncyB8PSBHRU5IRF9GTF9O
T19QQVJUOw0KPj4gICAJc3ByaW50ZihkaXNrLT5kaXNrX25hbWUsICJkcmJkJWQiLCBtaW5vcik7
DQo+PiAtCWRpc2stPnByaXZhdGVfZGF0YSA9IGRldmljZTsNCj4+ICsJaW5pdF9kaXNrKGRpc2ss
IERSQkRfTUFKT1IsIG1pbm9yLCAxLCAwLCBkZXZpY2UsICZkcmJkX29wcyk7DQo+PiAgIA0KPj4g
ICAJYmxrX3F1ZXVlX2ZsYWdfc2V0KFFVRVVFX0ZMQUdfU1RBQkxFX1dSSVRFUywgZGlzay0+cXVl
dWUpOw0KPj4gICAJYmxrX3F1ZXVlX3dyaXRlX2NhY2hlKGRpc2stPnF1ZXVlLCB0cnVlLCB0cnVl
KTsNCj4gDQo+IFRoaXMgbm93IGRvZXMgYSBzZXRfY2FwYWNpdHkoLi4uLCAwKSwgd2hpY2ggaXQg
ZGlkIG5vdCBkbyBiZWZvcmUuDQo+IEknbSBndWVzc2luZyB0aGlzIGRvZXMgbm90IGhhdmUgYW55
IHNpZGUgZWZmZWN0cyBhcyB0aGUgY2FwYWNpdHkgc2hvdWxkDQo+IGFscmVhZHkgYmUgaW5pdGlh
bGl6ZWQgdG8gMD8gRG8geW91IGtub3cgdGhpcyBmb3Igc3VyZT8NCj4gDQoNCkkgdGhpbmsgSSds
bCBtb3ZlICB0aGUgY2FsbCB0byBzZXRfY2FwY2l0eSBvdXQgb2YgdGhlIGNhbGxlciwNCldpbGwg
cmVzZW5kIHRoZSBzZXJpZXMgc2hvcnRseS4NCg0KLWNrDQoNCg==
