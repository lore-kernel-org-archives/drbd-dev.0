Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DDF881056194
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id D8C041B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:33 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UxBUM4XebypK for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:33 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id BB2401B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:33 +0200 (CEST)
Resent-Message-ID: <20120810203333.GG31190@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0F1F81045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 05:20:12 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so180784pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 20:20:10 -0700 (PDT)
Date: Wed, 8 Aug 2012 20:19:36 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Muthu Kumar <muthu.lkml@gmail.com>
Message-ID: <20120809031936.GM7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-13-git-send-email-koverstreet@google.com>
	<Pine.LNX.4.64.1208061913500.21956@file.rdu.redhat.com>
	<20120808232804.GL6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<CAFR8uedZiG0NWgWQQa03r+kKh8rT0jzpj+hwPzq+i7K6zhpT_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFR8uedZiG0NWgWQQa03r+kKh8rT0jzpj+hwPzq+i7K6zhpT_A@mail.gmail.com>
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

On Wed, Aug 08, 2012 at 04:47:46PM -0700, Muthu Kumar wrote:
> Tejun,
> 
> This is changing the semantics of the clone. Sorry, I missed this
> thread and replied separately. But anyway, replying it again here:
> 
> 
> On Wed, Aug 8, 2012 at 4:28 PM, Tejun Heo <tj@kernel.org> wrote:
> > On Mon, Aug 06, 2012 at 07:16:33PM -0400, Mikulas Patocka wrote:
> >> Hi Kent
> >>
> >> When you change the semantics of an exported function, rename that
> >> function. There may be external modules that use __bio_clone and this
> >> change could silently introduce bugs in them.
> >>
> >> Otherwise, the patchset looks fine.
> >
> > I don't know.  This doesn't change the main functionality and should
> > be transparent unless the caller is doing something crazy.  It *might*
> > be nice to rename but I don't think that's a must here.
> >
> > Thanks.
> 
> --
> You are changing the meaning of __bio_clone() here. In old code, the
> number of io_vecs, bi_idx, bi_vcnt are preserved. But in this modified
> code, you are mapping bio_src's bi_iovec[bi_idx] to bio_dests
> bi_iovec[0] and also restricting the number of allocated io_vecs of
> the clone. It may be useful for cases were we would like a identical
> copy of the original bio (may not be in current code base, but this
> implementation is definitely not what one would expect from the name
> "clone").

The problem is that bio_clone() is used on bios that were not allocated
or submitted by the cloning module.

If some code somewher submits a bio that points to 500 pages, but by the
time it gets to a driver it only points to 200 pages (say, because it
was split), that clone should succeed; it shouldn't fail simply because
it was trying to clone more than was necessary.

Bios have certain (poorly documented) semantics, and if this breaks
anything it's probably because that code was doing something crazy in
the first place.

In particular, if this change breaks anything then the new bio_split()
_will_ break things.

We need to be clear about our interfaces; in this case bi_idx and
bi_vcnt, in particular. Either this is a safe change, or it's not. If
no one knows... that's a bigger problem, and not just for this patch...

Fortunately this code actually has been tested quite a bit (and the bio
splitting code for even longer), and (somewhat to my surprise) I haven't
run into any bugs caused by it.
