Return-Path: <chaitanyak@nvidia.com>
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
	(mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 02873420FCD
	for <drbd-dev@lists.linbit.com>; Fri, 15 Apr 2022 08:21:36 +0200 (CEST)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Date: Fri, 15 Apr 2022 05:47:45 +0000
Message-ID: <0bf7bda0-0c19-7186-8492-ad894456d98d@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
	<20220415045258.199825-25-hch@lst.de>
In-Reply-To: <20220415045258.199825-25-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B35E75958048F04C98F125EEE4A4B3F7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>,
	=?utf-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.ibm.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"cluster-devel@redhat.com" <cluster-devel@redhat.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	David Sterba <dsterba@suse.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	Coly Li <colyli@suse.de>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Drbd-dev] [PATCH 24/27] block: remove QUEUE_FLAG_DISCARD
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

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEp1c3QgdXNlIGEg
bm9uLXplcm8gbWF4X2Rpc2NhcmRfc2VjdG9ycyBhcyBhbiBpbmRpY2F0b3IgZm9yIGRpc2NhcmQN
Cj4gc3VwcG9ydCwgc2ltaWxhciB0byB3aGF0IGlzIGRvbmUgZm9yIHdyaXRlIHplcm9lcy4NCj4g
DQo+IFRoZSBvbmx5IHBsYWNlcyB3aGVyZSBuZWVkcyBzcGVjaWFsIGF0dGVudGlvbiBpcyB0aGUg
UkFJRDUgZHJpdmVyLA0KPiB3aGljaCBtdXN0IGNsZWFyIGRpc2NhcmQgc3VwcG9ydCBmb3Igc2Vj
dXJpdHkgcmVhc29ucyBieSBkZWZhdWx0LA0KPiBldmVuIGlmIHRoZSBkZWZhdWx0IHN0YWNraW5n
IHJ1bGVzIHdvdWxkIGFsbG93IGZvciBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogTWFydGluIEsuIFBldGVyc2Vu
IDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4NCj4gQWNrZWQtYnk6IENocmlzdG9waCBCw7Zo
bXdhbGRlciA8Y2hyaXN0b3BoLmJvZWhtd2FsZGVyQGxpbmJpdC5jb20+IFtkcmJkXQ0KPiBBY2tl
ZC1ieTogSmFuIEjDtnBwbmVyIDxob2VwcG5lckBsaW51eC5pYm0uY29tPiBbczM5MF0NCj4gQWNr
ZWQtYnk6IENvbHkgTGkgPGNvbHlsaUBzdXNlLmRlPiBbYmNhY2hlXQ0KPiBBY2tlZC1ieTogRGF2
aWQgU3RlcmJhIDxkc3RlcmJhQHN1c2UuY29tPiBbYnRyZnNdDQo+IC0tLQ0KDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
