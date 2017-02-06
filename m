Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F08A71056332
	for <drbd-dev@lists.linbit.com>; Mon,  6 Feb 2017 14:43:26 +0100 (CET)
Received: by mail-wm0-f54.google.com with SMTP id v77so115709843wmv.0
	for <drbd-dev@lists.linbit.com>; Mon, 06 Feb 2017 05:43:26 -0800 (PST)
Date: Mon, 6 Feb 2017 14:43:23 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20170206134323.GC16345@soda.linbit>
References: <20170201165532.2605534-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170201165532.2605534-1-arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: avoid clang warning about pointless
 switch statement
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

Ack.

Ok, not exactly "pintless", it's a valid compile time assert for uniq ids,
basically a BUILD_BUG_ON(duplicate-ids). But adding a default clause
there does not hurt.

Thanks,
    Lars


On Wed, Feb 01, 2017 at 05:55:02PM +0100, Arnd Bergmann wrote:
> The drbd code causes warnings that we cannot easily disable when building with clang:
> 
> In file included from drivers/block/drbd/drbd_debugfs.c:10:
> In file included from drivers/block/drbd/drbd_int.h:48:
> In file included from include/linux/drbd_genl_api.h:53:
> In file included from include/linux/genl_magic_struct.h:237:
> include/linux/drbd_genl.h:300:1: warning: no case matching constant switch condition '0'
> 
> There is nothing wrong with the code, and adding 'default:' labels
> in the right place is enough to let clang shut up about the warning.
> 
> Fixes: ec2c35ac1ea2 ("drbd: prepare the transition from connector to genetlink")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/genl_magic_struct.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
> index 6270a56e5edc..c6fbafb834f1 100644
> --- a/include/linux/genl_magic_struct.h
> +++ b/include/linux/genl_magic_struct.h
> @@ -190,6 +190,7 @@ static inline void ct_assert_unique_operations(void)
>  {
>  	switch (0) {
>  #include GENL_MAGIC_INCLUDE_FILE
> +	default:
>  		;
>  	}
>  }
> @@ -208,6 +209,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
>  {
>  	switch (0) {
>  #include GENL_MAGIC_INCLUDE_FILE
> +	default:
>  		;
>  	}
>  }
> @@ -218,6 +220,7 @@ static inline void ct_assert_unique_ ## s_name ## _attributes(void)	\
>  {									\
>  	switch (0) {							\
>  		s_fields						\
> +		default:						\
>  			;						\
>  	}								\
>  }
> -- 
> 2.9.0
