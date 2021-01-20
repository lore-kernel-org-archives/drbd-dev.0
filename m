Return-Path: <prvs=647182bba=Chaitanya.Kulkarni@wdc.com>
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A2157420641
	for <drbd-dev@lists.linbit.com>; Wed, 20 Jan 2021 04:35:13 +0100 (CET)
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"cluster-devel@redhat.com" <cluster-devel@redhat.com>
Date: Wed, 20 Jan 2021 03:27:55 +0000
Message-ID: <BYAPR04MB49652C7B57396757FF064C6686A20@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "shaggy@kernel.org" <shaggy@kernel.org>,
	"jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"gustavo@embeddedor.com" <gustavo@embeddedor.com>,
	Moal <Damien.LeMoal@wdc.com>, "clm@fb.com" <clm@fb.com>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"darrick.wong@oracle.com" <darrick.wong@oracle.com>,
	"osandov@fb.com" <osandov@fb.com>,
	"kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>, Damien,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"efremov@linux.com" <efremov@linux.com>, "colyli@suse.de" <colyli@suse.de>,
	"tj@kernel.org" <tj@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"agruenba@redhat.com" <agruenba@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "tytso@mit.edu" <tytso@mit.edu>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"song@kernel.org" <song@kernel.org>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"rpeterso@redhat.com" <rpeterso@redhat.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"jth@kernel.org" <jth@kernel.org>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>
Subject: Re: [Drbd-dev] [RFC PATCH 00/37] block: introduce bio_init_fields()
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

On 1/18/21 21:06, Chaitanya Kulkarni wrote:=0A=
> Hi,=0A=
>=0A=
> This is a *compile only RFC* which adds a generic helper to initialize=0A=
> the various fields of the bio that is repeated all the places in=0A=
> file-systems, block layer, and drivers.=0A=
>=0A=
> The new helper allows callers to initialize various members such as=0A=
> bdev, sector, private, end io callback, io priority, and write hints.=0A=
>=0A=
> The objective of this RFC is to only start a discussion, this it not =0A=
> completely tested at all.                                                =
                                                            =0A=
> Following diff shows code level benefits of this helper :-=0A=
>  38 files changed, 124 insertions(+), 236 deletions(-)=0A=
>=0A=
> -ck=0A=
Thanks for replying Mike, Josef and Christoph.=0A=
=0A=
I'll move forward with Christoph's suggestion and get rid of=0A=
optional parameters which is making this API hard to use.=0A=
