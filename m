Return-Path: <BATV+b29930b5fa9b2b8daadf+7928+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 61BAB160917
	for <drbd-dev@lists.linbit.com>; Thu,  8 May 2025 09:27:34 +0200 (CEST)
Date: Wed, 7 May 2025 23:45:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: transferring bvecs over the network in drbd
Message-ID: <aBxTHl8UIwr9Ehuv@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi all,

I recently went over code that directly access the bio_vec bv_page/
bv_offset members and the code in _drbd_send_bio/_drbd_send_zc_bio
came to my attention.

It iterates the bio to kmap all segments, and then either does a
sock_sendmsg on a newly created kvec iter, or one one a new bvec iter
for each segment.  The former can't work on highmem systems and both
versions are rather inefficient.

What is preventing drbd from doing a single sock_sendmsg with the
bvec payload?  nvme-tcp (nvme_tcp_init_iter0 is a good example for
doing that, or the sunrpc svcsock code using it's local bvec list
(svc_tcp_sendmsg).
