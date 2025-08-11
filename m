Return-Path: <ehagberg@janestreet.com>
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com
	[64.215.233.18])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E9E3316064E
	for <drbd-dev@lists.linbit.com>; Mon, 11 Aug 2025 15:22:13 +0200 (CEST)
From: Eric Hagberg <ehagberg@janestreet.com>
To: christoph.boehmwalder@linbit.com
Subject: [PATCH] drbd: Remove the open-coded page pool
Date: Mon, 11 Aug 2025 09:16:02 -0400
Message-Id: <20250811131602.978555-1-ehagberg@janestreet.com>
In-Reply-To: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
References: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Eric Hagberg <ehagberg@janestreet.com>,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com
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

This patch has ben running on thousands of hosts here and we've not seen the memory leak that
was happening previously.

Tested-by: Eric Hagberg <ehagberg@janestreet.com>
