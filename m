Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D8A0E1056421
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 11:17:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B48383F14AB
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 11:17:34 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id U5BDNog_LCR8 for <drbd-dev@lists.linbit.com>;
	Tue, 29 Mar 2016 11:17:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8959C3F1587
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 11:17:34 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ccSiK4gSJpj5 for <drbd-dev@lists.linbit.com>;
	Tue, 29 Mar 2016 11:17:34 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 500C63F130C
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 11:17:34 +0200 (CEST)
Resent-Message-ID: <20160329091733.GJ15579@soda.linbit>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 335AF1056421
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 10:53:24 +0200 (CEST)
Received: from mail-yw0-f178.google.com ([209.85.161.178])
	by youngberry.canonical.com with esmtpsa
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <ming.lei@canonical.com>) id 1akpOt-0004OJ-O2
	for drbd-dev@lists.linbit.com; Tue, 29 Mar 2016 08:53:23 +0000
Received: by mail-yw0-f178.google.com with SMTP id h129so10255942ywb.1
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2016 01:53:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160329072617.GB18920@infradead.org>
References: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
	<1458627149-12988-2-git-send-email-ming.lei@canonical.com>
	<20160329072617.GB18920@infradead.org>
Date: Tue, 29 Mar 2016 16:53:22 +0800
Message-ID: <CACVXFVOmyJJjuNNyH89VM3jwVJA0zkA1H-JZtHoX1stxov4C2A@mail.gmail.com>
From: Ming Lei <ming.lei@canonical.com>
To: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: Jens Axboe <axboe@kernel.dk>, Boaz Harrosh <boaz@plexistor.com>,
	Dave Chinner <david@fromorbit.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	xfs@oss.sgi.com, linux-block@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 1/8] block: move bvec iterator into
	include/linux/bvec_iter.h
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

On Tue, Mar 29, 2016 at 3:26 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -31,6 +31,7 @@
>>
>>  /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
>>  #include <linux/blk_types.h>
>> +#include <linux/bvec_iter.h>
>>
>>  #define BIO_DEBUG
>>
>> @@ -40,10 +41,6 @@
>>  #define BIO_BUG_ON
>>  #endif
>>
>> -#define BIO_MAX_PAGES                256
>> -#define BIO_MAX_SIZE         (BIO_MAX_PAGES << PAGE_CACHE_SHIFT)
>> -#define BIO_MAX_SECTORS              (BIO_MAX_SIZE >> 9)
>
> I see no reason why these should be moved out of bio.h.

You are right, these should be kept in bio.h.

Thanks for your review!

>
> Otherwise this looks fine to me.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
