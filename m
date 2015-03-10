Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 850771028A43
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:06:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 463F644D2AE
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:06:16 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0x_5QU_8Uihq for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:06:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2365444D389
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:06:16 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2C-k-VZ01Jn3 for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:06:16 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id F016544D2AE
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:06:15 +0100 (CET)
Resent-Message-ID: <20150312230615.GJ3961@soda.linbit>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
	[209.85.217.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8397F105059A
	for <drbd-dev@lists.linbit.com>; Tue, 10 Mar 2015 17:12:35 +0100 (CET)
Received: by lbvn10 with SMTP id n10so2823998lbv.11
	for <drbd-dev@lists.linbit.com>; Tue, 10 Mar 2015 09:12:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150310105445.GC3961@soda.linbit>
References: <1425752066-25196-1-git-send-email-festevam@gmail.com>
	<20150310105445.GC3961@soda.linbit>
Date: Tue, 10 Mar 2015 13:06:59 -0300
Message-ID: <CAOMZO5AbCuWnL5UXH+sbwnR3915cFyoGyM8X1MZBpTUsRBoUrQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
To: Fabio Estevam <festevam@gmail.com>, drbd-dev@lists.linbit.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Drbd-dev] [DRBD-user] [PATCH] drbd: drbd_bitmap: Avoid name
	collision
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

On Tue, Mar 10, 2015 at 7:54 AM, Lars Ellenberg
<lars.ellenberg@linbit.com> wrote:

> Apparently there are more than one consumer of "BITS_PER_PAGE".
> The commit that moved the now conflicting definition to pid_namespace.h
> itself already refered to a similar "redefined" warning.
>
> Would it not make more sense to have one such definition next to PAGE_SIZE?
> Or somewhere central, anyways?

What about this instead?

--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/drbd.h>
 #include <linux/slab.h>
+#include <linux/pid_namespace.h>
 #include <asm/kmap_types.h>

 #include "drbd_int.h"
@@ -479,8 +480,6 @@ void drbd_bm_cleanup(struct drbd_device *device)
  * this masks out the remaining bits.
  * Returns the number of bits cleared.
  */
-#define BITS_PER_PAGE          (1UL << (PAGE_SHIFT + 3))
-#define BITS_PER_PAGE_MASK     (BITS_PER_PAGE - 1)
 #define BITS_PER_LONG_MASK     (BITS_PER_LONG - 1)
 static int bm_clear_surplus(struct drbd_bitmap *b)
 {
