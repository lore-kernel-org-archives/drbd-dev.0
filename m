Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Wed, 26 May 2010 12:05:42 +0200
References: <1274644094-23226-1-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1274644094-23226-1-git-send-email-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201005261205.43018.philipp.reisner@linbit.com>
Cc: Jens Axboe <jens.axboe@oracle.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 2/4] drivers/block/drbd: removed duplicated
	#includes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Sonntag, 23. Mai 2010, um 21:48:13 schrieb Andrea Gelmini:
> drivers/block/drbd/drbd_receiver.c: linux/mm.h is included more than once.
> 
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  drivers/block/drbd/drbd_receiver.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c
> b/drivers/block/drbd/drbd_receiver.c index bc9ab7f..185618f 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -32,7 +32,6 @@
>  #include <linux/fs.h>
>  #include <linux/file.h>
>  #include <linux/in.h>
> -#include <linux/mm.h>
>  #include <linux/memcontrol.h>
>  #include <linux/mm_inline.h>
>  #include <linux/slab.h>

I took the patch, slightly modified. Will go upstream.

Best,
 Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
