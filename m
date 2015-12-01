Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 179431019A36
	for <drbd-dev@lists.linbit.com>; Tue,  1 Dec 2015 09:55:39 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Fabian Frederick <fabf@skynet.be>
Date: Tue, 01 Dec 2015 09:55:17 +0100
Message-ID: <13681562.iEXrDB2gtG@fat-tyre>
In-Reply-To: <1448659575-13485-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/21] drbd: clean-up patchset
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

Hi Fabian,

I will take these patches and send them towards upstream in the
next round. (Probably squashing them into a smaller number of
patches while doing so)

Best regards,
 Phil

Am Freitag, 27. November 2015, 22:26:05 schrieb Fabian Frederick:
> This small patchset does some code clean-up in drivers/block/drbd tree.
> 
> Fabian Frederick (21):
>   drbd: debugfs: constify drbd_version_fops
>   drbd: simplify drbd_md_set_sector_offsets()
>   drbd: use seq_put instead of seq_print where possible
>   drbd: include linux/uaccess.h instead of asm/uaccess.h
>   drbd: rework is_valid_state()
>   drbd: use const char * const for drbd strings
>   drbd: kerneldoc warning fix in w_e_end_data_req()
>   drbd: use unsigned for one bit fields
>   drbd: use bool for peer is_ states
>   drbd: fix typo
>   drbd: use | for bitmask combination
>   drbd: use true/false for bool
>   drbd: fix drbd_bm_init() comments
>   drbd: clean-up receive_SyncParam()
>   drbd: introduce peer state union
>   drbd: fix maybe_pull_ahead() locking comments
>   drbd: use bool for growing
>   drbd: remove redundant declarations
>   drbd: remove bm_vk_free()
>   drbd: remove unused definitions
>   drbd: replace if/BUG by BUG_ON
> 
>  drivers/block/drbd/drbd_bitmap.c   | 19 +++-----
>  drivers/block/drbd/drbd_debugfs.c  |  2 +-
>  drivers/block/drbd/drbd_int.h      |  7 ---
>  drivers/block/drbd/drbd_interval.h | 14 +++---
>  drivers/block/drbd/drbd_main.c     |  2 +-
>  drivers/block/drbd/drbd_nl.c       | 37 ++++++++--------
>  drivers/block/drbd/drbd_proc.c     | 30 ++++++-------
>  drivers/block/drbd/drbd_receiver.c | 22 +++++-----
>  drivers/block/drbd/drbd_req.c      |  2 +-
>  drivers/block/drbd/drbd_state.c    | 90
> +++++++++++++++++--------------------- drivers/block/drbd/drbd_state.h    |
>  2 +-
>  drivers/block/drbd/drbd_strings.c  |  8 ++--
>  drivers/block/drbd/drbd_worker.c   |  9 ++--
>  include/linux/drbd.h               |  8 ++++
>  14 files changed, 116 insertions(+), 136 deletions(-)

