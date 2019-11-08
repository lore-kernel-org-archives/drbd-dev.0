Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
	[209.85.166.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 306B5420347
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2019 15:04:24 +0100 (CET)
Received: by mail-io1-f68.google.com with SMTP id g15so6457416iob.9
	for <drbd-dev@lists.linbit.com>; Fri, 08 Nov 2019 06:04:24 -0800 (PST)
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Dan Carpenter <dan.carpenter@oracle.com>
References: <20191107074847.GA11695@mwanda> <6906816.cRlsrm7Sor@fat-tyre>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <17fea9d1-39f8-1d91-5509-5f520009b9c9@kernel.dk>
Date: Fri, 8 Nov 2019 06:54:43 -0700
MIME-Version: 1.0
In-Reply-To: <6906816.cRlsrm7Sor@fat-tyre>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block: drbd: remove a stay unlock in
 __drbd_send_protocol()
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

On 11/8/19 3:46 AM, Philipp Reisner wrote:
> Hi Dan,
> 
> yes, your patch it obviously correct. The comment you are
> referring to is badly worded. We will remove it.
> 
> Jens,
> 
> are you taking this patch as it is?

Yep, I'll queue it up.

-- 
Jens Axboe

