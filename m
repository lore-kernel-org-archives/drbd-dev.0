Return-Path: <prvs=525b55839=shinichiro.kawasaki@wdc.com>
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1AA91160904
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2026 14:00:54 +0100 (CET)
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 0/4] simple bio cleanups
Date: Fri, 13 Mar 2026 12:53:43 +0000
Message-ID: <abQHNzJ0FR1EF0NX@shinmob>
References: <20260304190424.291743-1-agruenba@redhat.com>
In-Reply-To: <20260304190424.291743-1-agruenba@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04660C2DADAC4542B63210B46696291C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
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

On Mar 04, 2026 / 20:04, Andreas Gruenbacher wrote:
> Jens,
>=20
> here are some simple bio related cleanups.  Any thoughts?  Can those go
> in via your tree?
>=20
> Thanks,
> Andreas
>=20
> Andreas Gruenbacher (4):
>   block: consecutive blk_status_t error codes
>   block: get rid of blk_status_to_{errno,str} inconsistency
>   bio: rename bio_chain arguments
>   bio: use bio_io_error more often

Hello Andreas, during blktests CI trial runs, I noticed that this patch ser=
ies
triggered failures of three blktests test cases: scsi/004, scsi/007 and
throtl/004. Do you see which patch triggered these failures?


scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out comman=
d) [failed]
    runtime    ...  3.855s
    --- tests/scsi/004.out	2026-03-12 15:23:54.664435639 +0000
    +++ /home/fedora/blktests/results/nodev/scsi/004.out.bad	2026-03-12 18:=
13:40.059747989 +0000
    @@ -1,3 +1,2 @@
     Running scsi/004
    -Input/output error
     Test complete

scsi/007 (Trigger the SCSI error handler)                    [failed]
    runtime    ...  115.385s
    --- tests/scsi/007.out	2026-03-12 15:23:54.668435644 +0000
    +++ /home/fedora/blktests/results/nodev/scsi/007.out.bad	2026-03-12 18:=
15:55.054944537 +0000
    @@ -1,3 +1,3 @@
     Running scsi/007
    -Reading from scsi_debug failed
    +Reading from scsi_debug succeeded
     Test complete

throtl/004 (nullb) (delete disk while IO is throttled)       [failed]
    runtime    ...  1.643s
    --- tests/throtl/004.out	2026-03-12 15:23:54.710435695 +0000
    +++ /home/fedora/blktests/results/nodev_nullb/throtl/004.out.bad	2026-0=
3-12 18:20:46.314368581 +0000
    @@ -1,3 +1,2 @@
     Running throtl/004
    -Input/output error
     Test complete=
