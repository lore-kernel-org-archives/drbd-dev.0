Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 048AA1019A78
	for <drbd-dev@lists.linbit.com>; Fri, 22 Mar 2013 21:03:33 +0100 (CET)
Date: Fri, 22 Mar 2013 21:03:33 +0100
From: lars.ellenberg@linbit.com
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <20130322200333.GI5231@soda.linbit>
References: <1363713419-17803-1-git-send-email-philipp.reisner@linbit.com>
	<20130322171706.GF1628@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130322171706.GF1628@kernel.dk>
Cc: drbd-dev@lists.linbit.com, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 00/18] RFC: Non blocking submit for activity
 log misses
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

On Fri, Mar 22, 2013 at 11:17:06AM -0600, Jens Axboe wrote:
> On Tue, Mar 19 2013, Philipp Reisner wrote:

> > This patch series improves DRBD's behavior. A submitter is no longer blocked
> > in the case of a AL-miss. For this a dedicated submitter worker is introduced
> > (patch 13).

> Patchset doesn't apply to current tree. 10/18 gets into problems, last
> hunk of drbd_main.c. What is this based on?

I think it is just missing

  commit 56de210245487ef1f1416c8ec9e581ebdd0d32ec
  Author: Tejun Heo <tj@kernel.org>
  Date:   Wed Feb 27 17:04:01 2013 -0800
  
      drbd: convert to idr_alloc()
  
          Convert to the much saner new idr interface.

I'll post an updated 10/18 right away.

This RfC batch was produced from a tree
based more-or-less on your for-3.9-drivers, I think.

We will rebase to your for-3.10/drivers shortly,
and then also post an additional batch of general fixes.

	Lars

