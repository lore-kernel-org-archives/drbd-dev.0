Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6A77A1055F62
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 4EF701B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:37 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hljHFrDurZL1 for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:37 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 2F4A41B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:37 +0200 (CEST)
Resent-Message-ID: <20120810203337.GN31190@soda.linbit>
Received: from mail-vb0-f54.google.com (mail-vb0-f54.google.com
	[209.85.212.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 227C81012A92
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 03:51:00 +0200 (CEST)
Received: by vbmv11 with SMTP id v11so1886979vbm.27
	for <drbd-dev@lists.linbit.com>; Thu, 09 Aug 2012 18:50:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120809031936.GM7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-13-git-send-email-koverstreet@google.com>
	<Pine.LNX.4.64.1208061913500.21956@file.rdu.redhat.com>
	<20120808232804.GL6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<CAFR8uedZiG0NWgWQQa03r+kKh8rT0jzpj+hwPzq+i7K6zhpT_A@mail.gmail.com>
	<20120809031936.GM7262@moria.home.lan>
Date: Thu, 9 Aug 2012 18:50:59 -0700
Message-ID: <CAFR8uecQwi1HhcWbVfE_2L-3Z0duYPgSHryoJdrH09C-u6VbLg@mail.gmail.com>
From: Muthu Kumar <muthu.lkml@gmail.com>
To: Kent Overstreet <koverstreet@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: axboe@kernel.dk, linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, agk@redhat.com,
	sage@newdream.net, Tejun Heo <tj@kernel.org>,
	yehuda@hq.newdream.net, vgoyal@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v5 12/12] block: Only clone bio
 vecs that are in use
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Kent,

>> --
>> You are changing the meaning of __bio_clone() here. In old code, the
>> number of io_vecs, bi_idx, bi_vcnt are preserved. But in this modified
>> code, you are mapping bio_src's bi_iovec[bi_idx] to bio_dests
>> bi_iovec[0] and also restricting the number of allocated io_vecs of
>> the clone. It may be useful for cases were we would like a identical
>> copy of the original bio (may not be in current code base, but this
>> implementation is definitely not what one would expect from the name
>> "clone").
>
> The problem is that bio_clone() is used on bios that were not allocated
> or submitted by the cloning module.
>
> If some code somewher submits a bio that points to 500 pages, but by the
> time it gets to a driver it only points to 200 pages (say, because it
> was split), that clone should succeed; it shouldn't fail simply because
> it was trying to clone more than was necessary.
>


I would say, the code that submits bio with 500 pages is broken. It
needs to take care of underlying restrictions before submitting bios.
And that's one of the reason for having bio_add_page(), especially for
stackable modules.


> Bios have certain (poorly documented) semantics, and if this breaks
> anything it's probably because that code was doing something crazy in
> the first place.
>

Agree. But doing the above doesn't help in improving the situation,
just makes it even less clear.

Regards,
Muthu.


> In particular, if this change breaks anything then the new bio_split()
> _will_ break things.
>
> We need to be clear about our interfaces; in this case bi_idx and
> bi_vcnt, in particular. Either this is a safe change, or it's not. If
> no one knows... that's a bigger problem, and not just for this patch...
>
> Fortunately this code actually has been tested quite a bit (and the bio
> splitting code for even longer), and (somewhat to my surprise) I haven't
> run into any bugs caused by it.
