Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] inter-arch PAGE_SIZE problem
Date: Mon, 27 Sep 2004 16:04:18 +0200
References: <P3J8pVXQZJMx4eU9q8DUNEQ=lge@web.de>
In-Reply-To: <P3J8pVXQZJMx4eU9q8DUNEQ=lge@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409271604.18224.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 24. September 2004 14:37 schrieb Lars Ellenberg:
> int drbd_make_request_26(request_queue_t *q, struct bio *bio)
> {
> ...
>   /*
>    * what we "blindly" assume:
>    */
>   D_ASSERT(bio->bi_size > 0);
>   D_ASSERT( (bio->bi_size & 0x1ff) == 0);
>   D_ASSERT(bio->bi_size <= PAGE_SIZE);
>   D_ASSERT(bio->bi_vcnt == 1);
>   D_ASSERT(bio->bi_idx == 0);
>
> oopsie.
> we are going to send PAGE_SIZE requests over the wire,
> but the other side may have a different PAGE_SIZE...
>
> // mirrored write
> int receive_Data(drbd_dev *mdev,Drbd_Header* h)
> {
> ...
>         /* I expect a block to be a multiple of 512 byte, and
>          * no more than 4K (PAGE_SIZE). is this too restrictive?
>          */
>         ERR_IF(data_size == 0) return FALSE;
>         ERR_IF(data_size &  0x1ff) return FALSE;
>         ERR_IF(data_size >  PAGE_SIZE) return FALSE;
>
>
> we need to agree to use fixed 4K, I guess.  optionally negotiate a
> higher "drbd_page_size" during the initial connection handshake.

Right. we should consider this. But I think a general high performace
solution is not neccesary, since cluster of machines with
different PAGE_SIZE are of academic interest only. (IMHO)

I think for drbd-0.8 it is sufficient to inform the user about the fact...

[...]

>
> does that all make sense?

Yes, right!

-philipp
