Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E362B106500E
	for <drbd-dev@lists.linbit.com>; Tue,  9 Mar 2010 15:50:13 +0100 (CET)
Date: Tue, 9 Mar 2010 15:50:13 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20100309145013.GJ4199@soda.linbit>
References: <alpine.LFD.2.00.1003090743100.22662@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.00.1003090743100.22662@localhost>
Subject: Re: [Drbd-dev] [PATCH] DRBD: Delete superfluous defn of "ARRY_SIZE".
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Mar 09, 2010 at 07:44:36AM -0500, Robert P. J. Day wrote:
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
>   given that the macro is misspelled, no one appears to use it, and
> there already is an ARRAY_SIZE() macro defined in kernel.h for general
> use, there's really no reason for this to be here.
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index ab871e0..36508ea 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -156,8 +156,6 @@ static const struct block_device_operations drbd_ops = {
>  	.release = drbd_release,
>  };
> 
> -#define ARRY_SIZE(A) (sizeof(A)/sizeof(A[0]))


Wow.
Thats a leftover from 2001 ... linux-2.4.4 days.
And even then it was unused, and the ARRAY_SIZE macro
was already in linux/kernel.h 

 ;-)

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
