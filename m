Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 72F7F1055700
	for <drbd-dev@lists.linbit.com>; Wed, 12 Oct 2011 20:18:02 +0200 (CEST)
Resent-Message-ID: <20111012181758.GA10813@barkeeper1-xen.linbit>
Received: from mail-iy0-f182.google.com (mail-iy0-f182.google.com
	[209.85.210.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8F91110556B5
	for <drbd-dev@lists.linbit.com>; Wed, 12 Oct 2011 15:35:29 +0200 (CEST)
Received: by iaky10 with SMTP id y10so23270iak.27
	for <drbd-dev@lists.linbit.com>; Wed, 12 Oct 2011 06:35:28 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1318422455-17539-14-git-send-email-philipp.reisner@linbit.com>
References: <1318422455-17539-1-git-send-email-philipp.reisner@linbit.com>
	<1318422455-17539-14-git-send-email-philipp.reisner@linbit.com>
Date: Wed, 12 Oct 2011 15:35:28 +0200
Message-ID: <CAMuHMdXGCEUGanrsyFkgyr3ZAr5YpgrjbVqJtvCu5Li6XMMDMA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 13/13] DRBD: Fix comparison always false
 warning due to long/long long compare
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Oct 12, 2011 at 14:27, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
> From: David Howells <dhowells@redhat.com>
>
> Fix warnings of the following nature in the drbd header:
>
> In file included from drivers/block/drbd/drbd_bitmap.c:32:
> drivers/block/drbd/drbd_int.h: In function 'drbd_get_syncer_progress':
> drivers/block/drbd/drbd_int.h:2234: warning: comparison is always false d=
ue to limited range of data
>
> where mdev->rs_total (an unsigned long) is being compared to 1ULL << 32, =
which
> is always false on a 32-bit machine.

But on 32-bit, unsigned long is never larger than UINT_MAX neither, so
it doesn't
really change anything??

> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
>
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> ---
> =C2=A0drivers/block/drbd/drbd_int.h | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.=
h
> index ece2e4a..de42c7c 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -2071,7 +2071,7 @@ static inline void drbd_get_syncer_progress(struct =
drbd_conf *mdev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Note: currently=
 we don't support such large bitmaps on 32bit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * arch anyways, b=
ut no harm done to be prepared for it here.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int shift =3D=
 mdev->rs_total >=3D (1ULL << 32) ? 16 : 10;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int shift =3D=
 mdev->rs_total > UINT_MAX ? 16 : 10;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long left=
 =3D *bits_left >> shift;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long tota=
l =3D 1UL + (mdev->rs_total >> shift);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long tmp =
=3D 1000UL - left * 1000UL/total;

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
