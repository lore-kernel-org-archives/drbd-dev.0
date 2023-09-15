Return-Path: <gustavo@embeddedor.com>
Received: from omta36.uswest2.a.cloudfilter.net
	(omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D82AD4203B2
	for <drbd-dev@lists.linbit.com>; Fri, 15 Sep 2023 22:30:59 +0200 (CEST)
Message-ID: <c2c552ff-c650-1e69-b552-f6f872605526@embeddedor.com>
Date: Fri, 15 Sep 2023 14:24:35 -0600
MIME-Version: 1.0
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <20230915200316.never.707-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915200316.never.707-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
	Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>, linux-hardening@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Annotate struct fifo_buffer with
	__counted_by
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>



On 9/15/23 14:03, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct fifo_buffer.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> Cc: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: drbd-dev@lists.linbit.com
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/block/drbd/drbd_int.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
> index a30a5ed811be..7eecc53fae3d 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -553,7 +553,7 @@ struct fifo_buffer {
>   	unsigned int head_index;
>   	unsigned int size;
>   	int total; /* sum of all values */
> -	int values[];
> +	int values[] __counted_by(size);
>   };
>   extern struct fifo_buffer *fifo_alloc(unsigned int fifo_size);
>   
