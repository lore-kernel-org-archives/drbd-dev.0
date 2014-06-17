Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D9402101AC75
	for <drbd-dev@lists.linbit.com>; Tue, 17 Jun 2014 12:53:48 +0200 (CEST)
Date: Tue, 17 Jun 2014 12:53:48 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Martin Kepplinger <martink@posteo.de>
Message-ID: <20140617105348.GH28884@soda.linbit>
References: <alpine.DEB.2.02.1406160225510.30205@chino.kir.corp.google.com>
	<1402988047-16364-1-git-send-email-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1402988047-16364-1-git-send-email-martink@posteo.de>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
	rientjes@google.com
Subject: Re: [Drbd-dev] [PATCH v2] drbd: change one-bit bitfield to be an
 unsigned int
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

On Tue, Jun 17, 2014 at 08:54:07AM +0200, Martin Kepplinger wrote:
> The one-bit bitfields are assigned true (1) or false (0) and checked
> for them respectively. While it should work either way and -1 is true
> as well it is more clear to see what's going on when using an unsigned int
> because 1 doesn't silently become -1 behind the label true.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
> Thanks for looking at it. This is more of a question: Does this make sense
> to you now? I can be mistaken. It just wasn't totally clear to me at first
> sight and even though it should be, why not try to improve it.
> 
> sparse called it 'dubious' before the change.
> 
> (built but untested)

Patch is completely pointless, really,
and I don't get the motivation for it at all.
BUT.

If it makes someone happy,
and since all of our other bitfields in fact are declared "unsigned xyz:N",
for consistency we can make this unsigned as well.
Will probably fold this with some upcoming change in that struct anyways.

    Lars

> 
>  drivers/block/drbd/drbd_interval.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
> index f38fcb0..8d670e6 100644
> --- a/drivers/block/drbd/drbd_interval.h
> +++ b/drivers/block/drbd/drbd_interval.h
> @@ -9,8 +9,8 @@ struct drbd_interval {
>  	sector_t sector;	/* start sector of the interval */
>  	unsigned int size;	/* size in bytes */
>  	sector_t end;		/* highest interval end in subtree */
> -	int local:1		/* local or remote request? */;
> -	int waiting:1;
> +	unsigned int local:1;	/* local or remote request? */
> +	unsigned int waiting:1;
>  };
>  
>  static inline void drbd_clear_interval(struct drbd_interval *i)
