Return-Path: <BATV+c403bd0c3744a0a7dffd+4825+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 336951056482
	for <drbd-dev@lists.linbit.com>; Tue,  8 Nov 2016 16:49:33 +0100 (CET)
Date: Tue, 8 Nov 2016 07:49:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Richard Weinberger <richard@nod.at>
Message-ID: <20161108154924.GA19063@infradead.org>
References: <1478601789-15060-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478601789-15060-1-git-send-email-richard@nod.at>
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

On Tue, Nov 08, 2016 at 11:43:09AM +0100, Richard Weinberger wrote:
> Don't pass a size larger than iov_len to kernel_sendmsg().
> Otherwise it will cause a NULL pointer deref when kernel_sendmsg()
> returns with rv < size.
> 
> Although the issue exists since day 0, only on non-ancient kernels
> that contain change 57be5bdad759 ("ip: convert tcp_sendmsg() to iov_iter
> primitives") it seems to trigger [0][1][2][3][4].

The real fix here is to convert it to the right primitive, e.g. take
Al's patch from here:

https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git/commit/?h=work.sendmsg&id=7a4992299554a9e1ed3c4540bcfa9e40aa9a6376
