Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5EF3510556B5
	for <drbd-dev@lists.linbit.com>; Thu, 13 Oct 2011 11:10:12 +0200 (CEST)
Resent-Message-ID: <20111013091010.GH10813@barkeeper1-xen.linbit>
Received: from mail-iy0-f182.google.com (mail-iy0-f182.google.com
	[209.85.210.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C1DE110556B5
	for <drbd-dev@lists.linbit.com>; Thu, 13 Oct 2011 10:43:26 +0200 (CEST)
Received: by iaky10 with SMTP id y10so1743735iak.27
	for <drbd-dev@lists.linbit.com>; Thu, 13 Oct 2011 01:43:24 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <201110131025.24950.philipp.reisner@linbit.com>
References: <1318422455-17539-1-git-send-email-philipp.reisner@linbit.com>
	<1318422455-17539-14-git-send-email-philipp.reisner@linbit.com>
	<CAMuHMdXGCEUGanrsyFkgyr3ZAr5YpgrjbVqJtvCu5Li6XMMDMA@mail.gmail.com>
	<201110131025.24950.philipp.reisner@linbit.com>
Date: Thu, 13 Oct 2011 10:43:24 +0200
Message-ID: <CAMuHMdXesV96Q-XUNkTRWN9aVyk3oH1HGgn+0p_4A3EtyqG2mQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
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

On Thu, Oct 13, 2011 at 10:25, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
> Am Mittwoch, 12. Oktober 2011, 15:35:28 schrieb Geert Uytterhoeven:
>> On Wed, Oct 12, 2011 at 14:27, Philipp Reisner
>> <philipp.reisner@linbit.com> wrote:
>> > From: David Howells <dhowells@redhat.com>
>> >
>> > Fix warnings of the following nature in the drbd header:
>> >
>> > In file included from drivers/block/drbd/drbd_bitmap.c:32:
>> > drivers/block/drbd/drbd_int.h: In function 'drbd_get_syncer_progress':
>> > drivers/block/drbd/drbd_int.h:2234: warning: comparison is always fals=
e
>> > due to limited range of data
>> >
>> > where mdev->rs_total (an unsigned long) is being compared to 1ULL << 3=
2,
>> > which is always false on a 32-bit machine.
>>
>> But on 32-bit, unsigned long is never larger than UINT_MAX neither, so
>> it doesn't
>> really change anything??
>
> As the commit message says, David's intention was to silence a compiler
> warning, not to change anything.

Sure, but
  1) Is the comparison a bug on 32-bit?
  2) I don't see a reason why (a different version of) gcc won't give
a warning for the
      new comparison always being false.

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
