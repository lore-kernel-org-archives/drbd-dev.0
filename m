Return-Path: <chaitanyak@nvidia.com>
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
	(mail-bn1nam07on2084.outbound.protection.outlook.com [40.107.212.84])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 78461420FCD
	for <drbd-dev@lists.linbit.com>; Fri, 15 Apr 2022 08:19:13 +0200 (CEST)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Date: Fri, 15 Apr 2022 05:46:32 +0000
Message-ID: <d3f73a4f-0d45-6627-7878-9b5acd47842f@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
	<20220415045258.199825-23-hch@lst.de>
In-Reply-To: <20220415045258.199825-23-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C40943C50889249AD34D58B6AD3A631@namprd12.prod.outlook.com>
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
Subject: Re: [Drbd-dev] [PATCH 22/27] block: refactor discard bio size
	limiting
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

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE1vdmUgYWxsIHRo
ZSBsb2dpYyB0byBsaW1pdCB0aGUgZGlzY2FyZCBiaW8gc2l6ZSBpbnRvIGEgY29tbW9uIGhlbHBl
cg0KPiBzbyB0aGF0IGl0IGlzIGJldHRlciBkb2N1bWVudGVkLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBNYXJ0aW4g
Sy4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPg0KPiBBY2tlZC1ieTogQ29s
eSBMaSA8Y29seWxpQHN1c2UuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
