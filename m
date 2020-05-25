Return-Path: <BATV+ab9bb8b38cf50d3a9241+6119+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 663BB420235
	for <drbd-dev@lists.linbit.com>; Mon, 25 May 2020 13:30:23 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 25 May 2020 13:29:58 +0200
Message-Id: <20200525113014.345997-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-nvdimm@lists.01.org,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	dm-devel@redhat.com, Nitin Gupta <ngupta@vflare.org>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] block I/O accounting improvements
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

they series contains various improvement for block I/O accounting.  The
first bunch of patches switch the bio based drivers to better accounting
helpers compared to the current mess.  The end contains a fix and various
performanc improvements.  Most of this comes from a series Konstantin
sent a few weeks ago, rebased on changes that landed in your tree since
and my change to always use the percpu version of the disk stats.
