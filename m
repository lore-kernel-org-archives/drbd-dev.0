Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 19 Feb 2014 10:49:06 +0100
Message-Id: <1392803347-6075-1-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <20140218202054.GD25515@kernel.dk>
References: <20140218202054.GD25515@kernel.dk>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] Fix smatch warning
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

Hi Jens,

After I posted to pull request, we got a report about a smatch warning,
which was not CCed to you or the lkml.

It is not a bug right now, but a mistake that could easily become a bug
as we move forward. Normally I would keep this in my queue until the next
batch. Just to be prepared in case the janitors run smatch on your tree:
Please pull it into for-3.15/drivers.

Andreas Gruenbacher (1):
  drbd: Fix future possible NULL pointer dereference

 drivers/block/drbd/drbd_nl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.9.5
