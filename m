Return-Path: <ard@kwaak.net>
Received: from mail.kwaak.net (gw-cistron.kwaak.net [62.216.22.210])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C90A42D9E0D8
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jan 2007 20:33:11 +0100 (CET)
Received: from ard by mail.kwaak.net with local (Exim 4.50) id 1H4jC5-0000Ny-8a
	for drbd-dev@lists.linbit.com; Wed, 10 Jan 2007 20:33:05 +0100
Date: Wed, 10 Jan 2007 20:33:05 +0100
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd 2.6.19 crypto changes
Message-ID: <20070110193305.GZ15730@kwaak.net>
References: <20070110123116.GX15730@kwaak.net>
	<20070110134804.GI8061@soda.linbit>
	<20070110160958.GY15730@kwaak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110160958.GY15730@kwaak.net>
From: Ard van Breemen <ard@kwaak.net>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Jan 10, 2007 at 05:09:58PM +0100,  wrote:
> Hmmm, it does load, but somehow there are no minor devices :-(.
> (/proc/drbd shows nothing more than the banner)
> So it is not a definite fix.

My fault :-(

I thought I installed the up to date userspace utils, while
actually I did not install anything but the kernel module...
