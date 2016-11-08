Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 314091056478
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 23:04:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D52E936B63B
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 23:04:17 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id pwFiLnDiKY9I for <drbd-dev@lists.linbit.com>;
	Wed,  9 Nov 2016 23:04:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B747836B8B6
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 23:04:17 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wOMVJAJIARlN for <drbd-dev@lists.linbit.com>;
	Wed,  9 Nov 2016 23:04:17 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 9371236B63B
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2016 23:04:17 +0100 (CET)
Resent-Message-ID: <20161109220417.GP1382@soda.linbit>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 29F7C1056482
	for <drbd-dev@lists.linbit.com>; Tue,  8 Nov 2016 17:43:52 +0100 (CET)
Date: Tue, 8 Nov 2016 16:13:24 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20161108161324.GH19539@ZenIV.linux.org.uk>
References: <1478601789-15060-1-git-send-email-richard@nod.at>
	<20161108154924.GA19063@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161108154924.GA19063@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: wolfgang.glas@iteg.at, Richard Weinberger <richard@nod.at>,
	christoph.lechleitner@iteg.at, philipp.reisner@linbit.com,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Tue, Nov 08, 2016 at 07:49:24AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 08, 2016 at 11:43:09AM +0100, Richard Weinberger wrote:
> > Don't pass a size larger than iov_len to kernel_sendmsg().
> > Otherwise it will cause a NULL pointer deref when kernel_sendmsg()
> > returns with rv < size.
> > 
> > Although the issue exists since day 0, only on non-ancient kernels
> > that contain change 57be5bdad759 ("ip: convert tcp_sendmsg() to iov_iter
> > primitives") it seems to trigger [0][1][2][3][4].
> 
> The real fix here is to convert it to the right primitive, e.g. take
> Al's patch from here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git/commit/?h=work.sendmsg&id=7a4992299554a9e1ed3c4540bcfa9e40aa9a6376

_After_ the backport-friendly part, please.  And that's my ACK-by
on Richard's variant.
