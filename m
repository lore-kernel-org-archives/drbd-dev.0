Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Dan Carpenter <error27@gmail.com>
Date: Thu,  1 Apr 2010 10:56:39 +0200
Message-Id: <9736574BB1380E.7050404@linbit.com>
In-Reply-To: <20100327145950.GG5069@bicker>
References: <20100327145950.GG5069@bicker>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Jens Axboe <jens.axboe@oracle.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [patch] drbd: potential null dereference
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Dan, 

Thanks for the work with the static analyzer, but the patch is
bogus. The lc_element_by_index() function causes a BUG_ON before
returning a NULL. The next mail contains a patch that removes
the unnecessary conditional expression operator.

Philipp Reisner (1):
  drbd: lc_element_by_index() never returns NULL

 drivers/block/drbd/drbd_actlog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

