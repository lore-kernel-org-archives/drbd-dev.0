Return-Path: <chaitanyak@nvidia.com>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 14704420FC6
	for <drbd-dev@lists.linbit.com>; Fri, 15 Apr 2022 08:06:36 +0200 (CEST)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Date: Fri, 15 Apr 2022 05:51:29 +0000
Message-ID: <ad050f78-2d64-0ff9-a6b0-968cfa53eacf@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
	<20220415045258.199825-27-hch@lst.de>
In-Reply-To: <20220415045258.199825-27-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5A7864F5C266F4ABDCFD32C055621F9@namprd12.prod.outlook.com>
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
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	Coly Li <colyli@suse.de>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
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
Subject: Re: [Drbd-dev] [PATCH 26/27] block: decouple REQ_OP_SECURE_ERASE
 from REQ_OP_DISCARD
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

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFNlY3VyZSBlcmFz
ZSBpcyBhIHZlcnkgZGlmZmVyZW50IG9wZXJhdGlvbiBmcm9tIGRpc2NhcmQgaW4gdGhhdCBpdCBp
cw0KPiBhIGRhdGEgaW50ZWdyaXR5IG9wZXJhdGlvbiB2cyBoaW50LiAgRnVsbHkgc3BsaXQgdGhl
IGxpbWl0cyBhbmQgaGVscGVyDQo+IGluZnJhc3RydWN0dXJlIHRvIG1ha2UgdGhlIHNlcGFyYXRp
b24gbW9yZSBjbGVhci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogTWFydGluIEsuIFBldGVyc2VuIDxtYXJ0aW4ucGV0
ZXJzZW5Ab3JhY2xlLmNvbT4NCj4gQWNrZWQtYnk6IENocmlzdG9waCBCw7ZobXdhbGRlciA8Y2hy
aXN0b3BoLmJvZWhtd2FsZGVyQGxpbmJpdC5jb20+IFtkcmJkXQ0KPiBBY2tlZC1ieTogUnl1c3Vr
ZSBLb25pc2hpIDxrb25pc2hpLnJ5dXN1a2VAZ21haWwuY29tPiBbbmlmczJdDQo+IEFja2VkLWJ5
OiBKYWVnZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3JnPiBbZjJmc10NCj4gQWNrZWQtYnk6IENv
bHkgTGkgPGNvbHlsaUBzdXNlLmRlPiBbYmNhY2hlXQ0KPiBBY2tlZC1ieTogRGF2aWQgU3RlcmJh
IDxkc3RlcmJhQHN1c2UuY29tPiBbYnRyZnNdDQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
