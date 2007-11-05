Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] don't memset null pointer
Date: Mon, 5 Nov 2007 14:07:48 +0100
References: <200711051304.49960.stf_xl@wp.pl>
In-Reply-To: <200711051304.49960.stf_xl@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711051407.49111.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 05 November 2007 13:04:49 Stanislaw Gruszka wrote:
> Hi, this is trivial fix for memset null pointer:
>
> diff --git a/drbd/lru_cache.c b/drbd/lru_cache.c
> index a3171b6..37ab276 100644
> --- a/drbd/lru_cache.c
> +++ b/drbd/lru_cache.c
> @@ -57,8 +57,8 @@ struct lru_cache *lc_alloc(const char *name, unsigned int
> e_count, bytes *= e_count;
>  	bytes += sizeof(struct lru_cache);
>  	lc     = vmalloc(bytes);
> -	memset(lc, 0, bytes);
>  	if (lc) {
> +		memset(lc, 0, bytes);
>  		INIT_LIST_HEAD(&lc->in_use);
>  		INIT_LIST_HEAD(&lc->lru);
>  		INIT_LIST_HEAD(&lc->free);

Thanks!

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
