Return-Path: <prvs=5036c86fd=Johannes.Thumshirn@wdc.com>
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 146B9420151
	for <drbd-dev@lists.linbit.com>; Fri, 26 May 2023 11:28:04 +0200 (CEST)
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Luis Chamberlain <mcgrof@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"agk@redhat.com" <agk@redhat.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"christoph.boehmwalder@linbit.com" <christoph.boehmwalder@linbit.com>,
	"hch@infradead.org" <hch@infradead.org>, "djwong@kernel.org"
	<djwong@kernel.org>, "minchan@kernel.org" <minchan@kernel.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>
Date: Fri, 26 May 2023 09:26:48 +0000
Message-ID: <c156b1e4-8a8e-e296-05f4-0ffd75903380@wdc.com>
References: <20230526073336.344543-1-mcgrof@kernel.org>
In-Reply-To: <20230526073336.344543-1-mcgrof@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <811ABC632CFA204FA57A834FE3BCAB71@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: "p.raghav@samsung.com" <p.raghav@samsung.com>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"rohan.puri@samsung.com" <rohan.puri@samsung.com>,
	"da.gomez@samsung.com" <da.gomez@samsung.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"willy@infradead.org" <willy@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>, "hare@suse.de" <hare@suse.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"rpuri.linux@gmail.com" <rpuri.linux@gmail.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH v2 0/5] block: simplify with
	PAGE_SECTORS_SHIFT
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

T24gMjYuMDUuMjMgMDk6MzMsIEx1aXMgQ2hhbWJlcmxhaW4gd3JvdGU6DQo+IEEgYml0IG9mIGJs
b2NrIGRyaXZlcnMgaGF2ZSB0aGVpciBvd24gaW5jYW50YXRpb25zIHdpdGgNCj4gUEFHRV9TSElG
VCAtIFNFQ1RPUl9TSElGVC4gSnVzdCBzaW1wbGZ5IGFuZCB1c2UgUEFHRV9TRUNUT1JTX1NISUZU
DQo+IGFsbCBvdmVyLg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+IEJhc2VkIG9uIGxpbnV4LW5l
eHQgbmV4dC0yMDIzMDUyNS4NCj4gDQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IA0KPiAgbyBrZWVw
IGlvbWFwIG1hdGggdmlzaWJseSBzaW1wbGUNCj4gIG8gQWRkIHRhZ3MgZm9yIFJldmlld3MvYWNr
cw0KPiAgbyByZWJhc2Ugb250byBuZXh0LTIwMjMwNTI1DQo+IA0KPiBMdWlzIENoYW1iZXJsYWlu
ICg1KToNCj4gICBibG9jazogYW5ub3RhdGUgYmRldl9kaXNrX2NoYW5nZWQoKSBkZXByZWNhdGlv
biB3aXRoIGEgc3ltYm9sDQo+ICAgICBuYW1lc3BhY2UNCj4gICBkcmJkOiB1c2UgUEFHRV9TRUNU
T1JTX1NISUZUIGFuZCBQQUdFX1NFQ1RPUlMNCj4gICBpb21hcDogc2ltcGxpZnkgaW9tYXBfaW5p
dCgpIHdpdGggUEFHRV9TRUNUT1JTDQo+ICAgZG0gYnVmaW86IHNpbXBsaWZ5IGJ5IHVzaW5nIFBB
R0VfU0VDVE9SU19TSElGVA0KPiAgIHpyYW06IHVzZSBnZW5lcmljIFBBR0VfU0VDVE9SUyBhbmQg
UEFHRV9TRUNUT1JTX1NISUZUDQo+IA0KPiAgYmxvY2svcGFydGl0aW9ucy9jb3JlLmMgICAgICAg
ICAgfCAgNiArLS0tLS0NCj4gIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX2JpdG1hcC5jIHwgIDQg
KystLQ0KPiAgZHJpdmVycy9ibG9jay9sb29wLmMgICAgICAgICAgICAgfCAgMiArKw0KPiAgZHJp
dmVycy9ibG9jay96cmFtL3pyYW1fZHJ2LmMgICAgfCAxMiArKysrKystLS0tLS0NCj4gIGRyaXZl
cnMvYmxvY2svenJhbS96cmFtX2Rydi5oICAgIHwgIDIgLS0NCj4gIGRyaXZlcnMvbWQvZG0tYnVm
aW8uYyAgICAgICAgICAgIHwgIDQgKystLQ0KPiAgZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2RfZ2Vu
aGQuYyAgfCAgMiArKw0KPiAgZnMvaW9tYXAvYnVmZmVyZWQtaW8uYyAgICAgICAgICAgfCAgMiAr
LQ0KPiAgOCBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkN
Cj4gDQoNCkhleSBMdWlzLA0KSSd2ZSBmb3VuZCBhbm90aGVyIG9uZSBpbiBzZF96YmNfcmV2YWxp
ZGF0ZV96b25lcygpOg0KDQoJbWF4X2FwcGVuZCA9IG1pbl90KHUzMiwgbG9naWNhbF90b19zZWN0
b3JzKHNka3AtPmRldmljZSwgem9uZV9ibG9ja3MpLA0KCQkJICAgcS0+bGltaXRzLm1heF9zZWdt
ZW50cyA8PCAoUEFHRV9TSElGVCAtIDkpKTsNCg0KTWluZCB0YWtpbmcgY2FyZSBvZiBpdCBpbiB0
aGUgbmV4dCByb3VuZCBhcyB3ZWxsPw0KDQpUaGFua3MsDQoJSm9oYW5uZXMNCg==
