Return-Path: <axboe@kernel.dk>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 465CF1050594
	for <drbd-dev@lists.linbit.com>; Wed, 25 Mar 2015 03:09:27 +0100 (CET)
Received: by pagj7 with SMTP id j7so12306576pag.2
	for <drbd-dev@lists.linbit.com>; Tue, 24 Mar 2015 19:09:25 -0700 (PDT)
Message-ID: <5512170B.1090003@kernel.dk>
Date: Tue, 24 Mar 2015 20:01:47 -0600
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
References: <alpine.DEB.2.10.1503241620190.21805@chino.kir.corp.google.com>
	<alpine.DEB.2.10.1503241622090.21805@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.10.1503241622090.21805@chino.kir.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [patch resend 2/3] block,
	drbd: fix drbd_req_new() initialization
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

On 03/24/2015 05:22 PM, David Rientjes wrote:
> mempool_alloc() does not support __GFP_ZERO since elements may come from
> memory that has already been released by mempool_free().
>
> Remove __GFP_ZERO from mempool_alloc() in drbd_req_new() and properly
> initialize it to 0.

This (and the other drbd patch) queued up in for-4.1/drivers, thanks.

-- 
Jens Axboe

