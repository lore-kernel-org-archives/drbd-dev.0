Return-Path: <chaitanyak@nvidia.com>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 088B842094E
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jan 2022 23:46:40 +0100 (CET)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Date: Tue, 18 Jan 2022 22:12:25 +0000
Message-ID: <c4d0db2c-b487-e965-30da-507b30f29a6e@nvidia.com>
References: <20220118071952.1243143-1-hch@lst.de>
	<20220118071952.1243143-16-hch@lst.de>
In-Reply-To: <20220118071952.1243143-16-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E00E6E42D2517540A652FBBB17F3A16F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: Lars, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
	Mike Snitzer <snitzer@redhat.com>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Ellenberg <lars.ellenberg@linbit.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Komarov <almaz.alexandrovich@paragon-software.com>,
	=?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.co>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>, Jack,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	Andrew Morton <akpm@linux-foundation.org>, Konstantin,
	Wang <jinpu.wang@ionos.com>, Pavel Begunkov <asml.silence@gmail.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 15/19] block: pass a block_device and opf to
 bio_alloc_bioset
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

T24gMS8xNy8yMiAxMToxOSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBhc3MgdGhl
IGJsb2NrX2RldmljZSBhbmQgb3BlcmF0aW9uIHRoYXQgd2UgcGxhbiB0byB1c2UgdGhpcyBiaW8g
Zm9yIHRvDQo+IGJpb19hbGxvY19iaW9zZXQgdG8gb3B0aW1pemUgdGhlIGFzc2lnbWVudC4gIE5V
TEwvMCBjYW4gYmUgcGFzc2VkLCBib3RoDQo+IGZvciB0aGUgcGFzc3Rocm91Z2ggY2FzZSBvbiBh
IHJhdyByZXF1ZXN0X3F1ZXVlIGFuZCB0byB0ZW1wb3JhcmlseSBhdm9pZA0KPiByZWZhY3Rvcmlu
ZyBzb21lIG5hc3R5IGNvZGUuDQo+IA0KPiBBbHNvIG1vdmUgdGhlIGdmcF9tYXNrIGFyZ3VtZW50
IGFmdGVyIHRoZSBucl92ZWNzIGFyZ3VtZW50IGZvciBhIG11Y2gNCj4gbW9yZSBsb2dpY2FsIGNh
bGxpbmcgY29udmVudGlvbiBtYXRjaGluZyB3aGF0IG1vc3Qgb2YgdGhlIGtlcm5lbCBkb2VzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQoNCg0K
TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCg0K
