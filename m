Return-Path: <chaitanyak@nvidia.com>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 44DC4420BA9
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jan 2022 23:47:23 +0100 (CET)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Date: Tue, 18 Jan 2022 22:14:17 +0000
Message-ID: <8f26d2c5-2ff3-68b6-c883-567f16bf57f8@nvidia.com>
References: <20220118071952.1243143-1-hch@lst.de>
	<20220118071952.1243143-18-hch@lst.de>
In-Reply-To: <20220118071952.1243143-18-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C34C2F0A08E43545A50616A425CD9E1A@namprd12.prod.outlook.com>
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
Subject: Re: [Drbd-dev] [PATCH 17/19] block: pass a block_device and opf to
	bio_alloc
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
Zm9yIHRvDQo+IGJpb19hbGxvYyB0byBvcHRpbWl6ZSB0aGUgYXNzaWdtZW50LiAgTlVMTC8wIGNh
biBiZSBwYXNzZWQsIGJvdGggZm9yIHRoZQ0KDQoncy9hc3NpZ21lbnQvYXNzaWdubWVudC8nDQoN
Cj4gcGFzc3Rocm91Z2ggY2FzZSBvbiBhIHJhdyByZXF1ZXN0X3F1ZXVlIGFuZCB0byB0ZW1wb3Jh
cmlseSBhdm9pZA0KPiByZWZhY3RvcmluZyBzb21lIG5hc3R5IGNvZGUuDQo+IA0KPiBBbHNvIG1v
dmUgdGhlIGdmcF9tYXNrIGFyZ3VtZW50IGFmdGVyIHRoZSBucl92ZWNzIGFyZ3VtZW50IGZvciBh
IG11Y2gNCj4gbW9yZSBsb2dpY2FsIGNhbGxpbmcgY29udmVudGlvbiBtYXRjaGluZyB3aGF0IG1v
c3Qgb2YgdGhlIGtlcm5lbCBkb2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
