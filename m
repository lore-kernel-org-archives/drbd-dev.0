Return-Path: <prvs=5036c86fd=Johannes.Thumshirn@wdc.com>
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 472654252F4
	for <drbd-dev@lists.linbit.com>; Fri, 26 May 2023 11:29:45 +0200 (CEST)
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
Date: Fri, 26 May 2023 09:21:58 +0000
Message-ID: <ad5c229c-4c7f-e9ff-3326-477aad226388@wdc.com>
References: <20230526073336.344543-1-mcgrof@kernel.org>
	<20230526073336.344543-5-mcgrof@kernel.org>
In-Reply-To: <20230526073336.344543-5-mcgrof@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <45758A4BDB7BB34A90732E4D3D171535@namprd04.prod.outlook.com>
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
Subject: Re: [Drbd-dev] [PATCH v2 4/5] dm bufio: simplify by using
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

T24gMjYuMDUuMjMgMDk6MzMsIEx1aXMgQ2hhbWJlcmxhaW4gd3JvdGU6DQo+ICAJCSpkYXRhX21v
ZGUgPSBEQVRBX01PREVfR0VUX0ZSRUVfUEFHRVM7DQo+ICAJCXJldHVybiAodm9pZCAqKV9fZ2V0
X2ZyZWVfcGFnZXMoZ2ZwX21hc2ssDQo+IC0JCQkJCQljLT5zZWN0b3JzX3Blcl9ibG9ja19iaXRz
IC0gKFBBR0VfU0hJRlQgLSBTRUNUT1JfU0hJRlQpKTsNCj4gKwkJCQkJCWMtPnNlY3RvcnNfcGVy
X2Jsb2NrX2JpdHMgLSAoUEFHRV9TRUNUT1JTX1NISUZUKSk7DQoNCg0KPiAgCWNhc2UgREFUQV9N
T0RFX0dFVF9GUkVFX1BBR0VTOg0KPiAgCQlmcmVlX3BhZ2VzKCh1bnNpZ25lZCBsb25nKWRhdGEs
DQo+IC0JCQkgICBjLT5zZWN0b3JzX3Blcl9ibG9ja19iaXRzIC0gKFBBR0VfU0hJRlQgLSBTRUNU
T1JfU0hJRlQpKTsNCj4gKwkJCSAgIGMtPnNlY3RvcnNfcGVyX2Jsb2NrX2JpdHMgLSAoUEFHRV9T
RUNUT1JTX1NISUZUKSk7DQoNCg0KVGhlIHBhcmVudGhlc2lzIGFyZSBjb21wbGV0ZWx5IHVubmVl
ZGVkIGluIHRoZSBuZXcgdmVyc2lvbiwNCnBsZWFzZSByZW1vdmUgdGhlbS4NCg==
