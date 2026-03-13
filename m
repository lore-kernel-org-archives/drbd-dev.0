Return-Path: <agruenba@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BAF79160655
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2026 15:36:07 +0100 (CET)
Received: by mail-yx1-f72.google.com with SMTP id
	956f58d0204a3-64ca09f2064so2251248d50.2
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2026 07:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260304190424.291743-1-agruenba@redhat.com>
	<abQHNzJ0FR1EF0NX@shinmob>
In-Reply-To: <abQHNzJ0FR1EF0NX@shinmob>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 13 Mar 2026 15:35:53 +0100
Message-ID: <CAHc6FU7bab0+snOVBog-FZkn_sy3AHoEP2SNFxdZ-n13tAE5Ng@mail.gmail.com>
Subject: Re: [PATCH 0/4] simple bio cleanups
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 13, 2026 at 1:54=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
> On Mar 04, 2026 / 20:04, Andreas Gruenbacher wrote:
> > Jens,
> >
> > here are some simple bio related cleanups.  Any thoughts?  Can those go
> > in via your tree?
> >
> > Thanks,
> > Andreas
> >
> > Andreas Gruenbacher (4):
> >   block: consecutive blk_status_t error codes
> >   block: get rid of blk_status_to_{errno,str} inconsistency
> >   bio: rename bio_chain arguments
> >   bio: use bio_io_error more often
>
> Hello Andreas, during blktests CI trial runs, I noticed that this patch s=
eries
> triggered failures of three blktests test cases: scsi/004, scsi/007 and
> throtl/004. Do you see which patch triggered these failures?

Hello Shinichiro,

thanks a lot for the report. I now see that patch "block: get rid of
blk_status_to_{errno,str} inconsistency" is broken in its current
form.

Andreas

>
>
> scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out comm=
and) [failed]
>     runtime    ...  3.855s
>     --- tests/scsi/004.out      2026-03-12 15:23:54.664435639 +0000
>     +++ /home/fedora/blktests/results/nodev/scsi/004.out.bad    2026-03-1=
2 18:13:40.059747989 +0000
>     @@ -1,3 +1,2 @@
>      Running scsi/004
>     -Input/output error
>      Test complete
>
> scsi/007 (Trigger the SCSI error handler)                    [failed]
>     runtime    ...  115.385s
>     --- tests/scsi/007.out      2026-03-12 15:23:54.668435644 +0000
>     +++ /home/fedora/blktests/results/nodev/scsi/007.out.bad    2026-03-1=
2 18:15:55.054944537 +0000
>     @@ -1,3 +1,3 @@
>      Running scsi/007
>     -Reading from scsi_debug failed
>     +Reading from scsi_debug succeeded
>      Test complete
>
> throtl/004 (nullb) (delete disk while IO is throttled)       [failed]
>     runtime    ...  1.643s
>     --- tests/throtl/004.out    2026-03-12 15:23:54.710435695 +0000
>     +++ /home/fedora/blktests/results/nodev_nullb/throtl/004.out.bad    2=
026-03-12 18:20:46.314368581 +0000
>     @@ -1,3 +1,2 @@
>      Running throtl/004
>     -Input/output error
>      Test complete
>

