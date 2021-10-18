Return-Path: <chaitanyak@nvidia.com>
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
	(mail-bn1nam07on2086.outbound.protection.outlook.com [40.107.212.86])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1DF50420FAA
	for <drbd-dev@lists.linbit.com>; Mon, 18 Oct 2021 10:19:33 +0200 (CEST)
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Date: Mon, 18 Oct 2021 05:46:32 +0000
Message-ID: <b910c530-1aee-c9f3-c9f7-42c89084c83d@nvidia.com>
References: <20211015132643.1621913-1-hch@lst.de>
	<20211015132643.1621913-4-hch@lst.de>
In-Reply-To: <20211015132643.1621913-4-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <276A457CC12A29429674DCE72537FB49@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Cc: Dave Kleikamp <shaggy@kernel.org>, "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>, Mike Snitzer <snitzer@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Song Liu <song@kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>, Ryusuke,
	"reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, Konishi <konishi.ryusuke@gmail.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, "linux-ntfs-dev@lists.sourceforge.net"
	<linux-ntfs-dev@lists.sourceforge.net>, Jan Kara <jack@suse.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Drbd-dev] [PATCH 03/30] bcache: remove bdev_sectors
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

T24gMTAvMTUvMjEgMDY6MjYsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBVc2UgdGhlIGVx
dWl2YWxlbnQgYmxvY2sgbGF5ZXIgaGVscGVyIGluc3RlYWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IEtlZXMgQ29v
ayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiBBY2tlZC1ieTogQ29seSBMaSA8Y29seWxpQHN1
c2UuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
