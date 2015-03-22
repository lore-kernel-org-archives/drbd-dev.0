Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2F4E81011B9B
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2015 15:58:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 17D4B2AB5B3
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2015 15:58:52 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zHyBQUhsO8ra for <drbd-dev@lists.linbit.com>;
	Sun, 22 Mar 2015 15:58:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E6A412ABE62
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2015 15:58:51 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jxk8fzPf8Tlk for <drbd-dev@lists.linbit.com>;
	Sun, 22 Mar 2015 15:58:51 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id ADE5E2AB5B3
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2015 15:58:51 +0100 (CET)
Resent-Message-ID: <20150322145851.GJ3556@soda.linbit>
Received: from mail-la0-f52.google.com (mail-la0-f52.google.com
	[209.85.215.52]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 525B7104B1D2
	for <drbd-dev@lists.linbit.com>; Sun, 22 Mar 2015 03:19:45 +0100 (CET)
Received: by labon10 with SMTP id on10so11016249lab.2
	for <drbd-dev@lists.linbit.com>; Sat, 21 Mar 2015 19:19:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150320151450.GG3556@soda.linbit>
References: <1426295577-10836-1-git-send-email-akinobu.mita@gmail.com>
	<1426295577-10836-4-git-send-email-akinobu.mita@gmail.com>
	<20150320151450.GG3556@soda.linbit>
Date: Sun, 22 Mar 2015 11:11:41 +0900
Message-ID: <CAC5umyiWnqDT2EmhcaanZZKYtPoBgG5UzB2602sOO2sRNak3Ng@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
	drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Drbd-dev] [PATCH] drbd: use bitmap_weight()
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

2015-03-21 0:14 GMT+09:00 Lars Ellenberg <lars.ellenberg@linbit.com>:
> On Sat, Mar 14, 2015 at 10:12:56AM +0900, Akinobu Mita wrote:
>> Use bitmap_weight to count the total number of bits set in bitmap.
>> This change just simplifies the code a bit.
>
> "Simplifies", not sure about that, but ok, maybe.
>
> For the "bm_set_full_words_within_one_page", I disagree.
> I think it is more cpu cache friendly to hweight_long then set to ~0UL
> each word in turn, than to first bitmap_weight() all words, then
> bitmap_fill() all words.

I see. I'll remove the change in bm_set_full_words_within_one_page().

> Thanks,
>
>         Lars Ellenberg
>
> BTW, you swapped names and email addresses of phil and me.  Are those
> listed incorrectly somewhere, or was that just a mishap on your part?

It's just my mistake.  I copied your names from MAINTAINERS, but it
doesn't list your email addresses then I incorrectly swapped while
retrieving email addrsses from git log.
