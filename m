Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C5B271055F73
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id BB7591B435C
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:25 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQiLvWRzoQlT for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:25 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 9BCB21B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:25 +0200 (CEST)
Resent-Message-ID: <20120810203325.GT31190@soda.linbit>
Received: from mail-qa0-f54.google.com (mail-qa0-f54.google.com
	[209.85.216.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BE3181045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 01:53:55 +0200 (CEST)
Received: by qaat11 with SMTP id t11so28299qaa.6
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 16:53:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120808232804.GL6983@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-13-git-send-email-koverstreet@google.com>
	<Pine.LNX.4.64.1208061913500.21956@file.rdu.redhat.com>
	<20120808232804.GL6983@dhcp-172-17-108-109.mtv.corp.google.com>
Date: Wed, 8 Aug 2012 16:47:46 -0700
Message-ID: <CAFR8uedZiG0NWgWQQa03r+kKh8rT0jzpj+hwPzq+i7K6zhpT_A@mail.gmail.com>
From: Muthu Kumar <muthu.lkml@gmail.com>
To: Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: axboe@kernel.dk, Kent Overstreet <koverstreet@google.com>,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, agk@redhat.com,
	sage@newdream.net, yehuda@hq.newdream.net, vgoyal@redhat.com,
	drbd-dev@lists.linbit.com
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

Tejun,

This is changing the semantics of the clone. Sorry, I missed this
thread and replied separately. But anyway, replying it again here:


On Wed, Aug 8, 2012 at 4:28 PM, Tejun Heo <tj@kernel.org> wrote:
> On Mon, Aug 06, 2012 at 07:16:33PM -0400, Mikulas Patocka wrote:
>> Hi Kent
>>
>> When you change the semantics of an exported function, rename that
>> function. There may be external modules that use __bio_clone and this
>> change could silently introduce bugs in them.
>>
>> Otherwise, the patchset looks fine.
>
> I don't know.  This doesn't change the main functionality and should
> be transparent unless the caller is doing something crazy.  It *might*
> be nice to rename but I don't think that's a must here.
>
> Thanks.

--
You are changing the meaning of __bio_clone() here. In old code, the
number of io_vecs, bi_idx, bi_vcnt are preserved. But in this modified
code, you are mapping bio_src's bi_iovec[bi_idx] to bio_dests
bi_iovec[0] and also restricting the number of allocated io_vecs of
the clone. It may be useful for cases were we would like a identical
copy of the original bio (may not be in current code base, but this
implementation is definitely not what one would expect from the name
"clone").

May be, call this new implementation some thing else (and use it for bcache)?

---

Like Mikulas pointed out, this is an exported function and silently
changing the semantics will break external modules.

Regards,
Muthu


>
> --
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
