Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9D783105800A
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 00:51:44 +0200 (CEST)
From: "Tobin C. Harding" <me@tobin.cc>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon,  2 Oct 2017 09:33:59 +1100
Message-Id: <1506897256-14072-1-git-send-email-me@tobin.cc>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/17] lru_cache: checkpatch clean ups
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

Checkpatch clean ups for lib/lru_cache.c

This patch set is intended to test the waters as to whether DRBD wants/accepts checkpatch clean
ups. I know that many maintainers consider such patches as code churn.

I am taking a look at the DRBD code after bumping into Brian at OSSNA in LA.

If you do want/like checkpatch fixes I am happy to do so for drivers/block/drbd/* while I look
around the code base.

I don't know which tree you guys are working off. This series applies on top of Linus' development
tree, commit:

a8c964eacb21288b2dbfa9d80cee5968a3b8fb21

thanks,
Tobin.

Tobin C. Harding (17):
  lru_cache: remove FSF address from licence
  lru_cache: fix licence comment format
  lru_cache: move trailing */ to a separate line
  lru_cache: remove quoted string across lines
  lru_cache: use 'unsigned int' instead of 'unsigned'
  lru_cache: use kcalloc instead of kzalloc with multiply
  lru_cache: clean macro definition
  lru_cache: add blank line after declarations
  lru_cache: remove space after function name
  lru_cache: fix function argument alignment
  lru_cache: remove multiple blank lines
  lru_cache: remove space before tabs
  lru_cache: move constant to the right side of test
  lru_cache: use braces on all arms of statement
  lru_cache: remove unnecessary space before arguments
  lru_cache: add spaces around '|'
  lru_cache: move EXPORT_SYMBOL macro to follow function

 lib/lru_cache.c | 166 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 86 insertions(+), 80 deletions(-)

-- 
2.7.4

