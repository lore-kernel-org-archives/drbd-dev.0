Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
	[209.85.208.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D6F88420629
	for <drbd-dev@lists.linbit.com>; Thu, 23 Sep 2021 13:18:37 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id c21so21985693edj.0
	for <drbd-dev@lists.linbit.com>; Thu, 23 Sep 2021 04:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNP_+VFUJfijkem8TWr1ptkJXbdZryuvbnpLY1GCBgPvKzdzw@mail.gmail.com>
	<20210915110743.1271706-1-rui.xu@easystack.cn>
	<CAGNP_+XVmkZ5jAuh_jpDkdddzNfDNW00cTiUDRgGh9R=7Bv7ng@mail.gmail.com>
In-Reply-To: <CAGNP_+XVmkZ5jAuh_jpDkdddzNfDNW00cTiUDRgGh9R=7Bv7ng@mail.gmail.com>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Thu, 23 Sep 2021 13:18:26 +0200
Message-ID: <CAGNP_+V_6m5b=FHDnUEw6RHdKuC8Gu_WzcvpEsZv=ESHLXFv_g@mail.gmail.com>
To: Rui Xu <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3] drbd: fix a race condition in
	update_sync_bits() and receive_bitmap()
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

This was included in drbd-9.0 with:
https://github.com/LINBIT/drbd/commit/a9a54e48f5d6eb0b06d5832246ff7da2305fe5e1

And merged forward into master with:
https://github.com/LINBIT/drbd/commit/6cb88bf2af4a5628d09276e92f905405d01e0270
