Return-Path: <igor@novg.net>
Received: from mail.novg.net (mail.novg.net [194.190.107.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 430B3101E067
	for <drbd-dev@lists.linbit.com>; Wed,  8 Oct 2014 12:31:31 +0200 (CEST)
Received: from [192.168.22.101] (a4k2.static.corbina.ru [93.81.251.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.novg.net (Postfix) with ESMTPSA id 5A282781AD4
	for <drbd-dev@lists.linbit.com>; Wed,  8 Oct 2014 14:31:29 +0400 (MSK)
Message-ID: <54351285.7030508@novg.net>
Date: Wed, 08 Oct 2014 14:31:33 +0400
From: Igor Novgorodov <igor@novg.net>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <542EFA18.9060705@novg.net>
	<20141006153435.GE8574@soda.linbit>	<5432C17B.4050502@novg.net>
	<20141008093757.GF23433@soda.linbit>
In-Reply-To: <20141008093757.GF23433@soda.linbit>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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


On 08.10.2014 13:37, Lars Ellenberg wrote:
> On Mon, Oct 06, 2014 at 08:21:15PM +0400, Igor Novgorodov wrote:
>> I didn't found any bugtracker for DRBD project, so i reported the bug here.
> Right thing to do. Thank you.
>
>> ENOIOCTLCMD is returned in several places in net/socket.c and
>> net/ipv4/tcp.c,
>> it seems to have something to do with 32-bit code emulation on
>> 64-bit kernel:
>>
>> #ifdef CONFIG_COMPAT
>> static int inet_compat_ioctl(struct socket *sock, unsigned int cmd,
>> unsigned long arg)
>> {
>>           struct sock *sk = sock->sk;
>>           int err = -ENOIOCTLCMD;
>>
>>           if (sk->sk_prot->compat_ioctl)
>>                   err = sk->sk_prot->compat_ioctl(sk, cmd, arg);
>>
>>           return err;
>> }
>> #endif
>>
>> CONFIG_COMPAT is only defined if 32-bit emulation is enabled in kernel.
>>
>> I've just rebuilt kernel with CONFIG_X86_X32 and drbd-8.4-git
>> started to work fine,
>> so the problem is there, somewhere in 64/32 compatibility layer :)
> Uh?
> That is ... unexpected.
>
> ->listen() should do any ioctls, though?
> and there is just kernel code talking to kernel code,
> so why would CONFIG_X86_X32 matter at all?
>
> Can you double check, please:
> Is that reproducible, i.e., if you swich that CONFIG off again,
> the error comes back?
>
> (does not reproduce here... yet)

You're right, something's odd here.

I've rebuilt the same git version 8.4 
ca3a67af3823b85614621a4cf95e191c5820c0eb
with the very same kernel 3.14.19 with CONFIG_IA32_EMULATION unset, and 
DRBD started
to work without a problem, no listen errors.

I used the same kernel & drbd sources, same config, nothing has changed 
since.
Maybe there was some bug on my build machine...

Thanks anyway, and sorry for disturbing, if anything like that should 
come up again, i'll report.


> 	Lars
>
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev

