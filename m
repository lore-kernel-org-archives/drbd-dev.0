Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 24633101AC43
	for <drbd-dev@lists.linbit.com>; Wed, 24 Jul 2019 13:48:41 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id z1so46612132wru.13
	for <drbd-dev@lists.linbit.com>; Wed, 24 Jul 2019 04:48:41 -0700 (PDT)
Date: Wed, 24 Jul 2019 13:48:39 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <20190724114839.fl3ldycrn3zwfgaw@rck.sh>
References: <20190724034916.28703-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724034916.28703-1-baijiaju1990@gmail.com>
Cc: axboe@kernel.dk, philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 1/2] block: drbd: Fix a possible null-pointer
 dereference in receive_protocol()
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

On Wed, Jul 24, 2019 at 11:49:16AM +0800, Jia-Ju Bai wrote:
> In receive_protocol(), when crypto_alloc_shash() on line 3754 fails,
> peer_integrity_tfm is NULL, and error handling code is executed.
> In this code, crypto_free_shash() is called with NULL, which can cause a
> null-pointer dereference, because:
> crypto_free_shash(NULL)
>     crypto_ahash_tfm(NULL)
>         "return &NULL->base"
> 
> To fix this bug, peer_integrity_tfm is checked before calling
> crypto_free_shash().
> 
> This bug is found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Roland Kammerer <roland.kammerer@linbit.com>
