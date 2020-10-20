Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 993D54202B6
	for <drbd-dev@lists.linbit.com>; Tue, 20 Oct 2020 16:07:29 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id n15so2324273wrq.2
	for <drbd-dev@lists.linbit.com>; Tue, 20 Oct 2020 07:07:29 -0700 (PDT)
To: Lukas Wunner <lukas@wunner.de>
References: <1c700caab1ce71fa144116541471b3f7bb4629fa.1602432204.git.lukas@wunner.de>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <1acf7b3a-6188-4c89-d07a-be162a598c77@linbit.com>
Date: Tue, 20 Oct 2020 16:06:27 +0200
MIME-Version: 1.0
In-Reply-To: <1c700caab1ce71fa144116541471b3f7bb4629fa.1602432204.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Michael Hierweck <michael.hierweck@hostsharing.net>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Elimar Riesebieter <riesebie@lxtec.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH drbd-9.0] compat: __vmalloc() pgprot argument
 was removed in v5.8
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

On 10/11/20 6:07 PM, Lukas Wunner wrote:
> Commit torvalds/linux@88dca4ca5a93 removed the pgprot argument from
> __vmalloc().  There's a single invocation in drbd_bitmap.c.  Drop the
> argument to stay as close as possible to upstream and apply a cocci
> patch for older kernels which reinstates the additional argument.
> 
> Reported-by: Michael Hierweck <michael.hierweck@hostsharing.net>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>   drbd/drbd-kernel-compat/cocci/__vmalloc__no_has_2_params.cocci | 3 +++
>   drbd/drbd-kernel-compat/gen_patch_names.c                      | 3 +++
>   drbd/drbd-kernel-compat/tests/__vmalloc_has_2_params.c         | 8 ++++++++
>   drbd/drbd_bitmap.c                                             | 3 +--
>   4 files changed, 15 insertions(+), 2 deletions(-)
>   create mode 100644 drbd/drbd-kernel-compat/cocci/__vmalloc__no_has_2_params.cocci
>   create mode 100644 drbd/drbd-kernel-compat/tests/__vmalloc_has_2_params.c
> 
> diff --git a/drbd/drbd-kernel-compat/cocci/__vmalloc__no_has_2_params.cocci b/drbd/drbd-kernel-compat/cocci/__vmalloc__no_has_2_params.cocci
> new file mode 100644
> index 0000000..335581d
> --- /dev/null
> +++ b/drbd/drbd-kernel-compat/cocci/__vmalloc__no_has_2_params.cocci
> @@ -0,0 +1,3 @@
> +@@ expression S, G; @@
> +- __vmalloc(S, G)
> ++ __vmalloc(S, G, PAGE_KERNEL)
> diff --git a/drbd/drbd-kernel-compat/gen_patch_names.c b/drbd/drbd-kernel-compat/gen_patch_names.c
> index 8d5af81..86e9d02 100644
> --- a/drbd/drbd-kernel-compat/gen_patch_names.c
> +++ b/drbd/drbd-kernel-compat/gen_patch_names.c
> @@ -323,6 +323,9 @@ int main(int argc, char **argv)
>   	patch(1, "part_stat_h", true, false,
>   	      COMPAT_HAVE_PART_STAT_H, "present");
>   
> +	patch(1, "__vmalloc", true, false,
> +	      COMPAT___VMALLOC_HAS_2_PARAMS, "has_2_params");
> +
>   /* #define BLKDEV_ISSUE_ZEROOUT_EXPORTED */
>   /* #define BLKDEV_ZERO_NOUNMAP */
>   
> diff --git a/drbd/drbd-kernel-compat/tests/__vmalloc_has_2_params.c b/drbd/drbd-kernel-compat/tests/__vmalloc_has_2_params.c
> new file mode 100644
> index 0000000..00e2c28
> --- /dev/null
> +++ b/drbd/drbd-kernel-compat/tests/__vmalloc_has_2_params.c
> @@ -0,0 +1,8 @@
> +/* { "version": "v5.8-rc1", "commit": "88dca4ca5a93d2c09e5bbc6a62fbfc3af83c4fca", "comment": "pgprot argument to __vmalloc was removed", "author": "Christoph Hellwig <hch@lst.de>", "date": "Mon Jun 1 21:51:40 2020 -0700" } */
> +
> +#include <linux/vmalloc.h>
> +
> +void foo(void)
> +{
> +	__vmalloc(0, 0);
> +}
> diff --git a/drbd/drbd_bitmap.c b/drbd/drbd_bitmap.c
> index 4dbed26..e23ed5a 100644
> --- a/drbd/drbd_bitmap.c
> +++ b/drbd/drbd_bitmap.c
> @@ -366,9 +366,7 @@ static struct page **bm_realloc_pages(struct drbd_bitmap *b, unsigned long want)
>   	new_pages = kzalloc(bytes, GFP_NOIO | __GFP_NOWARN);
>   	if (!new_pages) {
>   		new_pages = __vmalloc(bytes,
> -				GFP_NOIO | __GFP_HIGHMEM | __GFP_ZERO,
> -				PAGE_KERNEL);
> +				      GFP_NOIO | __GFP_HIGHMEM | __GFP_ZERO);
>   		if (!new_pages)
>   			return NULL;
>   	}
> 

Amazing. Very cool to have someone external figure out and contribute to 
such a complex and niche part of drbd – it's much appreciated!

Applied internally, will be released with the next version. Thanks again!

Regards,
Christoph

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
