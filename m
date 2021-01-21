Return-Path: <prvs=648f07ef0=Chaitanya.Kulkarni@wdc.com>
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 20AFB4205F9
	for <drbd-dev@lists.linbit.com>; Thu, 21 Jan 2021 09:29:31 +0100 (CET)
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 21 Jan 2021 08:23:20 +0000
Message-ID: <DM6PR04MB4972029B58F81B22033E31F386A10@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
	<CAGRGNgWLspr6M1COgX9cuDDgYdiXvQQjWQb7XYLsmFpfMYt0sA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>,
	"cluster-devel@redhat.com" <cluster-devel@redhat.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	Linux SCSI List <linux-scsi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
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

On 1/20/21 7:01 PM, Julian Calaby wrote:=0A=
> Hi Chaitanya,=0A=
>=0A=
> On Tue, Jan 19, 2021 at 5:01 PM Chaitanya Kulkarni=0A=
> <chaitanya.kulkarni@wdc.com> wrote:=0A=
>> Hi,=0A=
>>=0A=
>> This is a *compile only RFC* which adds a generic helper to initialize=
=0A=
>> the various fields of the bio that is repeated all the places in=0A=
>> file-systems, block layer, and drivers.=0A=
>>=0A=
>> The new helper allows callers to initialize various members such as=0A=
>> bdev, sector, private, end io callback, io priority, and write hints.=0A=
>>=0A=
>> The objective of this RFC is to only start a discussion, this it not=0A=
>> completely tested at all.=0A=
>> Following diff shows code level benefits of this helper :-=0A=
>>  38 files changed, 124 insertions(+), 236 deletions(-)=0A=
> On a more abstract note, I don't think this diffstat is actually=0A=
> illustrating the benefits of this as much as you think it is.=0A=
>=0A=
> Yeah, we've reduced the code by 112 lines, but that's barely half the=0A=
> curn here. It looks, from the diffstat, that you've effectively=0A=
> reduced 2 lines into 1. That isn't much of a saving.=0A=
>=0A=
> Thanks,=0A=
The diff stat is not the only measure since every component fs/driver=0A=
has a different style and nested call it just to show the effect.=0A=
Thanks for your comment, we have decided to go with the bio_new approach.=
=0A=
=0A=
=0A=
