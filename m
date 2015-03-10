Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8205F1050584
	for <drbd-dev@lists.linbit.com>; Tue, 10 Mar 2015 11:54:46 +0100 (CET)
Date: Tue, 10 Mar 2015 11:54:45 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Fabio Estevam <festevam@gmail.com>
Message-ID: <20150310105445.GC3961@soda.linbit>
References: <1425752066-25196-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425752066-25196-1-git-send-email-festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [DRBD-user] [PATCH] drbd: drbd_bitmap: Avoid name
	collision
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

On Sat, Mar 07, 2015 at 03:14:26PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Building for ARM64 leads to the following build warnings:
> 
>   CC      drivers/block/drbd/drbd_bitmap.o
> drivers/block/drbd/drbd_bitmap.c:483:0: warning: "BITS_PER_PAGE" redefined
>  #define BITS_PER_PAGE  (1UL << (PAGE_SHIFT + 3))


Apparently there are more than one consumer of "BITS_PER_PAGE".
The commit that moved the now conflicting definition to pid_namespace.h
itself already refered to a similar "redefined" warning.

Would it not make more sense to have one such definition next to PAGE_SIZE?
Or somewhere central, anyways?

> Fix the warnings by using BITS_PER_PAGE_DRBD and BITS_PER_PAGE_MASK_DRBD 
> definitions to avoid the name collision.

Other than that:
Ack.

	Lars Ellenberg
