Return-Path: <lars.ellenberg@linbit.com>
Date: Tue, 6 Sep 2011 19:16:17 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Michal Marek <mmarek@suse.cz>
Message-ID: <20110906171617.GD4449@barkeeper1-xen.linbit>
References: <1315310652-19078-1-git-send-email-mmarek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1315310652-19078-1-git-send-email-mmarek@suse.cz>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix build on bigendian
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 06, 2011 at 02:04:12PM +0200, Michal Marek wrote:
> Remove the superfluous <asm-generic/bitops/le.h> include and fix the
> have_find_next_zero_bit_le test ('NULL' undeclared).

Thanks, but...

Hm. That may help you get it working there.
But it will likely break for other still supported kernel versions.

We probably need to figure out a different fix.

> Signed-off-by: Michal Marek <mmarek@suse.cz>
> ---
>  drbd/compat/tests/have_find_next_zero_bit_le.c |    2 +-
>  drbd/drbd_bitmap.c                             |    2 --
>  2 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drbd/compat/tests/have_find_next_zero_bit_le.c b/drbd/compat/tests/have_find_next_zero_bit_le.c
> index 901e4b3..4338511 100644
> --- a/drbd/compat/tests/have_find_next_zero_bit_le.c
> +++ b/drbd/compat/tests/have_find_next_zero_bit_le.c
> @@ -1,5 +1,5 @@
> +#include <linux/stddef.h>
>  #include <linux/bitops.h>
> -#include <asm-generic/bitops/le.h>
>  
>  unsigned long func(void)
>  {
> diff --git a/drbd/drbd_bitmap.c b/drbd/drbd_bitmap.c
> index 342aa08..4d4587e 100644
> --- a/drbd/drbd_bitmap.c
> +++ b/drbd/drbd_bitmap.c
> @@ -30,8 +30,6 @@
>  #include <linux/dynamic_debug.h>
>  #include <asm/kmap_types.h>
>  
> -#include <asm-generic/bitops/le.h>
> -
>  #include "drbd_int.h"
>  
>  /* See the ifdefs and comments inside that header file.
> -- 
> 1.7.6
> 
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
