Return-Path: <BATV+b2e8b8bc6a48568b3498+7499+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7FDA54201A7
	for <drbd-dev@lists.linbit.com>; Tue,  5 Mar 2024 14:40:43 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Subject: drbd atomic queue limits conversion
Date: Tue,  5 Mar 2024 06:40:34 -0700
Message-Id: <20240305134041.137006-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, drbd-dev@lists.linbit.com
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

Hi Jens,

this is a standalone resend of the drbd queue limits conversion.
Philipp said Linbit has reviewed and tested it, and they'll hopefully
provide the formal tags for that in a bit.

Diffstat:
 drbd_main.c |   13 ++-
 drbd_nl.c   |  210 ++++++++++++++++++++++++++++--------------------------------
 2 files changed, 110 insertions(+), 113 deletions(-)
