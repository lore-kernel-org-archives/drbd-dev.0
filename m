Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (c-134-76-155.b.dial.de.ignite.net [62.134.76.155])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 556A114313
	for <drbd-dev@lists.linbit.com>; Fri, 24 Sep 2004 13:43:07 +0200 (CEST)
Date: Fri, 24 Sep 2004 13:40:34 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <FzrmeyosCK+tKKTx6KNpxh8=lge@web.de>
References: <20040924111354.399A13BE6E@garcon.linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924111354.399A13BE6E@garcon.linbit.com>
Subject: [Drbd-dev] Re: [DRBD-cvs] r1559 - in branches/drbd-0.7: drbd user
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


[ bitte reply-to in drbd-cvs auf drbd-dev setzen ]

/ 2004-09-24 13:13:54 +0200
\ svn@svn.drbd.org:
> Author: phil
> Date: 2004-09-24 13:13:51 +0200 (Fri, 24 Sep 2004)
> New Revision: 1559
> 
> Modified:
>    branches/drbd-0.7/drbd/drbd_int.h
>    branches/drbd-0.7/user/drbdsetup.c
> Log:
> Made the "Warnung: comparison is always false due to limited 
> range of data type" warning go away on 32Bit platforms whe
> CONFIG_LBD ist not set.
> 
> 
> Modified: branches/drbd-0.7/drbd/drbd_int.h
> ===================================================================
> --- branches/drbd-0.7/drbd/drbd_int.h	2004-09-23 19:03:21 UTC (rev 1558)
> +++ branches/drbd-0.7/drbd/drbd_int.h	2004-09-24 11:13:51 UTC (rev 1559)
> @@ -968,8 +968,12 @@
>  #define BM_EXT_PER_SECT	    ( 512 / BM_BYTES_PER_EXTENT )        //   4
>   */
>  
> -#define DRBD_MAX_SECTORS \
> +#if ( !defined(CONFIG_LBD) ) && ( BITS_PER_LONG == 32 )
> +# define DRBD_MAX_SECTORS (0xffffffffLU)
> +#else 
> +# define DRBD_MAX_SECTORS \
>            ( (MD_RESERVED_SIZE*2LL - MD_BM_OFFSET) * (1LL<<(BM_EXT_SIZE_B-9)) )
> +#endif

oh well...
why not simple (sector_t) ?
just because it is then 0xffdc0000 instead of 0xffffffff ?
so what ...

	Lars Ellenberg
