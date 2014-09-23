Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 40835101E04D
	for <drbd-dev@lists.linbit.com>; Tue, 23 Sep 2014 13:03:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 35B73310B89
	for <drbd-dev@lists.linbit.com>; Tue, 23 Sep 2014 13:03:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id aXjYrMpi63cW for <drbd-dev@lists.linbit.com>;
	Tue, 23 Sep 2014 13:03:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1C7E5310B6E
	for <drbd-dev@lists.linbit.com>; Tue, 23 Sep 2014 13:03:49 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vRkUl2Wukvk7 for <drbd-dev@lists.linbit.com>;
	Tue, 23 Sep 2014 13:03:49 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E6E80310B08
	for <drbd-dev@lists.linbit.com>; Tue, 23 Sep 2014 13:03:48 +0200 (CEST)
Date: Tue, 23 Sep 2014 13:03:48 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140923110348.GA19076@soda.linbit>
References: <20140919094909.GA21578@schiffbauer.net>
	<20140919144805.GS13125@soda.linbit>
	<20140919151653.GH21578@schiffbauer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140919151653.GH21578@schiffbauer.net>
Subject: Re: [Drbd-dev] drbd 8.4.3: refcounter overflow on re-sync
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Sep 19, 2014 at 05:16:53PM +0200, Marc Schiffbauer wrote:
> * Lars Ellenberg schrieb am 19.09.14 um 16:48 Uhr:
> >On Fri, Sep 19, 2014 at 11:49:09AM +0200, Marc Schiffbauer wrote:
> >>Hi,
> >>
> >
> >If you resolve that to a code line,
> >I may be able to figure out what PAX is talking about.
> >
> >But from this stack trace alone, I have absolutely no idea what PAX
> >is trying to say, which refcount could possibly be meant there,
> >let alone why it could possibly overflow or.
> >
> >Ah, ok. Looking at [1], "PaX Team" says:
> >.---
> >| after having looked at the drbd code a bit i think this could be a
> >| real bug in drbd but only upstream can tell for sure so you'll have to
> >| contact them. you can show them the following that i figured out so far:
> >|
> >| the refcount overflow was detected in
> >| drivers/block/drbd/drbd_bitmap.c:bm_page_io_async at the
> >|
> >| atomic_add(len >> 9, &mdev->rs_sect_ev)
> >
> >Well, yes, why would it not overflow.
> >It is *not* a refcount.
> >It is an atomic counter.
> >It is meant to overflow.
> 
> Ok, then I can report this back and it should be fixed in PaX as a
> false postive. Thanks for clarifying this.

I still don't get why PAX is even sending a signal there.
How could sending a signal possibly help against an overflowing counter?

Ah well. I don't need to get everything ...

Thanks,

	Lars

