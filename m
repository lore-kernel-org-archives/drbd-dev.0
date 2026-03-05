Return-Path: <john.g.garry@oracle.com>
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
	[205.220.177.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1D4D61630E4
	for <drbd-dev@lists.linbit.com>; Fri,  6 Mar 2026 02:56:23 +0100 (CET)
Message-ID: <6670e402-8758-4c64-b441-fa7aca40ad8c@oracle.com>
Date: Thu, 5 Mar 2026 22:36:25 +0000
Subject: Re: [PATCH 1/4] block: consecutive blk_status_t error codes
To: Andreas Gruenbacher <agruenba@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20260304190424.291743-1-agruenba@redhat.com>
	<20260304190424.291743-2-agruenba@redhat.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
In-Reply-To: <20260304190424.291743-2-agruenba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

On 04/03/2026 19:04, Andreas Gruenbacher wrote:
> Since commit 9da3d1e912f3 ("block: Add core atomic write support"),
> there is a gap in the blk_status_t codes and block status code 18 is
> unused.  This causes blk_status_to_errno() and blk_status_to_str() to
> return incorrect values for that code. 

Sure, we get the wrong value (for 18), but 18 does not match a valid 
blk_status_t

> Make the blk_status_t codes
> consecutive again to avoid that.
> 
> Fixes: 9da3d1e912f3 ("block: Add core atomic write support")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   include/linux/blk_types.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 8808ee76e73c..89a722d76c28 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -168,7 +168,7 @@ typedef u16 blk_short_t;
>   /*
>    * Invalid size or alignment.
>    */
> -#define BLK_STS_INVAL	((__force blk_status_t)19)
> +#define BLK_STS_INVAL	((__force blk_status_t)18)
>   
>   /**
>    * blk_path_error - returns true if error may be path related

