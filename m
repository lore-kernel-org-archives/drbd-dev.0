Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (0122700014.0.fullrate.dk [95.166.99.235])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 67EAD105A797
	for <drbd-dev@lists.linbit.com>; Thu, 22 Apr 2010 14:50:46 +0200 (CEST)
Date: Thu, 22 Apr 2010 14:50:45 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20100422125044.GI27497@kernel.dk>
References: <20100422122719.GH27497@kernel.dk>
	<1271940461-15012-1-git-send-email-philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1271940461-15012-1-git-send-email-philipp.reisner@linbit.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	kernel-janitors@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [patch] drbd: fix memory leak
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Apr 22 2010, Philipp Reisner wrote:
> Hi Jens,
> 
> Please apply the following patch as well.
> 
> PS: I have put both at git://git.drbd.org/linux-2.6-drbd.git for-jens

Thanks, I just hand applied the 2nd one since the first one was already
there.

-- 
Jens Axboe

