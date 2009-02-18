Return-Path: <dk@in-telegence.net>
Received: from mail.in-telegence.net (mail.in-telegence.net [83.125.45.125])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EF3831011BB5
	for <drbd-dev@lists.linbit.com>; Wed, 18 Feb 2009 14:44:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail.in-telegence.net (Postfix) with ESMTP id 8625F69C031
	for <drbd-dev@lists.linbit.com>; Wed, 18 Feb 2009 14:44:18 +0100 (CET)
Received: from 127.0.0.1/32:46030 (from=<dk@in-telegence.net>;
	helo=mail.in-telegence.net)
	by eXpurgate V1.3.53.1, id=150498::090218144418-04340400-415D42B6
	for <drbd-dev@lists.linbit.com>; Wed, 18 Feb 2009 14:44:18 +0100
Received: from [10.2.20.85] (DK.in-telegence.net [10.2.20.85])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by mail.in-telegence.net (Postfix) with ESMTP id D3CE266FAA5
	for <drbd-dev@lists.linbit.com>; Wed, 18 Feb 2009 14:44:17 +0100 (CET)
Message-ID: <499C10E3.60302@in-telegence.net>
Date: Wed, 18 Feb 2009 14:45:07 +0100
From: Dominik Klein <dk@in-telegence.net>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <499C0F88.3050303@in-telegence.net>
In-Reply-To: <499C0F88.3050303@in-telegence.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] Patch: drbdadm.sh
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Dominik Klein wrote:
> When using the bash completion feature on machines with currently
> unconfigured drbd resources, it kept throwing error messages rendering
> the cmdline unreadable.
> 
> Typing "drbdadm pr<tab> <tab>" would give s.th. like
> 
> dktest3:~ # drbdadm primary /dev/drbd0: Failure: (127) Device minor not
> allocated
> Command 'drbdsetup /dev/drbd0 state' terminated with exit code 10
> kvm2
> 
> Consider the attached patch.
> 
> Regards
> Dominik
> 

Well, this happens when you use diff with "new old" instead of "old
new". Guess you got the idea anyway.

Regards
Dominik
