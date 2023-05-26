Return-Path: <prvs=5036c86fd=Johannes.Thumshirn@wdc.com>
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 817394252F9
	for <drbd-dev@lists.linbit.com>; Fri, 26 May 2023 11:34:33 +0200 (CEST)
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
Date: Fri, 26 May 2023 09:24:14 +0000
Message-ID: <597dab55-737f-73f1-3505-1e0c59d52d80@wdc.com>
References: <20230526073336.344543-1-mcgrof@kernel.org>
	<20230526073336.344543-6-mcgrof@kernel.org>
In-Reply-To: <20230526073336.344543-6-mcgrof@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <86E8AD8D2F16CF4483A7DC09EEFBDFCF@namprd04.prod.outlook.com>
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
Subject: Re: [Drbd-dev] [PATCH v2 5/5] zram: use generic PAGE_SECTORS and
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

T24gMjYuMDUuMjMgMDk6MzQsIEx1aXMgQ2hhbWJlcmxhaW4gd3JvdGU6DQo+ICsJdTMyIGluZGV4
ID0gYmlvLT5iaV9pdGVyLmJpX3NlY3RvciA+PiBQQUdFX1NFQ1RPUlNfU0hJRlQ7DQo+ICsJdTMy
IG9mZnNldCA9IChiaW8tPmJpX2l0ZXIuYmlfc2VjdG9yICYgKFBBR0VfU0VDVE9SUyAtIDEpKSA8
PA0KPiAgCQkJU0VDVE9SX1NISUZUOw0KDQooUEFHRV9TRUNUT1JTIC0gMSkgaXMgU0VDVE9SX01B
U0ssIHBsZWFzZSB1c2UgdGhpcy4NCg0KVGhhbmtzLA0KCUpvaGFubmVzDQo=
