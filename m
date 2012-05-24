Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2623D100542E
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 18B0F1B4262
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:03 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wu9e5qrgiHE3 for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 09:04:03 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id EA9281B4206
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:02 +0200 (CEST)
Resent-Message-ID: <20120525070402.GN12726@soda.linbit>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
	[209.85.214.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 778D81019A78
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 23:41:25 +0200 (CEST)
Received: by bkvi18 with SMTP id i18so367605bkv.27
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 14:41:24 -0700 (PDT)
MIME-Version: 1.0
Sender: yehudasa@gmail.com
In-Reply-To: <20120524185919.GE27550@redhat.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-5-git-send-email-koverstreet@google.com>
	<20120524185919.GE27550@redhat.com>
Date: Thu, 24 May 2012 14:41:24 -0700
Message-ID: <CAC-hyiHNFSiqPAoe9ynokUg1xTS=V32JDYiVHh_qH7ow=0C1fw@mail.gmail.com>
From: Yehuda Sadeh <yehuda@inktank.com>
To: Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: axboe@kernel.dk, Alex Elder <elder@inktank.com>, dm-devel@redhat.com,
	neilb@suse.de, Kent Overstreet <koverstreet@google.com>,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	bharrosh@panasas.com, linux-fsdevel@vger.kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 04/14] block: Add bio_clone_kmalloc()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 24, 2012 at 11:59 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Wed, May 23, 2012 at 05:02:41PM -0700, Kent Overstreet wrote:
>
> [..]
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 013c7a5..5a953c6 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -729,7 +729,7 @@ static struct bio *bio_chain_clone(struct bio **old,=
 struct bio **next,
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 while (old_chain && (total < len)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D bio_kmalloc(gfpmask, old_chain->bi_max=
_vecs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D bio_clone_kmalloc(old_chain, gfpmask);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tmp)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>>
>> @@ -751,13 +751,9 @@ static struct bio *bio_chain_clone(struct bio **old=
, struct bio **next,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bp)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out=
;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __bio_clone(tmp, &bp->bio1);
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *next =3D &bp->bio2;
>
> Is this code correct. Now original code might clone bio after split and
> new code will clone the original bio itself and not the split one?
>

Yeah, that's wrong.

Yehuda
