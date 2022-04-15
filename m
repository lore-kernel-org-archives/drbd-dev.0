Return-Path: <chaitanyak@nvidia.com>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AB05A420FB1
	for <drbd-dev@lists.linbit.com>; Fri, 15 Apr 2022 07:51:31 +0200 (CEST)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Date: Fri, 15 Apr 2022 05:36:12 +0000
Message-ID: <673afa25-cf3f-616c-6bcd-16de35b307b2@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
	<20220415045258.199825-2-hch@lst.de>
In-Reply-To: <20220415045258.199825-2-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E802A778DDA3DB47923030D024586109@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>,
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
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
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
Subject: Re: [Drbd-dev] [PATCH 01/27] target: remove an incorrect unmap
 zeroes data deduction
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

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEZvciBibG9jayBk
ZXZpY2VzLCB0aGUgU0NTSSB0YXJnZXQgZHJpdmVycyBpbXBsZW1lbnRzIFVOTUFQIGFzIGNhbGxz
IHRvDQo+IGJsa2Rldl9pc3N1ZV9kaXNjYXJkLCB3aGljaCBkb2VzIG5vdCBndWFyYW50ZWUgemVy
b2luZyBqdXN0IGJlY2F1c2UNCj4gV3JpdGUgWmVyb2VzIGlzIHN1cHBvcnRlZC4NCj4gDQo+IE5v
dGUgdGhhdCB0aGlzIGRvZXMgbm90IGFmZmVjdCB0aGUgZmlsZSBiYWNrZWQgcGF0aCB3aGljaCB1
c2VzDQo+IGZhbGxvY2F0ZSB0byBwdW5jaCBob2xlcy4NCj4gDQo+IEZpeGVzOiAyMjM3NDk4ZjBi
NWMgKCJ0YXJnZXQvaWJsb2NrOiBDb252ZXJ0IFdSSVRFX1NBTUUgdG8gYmxrZGV2X2lzc3VlX3pl
cm9vdXQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4N
Cj4gUmV2aWV3ZWQtYnk6IE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGluLnBldGVyc2VuQG9yYWNs
ZS5jb20+DQoNCk5vdCBhIGdvb2QgYXNzdW1wdGlvbiB0byBoYXZlIGZvciBzdXJlLg0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K
