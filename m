Return-Path: <lars.ellenberg@linbit.com>
Date: Wed, 15 Jun 2011 12:09:18 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: David Howells <dhowells@redhat.com>
Message-ID: <20110615100918.GC21617@barkeeper1-xen.linbit>
References: <20110614235904.5009.69393.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110614235904.5009.69393.stgit@warthog.procyon.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] DRDB: Fix comparison always false warning
 due to long/long long compare
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Jun 15, 2011 at 12:59:04AM +0100, David Howells wrote:
> Fix warnings of the following nature in the drbd header:
> 
> In file included from drivers/block/drbd/drbd_bitmap.c:32:
> drivers/block/drbd/drbd_int.h: In function 'drbd_get_syncer_progress':
> drivers/block/drbd/drbd_int.h:2234: warning: comparison is always false due to limited range of data
> 
> where mdev->rs_total (an unsigned long) is being compared to 1ULL << 32, which
> is always false on a 32-bit machine.

Ack.  Though you also fell for the most frequent DRBD misspellings in
the subject ;-)

Jens, we will prepare an other tree for you to pull from next week,
with this and a few other small DRBD fixes in it, if that's ok with you.


	Lars

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Philipp Reisner <philipp.reisner@linbit.com>
> cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> cc: drbd-dev@lists.linbit.com
> cc: Jens Axboe <axboe@kernel.dk>
> ---
> 
>  drivers/block/drbd/drbd_int.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
> index ef2ceed..2e0278d 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -2231,7 +2231,7 @@ static inline void drbd_get_syncer_progress(struct drbd_conf *mdev,
>  		 * Note: currently we don't support such large bitmaps on 32bit
>  		 * arch anyways, but no harm done to be prepared for it here.
>  		 */
> -		unsigned int shift = mdev->rs_total >= (1ULL << 32) ? 16 : 10;
> +		unsigned int shift = mdev->rs_total > UINT_MAX ? 16 : 10;
>  		unsigned long left = *bits_left >> shift;
>  		unsigned long total = 1UL + (mdev->rs_total >> shift);
>  		unsigned long tmp = 1000UL - left * 1000UL/total;
