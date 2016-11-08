Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B57B71056478
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 23:04:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 622B136B63B
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 23:04:13 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id eqnvlNcm4xpV for <drbd-dev@lists.linbit.com>;
	Wed,  9 Nov 2016 23:04:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 39F3536BA1E
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 23:04:13 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9FDDREu7q7-R for <drbd-dev@lists.linbit.com>;
	Wed,  9 Nov 2016 23:04:13 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id F143136B63B
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 23:04:12 +0100 (CET)
Resent-Message-ID: <20161109220412.GO1382@soda.linbit>
Received: from radon.swed.at (b.ns.miles-group.at [95.130.255.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2CEE61056482
	for <drbd-dev@lists.linbit.com>; Tue,  8 Nov 2016 17:03:01 +0100 (CET)
To: Christoph Hellwig <hch@infradead.org>
References: <1478601789-15060-1-git-send-email-richard@nod.at>
	<20161108154924.GA19063@infradead.org>
From: Richard Weinberger <richard@nod.at>
Message-ID: <748300d8-2a47-b273-5458-014dd3e3d6fc@nod.at>
Date: Tue, 8 Nov 2016 17:02:57 +0100
MIME-Version: 1.0
In-Reply-To: <20161108154924.GA19063@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: wolfgang.glas@iteg.at, christoph.lechleitner@iteg.at,
	philipp.reisner@linbit.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix kernel_sendmsg() usage
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

Christoph,

On 08.11.2016 16:49, Christoph Hellwig wrote:
> On Tue, Nov 08, 2016 at 11:43:09AM +0100, Richard Weinberger wrote:
>> Don't pass a size larger than iov_len to kernel_sendmsg().
>> Otherwise it will cause a NULL pointer deref when kernel_sendmsg()
>> returns with rv < size.
>>
>> Although the issue exists since day 0, only on non-ancient kernels
>> that contain change 57be5bdad759 ("ip: convert tcp_sendmsg() to iov_iter
>> primitives") it seems to trigger [0][1][2][3][4].
> 
> The real fix here is to convert it to the right primitive, e.g. take
> Al's patch from here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git/commit/?h=work.sendmsg&id=7a4992299554a9e1ed3c4540bcfa9e40aa9a6376

Yes, I talked already with Al about this. He suggested to fix the size parameter
first such that back-porting to -stable is easy.

Thanks,
//richard
