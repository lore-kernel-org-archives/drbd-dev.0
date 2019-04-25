Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7358A1028A68
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 13:04:58 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id s15so29654292wra.12
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 04:04:58 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	g19sm19717142wmh.17.2019.04.25.03.56.42
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 03:56:42 -0700 (PDT)
Date: Thu, 25 Apr 2019 12:56:41 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190425105641.GA919@soda.linbit>
References: <eec310e0-e0ca-6b18-7496-e9e3b6b29b63@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eec310e0-e0ca-6b18-7496-e9e3b6b29b63@i-love.sakura.ne.jp>
Subject: Re: [Drbd-dev] Please test with CONFIG_PROVE_LOCKING=y
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

On Thu, Apr 25, 2019 at 06:30:05PM +0900, Tetsuo Handa wrote:
> I found that simply doing
> 
> # mount /dev/drbd0 /mnt/
> 
> on the primary side causes a lockdep splat on the peer side.
> 

> [   23.039882] ========================================================
> [   23.039906] WARNING: possible irq lock inversion dependency detected
> [   23.039931] 5.0.0 #891 Tainted: G           O
> [   23.039950] --------------------------------------------------------
> [   23.039975] drbd_r_r0/8237 just changed the state of lock:
> [   23.039997] 000000007cc227b6 (&(&connection->epoch_lock)->rlock){+.+.}, at: receive_Data+0x36b/0x1ca0 [drbd]
> [   23.040049] but this lock was taken by another, SOFTIRQ-safe lock in the past:
> [   23.040115]  (&(&resource->req_lock)->rlock){..-.}
> [   23.040117]
> 
> and interrupts could create inverse lock ordering between them.
> 
> [   23.040176]
> other info that might help us debug this:
> [   23.040200]  Possible interrupt unsafe locking scenario:
> 
> [   23.040225]        CPU0                    CPU1
> [   23.040243]        ----                    ----
> [   23.040260]   lock(&(&connection->epoch_lock)->rlock);
> [   23.040281]                                local_irq_disable();
> [   23.040303]                                lock(&(&resource->req_lock)->rlock);
> [   23.040330]                                lock(&(&connection->epoch_lock)->rlock);
> [   23.040359]   <Interrupt>
> [   23.040370]     lock(&(&resource->req_lock)->rlock);
> [   23.040389]
>  *** DEADLOCK ***


Yes.
We already know.
"impossible odds"...

But needs fixing.
Certainly NOT by making all epoch_lock irqsave.
Problem was introduced by me with
f4acb16f drbd: fix lifetime of "need to apply activity log" metadata flag

I "just" need to come up with a way to check what I am checking there
without taking the epoch lock.


> Although making below change seems to solve the lockdep splat,
> I can't check the correctness because I don't know how drbd works.
> Please test with CONFIG_PROVE_LOCKING=y and fix.

See above.
Thanks.

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
