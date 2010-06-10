Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C87931087075
	for <drbd-dev@lists.linbit.com>; Thu, 10 Jun 2010 09:45:32 +0200 (CEST)
Resent-Message-ID: <20100610074532.GB6098@soda.linbit>
Message-ID: <4C107FBF.9050209@kernel.dk>
Date: Thu, 10 Jun 2010 08:01:35 +0200
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
References: <20100610135203.4649453a.sfr@canb.auug.org.au>
In-Reply-To: <20100610135203.4649453a.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] linux-next: manual merge of the drbd tree with the
	block trees
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2010-06-10 05:52, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the drbd tree got a conflicts in
> fs/fs-writeback.c against the block tree.
> 
> It looks like the block tree has moved under the drbd tree again.  I used
> the version of this file from the block tree for today.

I'm starting to think that it would be a little easier if you did not
pull the drbd tree, I really should be pulling that into my -next branch
instead.

-- 
Jens Axboe

