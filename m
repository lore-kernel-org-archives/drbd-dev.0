Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F155E101E067
	for <drbd-dev@lists.linbit.com>; Wed,  8 Oct 2014 11:37:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E55653C52D0
	for <drbd-dev@lists.linbit.com>; Wed,  8 Oct 2014 11:37:57 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id WrEckbDLTayP for <drbd-dev@lists.linbit.com>;
	Wed,  8 Oct 2014 11:37:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C7BDA3C52DA
	for <drbd-dev@lists.linbit.com>; Wed,  8 Oct 2014 11:37:57 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id szS7hBVgB0WA for <drbd-dev@lists.linbit.com>;
	Wed,  8 Oct 2014 11:37:57 +0200 (CEST)
Received: from soda.linbit (unknown [217.196.73.213])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A4ADF3C52D0
	for <drbd-dev@lists.linbit.com>; Wed,  8 Oct 2014 11:37:57 +0200 (CEST)
Date: Wed, 8 Oct 2014 11:37:57 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20141008093757.GF23433@soda.linbit>
References: <542EFA18.9060705@novg.net> <20141006153435.GE8574@soda.linbit>
	<5432C17B.4050502@novg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5432C17B.4050502@novg.net>
Subject: Re: [Drbd-dev] Bug in latest 8.4-git
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

On Mon, Oct 06, 2014 at 08:21:15PM +0400, Igor Novgorodov wrote:
> I didn't found any bugtracker for DRBD project, so i reported the bug here.

Right thing to do. Thank you.

> ENOIOCTLCMD is returned in several places in net/socket.c and
> net/ipv4/tcp.c,
> it seems to have something to do with 32-bit code emulation on
> 64-bit kernel:
> 
> #ifdef CONFIG_COMPAT
> static int inet_compat_ioctl(struct socket *sock, unsigned int cmd,
> unsigned long arg)
> {
>          struct sock *sk = sock->sk;
>          int err = -ENOIOCTLCMD;
> 
>          if (sk->sk_prot->compat_ioctl)
>                  err = sk->sk_prot->compat_ioctl(sk, cmd, arg);
> 
>          return err;
> }
> #endif
> 
> CONFIG_COMPAT is only defined if 32-bit emulation is enabled in kernel.
> 
> I've just rebuilt kernel with CONFIG_X86_X32 and drbd-8.4-git
> started to work fine,
> so the problem is there, somewhere in 64/32 compatibility layer :)

Uh?
That is ... unexpected.

->listen() should do any ioctls, though?
and there is just kernel code talking to kernel code,
so why would CONFIG_X86_X32 matter at all?

Can you double check, please:
Is that reproducible, i.e., if you swich that CONFIG off again,
the error comes back?

(does not reproduce here... yet)

	Lars

