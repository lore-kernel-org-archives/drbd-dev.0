Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 22EF01055F55
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1C0C42BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:27 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5VEw1lcJxYwQ for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id EF8B32BEE40
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:26 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zilAwg4UCwIO for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:26 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 999CD2BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:26 +0200 (CEST)
Resent-Message-ID: <20150911132026.GA3436@soda.linbit>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 00D9A105058C
	for <drbd-dev@lists.linbit.com>; Sun, 30 Aug 2015 11:51:47 +0200 (CEST)
Received: by wicpl12 with SMTP id pl12so5012283wic.0
	for <drbd-dev@lists.linbit.com>; Sun, 30 Aug 2015 02:51:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440746842-19029-4-git-send-email-hch@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
	<1440746842-19029-4-git-send-email-hch@lst.de>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Sun, 30 Aug 2015 12:43:19 +0300
Message-ID: <CAFCwf13VzCeJsKtf5aOj0QTT6ciV=7PvPpeezyUjje3rOKQKfg@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: linux-arch@vger.kernel.org, mitake@dcl.info.waseda.ac.jp, arnd@arndb.de,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	oded.gabbay@amd.com, dhowells@redhat.com,
	linux-gpio@vger.kernel.org, eli@mellanox.com,
	james_p_freyensee@linux.intel.com, drbd-dev@lists.linbit.com,
	herbert@gondor.apana.org.au
Subject: Re: [Drbd-dev] [PATCH 3/9] amdkfd: use <linux/mman.h> instead of
	<uapi/asm-generic/mman-common.h>
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

On Fri, Aug 28, 2015 at 10:27 AM, Christoph Hellwig <hch@lst.de> wrote:
>
> The latter is a default version of <asm/mman.h> and not for driver use.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index c991973..c6a1b4c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -31,7 +31,7 @@
>  #include <uapi/linux/kfd_ioctl.h>
>  #include <linux/time.h>
>  #include <linux/mm.h>
> -#include <uapi/asm-generic/mman-common.h>
> +#include <linux/mman.h>
>  #include <asm/processor.h>
>  #include "kfd_priv.h"
>  #include "kfd_device_queue_manager.h"
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index 35b9875..2b65510 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -33,7 +33,7 @@
>  #include <linux/time.h>
>  #include "kfd_priv.h"
>  #include <linux/mm.h>
> -#include <uapi/asm-generic/mman-common.h>
> +#include <linux/mman.h>
>  #include <asm/processor.h>
>
>  /*
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Thanks,
Applied to my -next-fixes tree

     Oded
