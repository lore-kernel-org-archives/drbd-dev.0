Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
	[209.85.216.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7149E420369
	for <drbd-dev@lists.linbit.com>; Sun,  2 Apr 2023 04:28:45 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id d13so24267582pjh.0
	for <drbd-dev@lists.linbit.com>; Sat, 01 Apr 2023 19:28:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
References: <20230330102744.2128122-1-christoph.boehmwalder@linbit.com>
Message-Id: <168040252316.200172.16639804916232097700.b4-ty@kernel.dk>
Date: Sat, 01 Apr 2023 20:28:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 0/7] Assorted DRBD refactoring
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


On Thu, 30 Mar 2023 12:27:37 +0200, Christoph Böhmwalder wrote:
> Another set of "backported" DRBD refactoring patches to bring the
> in-tree version closer to out-of-tree.
> 
> These are (hopefully) no-ops, pretty much just preparation for future
> upstreaming work.
> 
> Changes since v2:
> - Rebase to for-6.4/block
> 
> [...]

Applied, thanks!

[1/7] genetlink: make _genl_cmd_to_str static
      commit: 0d11f3cf279c5ad20a41f29242f170ba3c02f2da
[2/7] drbd: Rip out the ERR_IF_CNT_IS_NEGATIVE macro
      commit: 33f7d31673eb43298b25b0cca30acc487e8a332a
[3/7] drbd: Add peer device parameter to whole-bitmap I/O handlers
      commit: 8164dd6c8ae158ec0740bf37f0f14645a1fb5355
[4/7] drbd: INFO_bm_xfer_stats(): Pass a peer device argument
      commit: 5e54c2a6010bc88e33a5a66aa16c95fa5d017065
[5/7] drbd: drbd_uuid_compare: pass a peer_device
      commit: db445db1cde540f819265dcae2d916a35616bda0
[6/7] drbd: pass drbd_peer_device to __req_mod
      commit: ad878a0d8815a291a1cbb2dc8279dc2910c999cc
[7/7] drbd: Pass a peer device to the resync and online verify functions
      commit: 0d11f3cf279c5ad20a41f29242f170ba3c02f2da

Best regards,
-- 
Jens Axboe



