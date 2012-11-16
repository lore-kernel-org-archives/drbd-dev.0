Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 64A561017A2C
	for <drbd-dev@lists.linbit.com>; Fri, 16 Nov 2012 12:57:57 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 16 Nov 2012 12:57:56 +0100
Message-ID: <1705890.AaDvHkl6Pn@fat-tyre>
In-Reply-To: <20121112190123.GA1587@elgon.mountain>
References: <20121112190123.GA1587@elgon.mountain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd: Protect accesses to the uuid set with a
	spinlock
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Dan,

Thanks for the report. I have removed the redundant check. See here:

http://git.drbd.org/gitweb.cgi?p=linux-drbd.git;a=commitdiff;h=fdba05e9248f17dba3227c95ec25b498057e3109;hp=8d0ff3924bbad9fc53c3cc305d317033b16a5f05

Best regards,
 Phil

> Hello Philipp Reisner,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 9f2247bb9b75: "drbd: Protect accesses to the uuid set with
> a spinlock" from Aug 16, 2012, leads to the following Smatch
> complaint:
> 
> drivers/block/drbd/drbd_main.c:843 _drbd_send_uuids()
> 	 warn: variable dereferenced before check 'mdev->ldev' (see line 841)
> 
> drivers/block/drbd/drbd_main.c
>    840		}
>    841		spin_lock_irq(&mdev->ldev->md.uuid_lock);
>                               ^^^^^^^^^^^^^
> New dereference.
> 
>    842		for (i = UI_CURRENT; i < UI_SIZE; i++)
>    843			p->uuid[i] = mdev->ldev ? cpu_to_be64(mdev->ldev->md.uuid[i]) : 0;
>                                      ^^^^^^^^^^
> Old check.
> 
>    844		spin_unlock_irq(&mdev->ldev->md.uuid_lock);
>                                  ^^^^^^^^^^^^
> New dereference.
> 
>    845
> 
> regards,
> dan carpenter
