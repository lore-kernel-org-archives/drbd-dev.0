Return-Path: <kyle@moffetthome.net>
Received: from mail-pz0-f44.google.com (mail-pz0-f44.google.com
	[209.85.210.44]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DCB0110556B4
	for <drbd-dev@lists.linbit.com>; Wed, 28 Sep 2011 06:27:08 +0200 (CEST)
Received: by pzk32 with SMTP id 32so35097353pzk.3
	for <drbd-dev@lists.linbit.com>; Tue, 27 Sep 2011 21:27:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201109271134.06410.philipp.reisner@linbit.com>
References: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
	<1316788285-17433-10-git-send-email-philipp.reisner@linbit.com>
	<CAGZ=bq+Ef+wy8E9taBv=vZfTdvC_VBFFD=GzNqR9Em46U-wMmg@mail.gmail.com>
	<201109271134.06410.philipp.reisner@linbit.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Wed, 28 Sep 2011 00:26:45 -0400
Message-ID: <CAGZ=bqL=K6v+jxZOwv-=iL=MjOpoJ4JRAPLTtwdHNW_CsFc4GA@mail.gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 09/10] drbd: Remove volume numbers from
	struct p_header95
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 27, 2011 at 05:34, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
> Am Freitag, 23. September 2011, 19:28:24 schrieb Kyle Moffett:
>> On Fri, Sep 23, 2011 at 10:31, Philipp Reisner <philipp.reisner@linbit.c=
om> wrote:
>> > diff --git a/drivers/block/drbd/drbd_main.c
>> > b/drivers/block/drbd/drbd_main.c index 3310986..99b467e 100644
>> > --- a/drivers/block/drbd/drbd_main.c
>> > +++ b/drivers/block/drbd/drbd_main.c
>> > @@ -717,11 +717,11 @@ static unsigned int prepare_header80(struct
>> > p_header80 *h, enum drbd_packet cmd, return sizeof(struct p_header80);
>> > =C2=A0}
>> >
>> > -static unsigned int prepare_header95(struct p_header95 *h, enum
>> > drbd_packet cmd, int size, int vnr) +static unsigned int
>> > prepare_header95(struct p_header95 *h, enum drbd_packet cmd, int size)=
 {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0h->magic =C2=A0 =3D cpu_to_be16(DRBD_MAGIC_=
BIG);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0h->command =3D cpu_to_be16(cmd);
>> > - =C2=A0 =C2=A0 =C2=A0 h->vol_n_len =3D cpu_to_be32(vnr << 24 | size);
>> > + =C2=A0 =C2=A0 =C2=A0 h->length =3D cpu_to_be32(size);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return sizeof(struct p_header95);
>> > =C2=A0}
>>
>> This patch needs a commit message indicating why it does not break
>> compatibility. =C2=A0If you are guaranteed that the "vnr" passed into
>> prepare_header95 is always zero, then you should indicate why that is
>> true.
>
> Here is the commit message for that one. The alternative is to merge
> that to patch 'drbd: Use new header layout, and send volume IOs'.
> ( Which is patch number 236, i.e. outside of this (10th) posting of
> =C2=A0DRBD-8.4 patches. It was posted on August 25.
> =C2=A0See https://lkml.org/lkml/2011/8/25/322 )
>
> Author: Andreas Gruenbacher <agruen@linbit.com>
> Date: =C2=A0 Tue Mar 22 13:17:47 2011 +0100
>
> =C2=A0 =C2=A0drbd: Remove volume numbers from struct p_header95
>
> =C2=A0 =C2=A0Remove the temporal 8 bit volume number form header 95. All =
connections
> =C2=A0 =C2=A0that support multiple volumes are new using protocol 100 wit=
h header 100.

So my concern is that this effectively ignores an old field in
header95, so an old DRBD trying to talk about multiple volumes to a
new DRBD using header95 is going to get its volume number ignored,
right?

This means that old-DRBD and new-DRBD cannot communicate about
multiple volumes over one connection at all.  That needs to be made an
explicit part of this commit message and the rationale explained in
detail.

In particular, you need to make sure to describe what negotiation
mechanism prevents multiple-volume-header95 messages from being sent
to a version of DRBD including this commit.  If that behavior (IE: a
negotiation change) is part of another commit, then this is small
enough that I would merge it with that other commit, but it still
needs comments about why version interoperability will not break.

It seems to me like DRBD has historically not been terribly strict
with backwards-compatibility to very old versions, but now that it is
in the upstream kernel that is a very serious concern.  With an
out-of-tree module you have a lot more control over exactly which
version you are running, but when it's in-tree you are stuck with
whatever your vendor's kernel version is (for the most part).  Any
time you change or break backwards compatibility there needs to be at
the very *least* a detailed comment indicating why it needs to be
broken and exactly how you avoid additional complications from that.

Cheers,
Kyle Moffett
