Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
	[209.85.221.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 831BF4201A5
	for <drbd-dev@lists.linbit.com>; Thu,  6 Oct 2022 11:07:56 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id n12so1656027wrp.10
	for <drbd-dev@lists.linbit.com>; Thu, 06 Oct 2022 02:07:56 -0700 (PDT)
Message-ID: <892bcf4d-70d9-8833-9449-c55fa719158e@linbit.com>
Date: Thu, 6 Oct 2022 11:07:54 +0200
MIME-Version: 1.0
Content-Language: en-US
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
References: <20221005214844.2699-1-Jason@zx2c4.com>
	<20221005214844.2699-2-Jason@zx2c4.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221005214844.2699-2-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v1 1/5] treewide: use prandom_u32_max() when
	possible
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

On 05.10.22 23:48, Jason A. Donenfeld wrote:
> Rather than incurring a division or requesting too many random bytes for
> the given range, use the prandom_u32_max() function, which only takes
> the minimum required bytes from the RNG and avoids divisions.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/x86/mm/pat/cpa-test.c                    |  4 +-
>  crypto/testmgr.c                              | 86 +++++++++----------
>  drivers/block/drbd/drbd_receiver.c            |  4 +-

For the drbd part:

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

>  drivers/infiniband/core/cma.c                 |  2 +-
>  drivers/infiniband/hw/cxgb4/id_table.c        |  4 +-
>  drivers/infiniband/hw/hns/hns_roce_ah.c       |  5 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c        |  3 +-
>  drivers/mmc/core/core.c                       |  4 +-
>  drivers/mmc/host/dw_mmc.c                     |  2 +-
>  drivers/mtd/nand/raw/nandsim.c                |  4 +-
>  drivers/mtd/tests/mtd_nandecctest.c           | 10 +--
>  drivers/mtd/tests/stresstest.c                | 17 +---
>  drivers/mtd/ubi/debug.c                       |  2 +-
>  drivers/mtd/ubi/debug.h                       |  6 +-
>  drivers/net/ethernet/broadcom/cnic.c          |  3 +-
>  .../chelsio/inline_crypto/chtls/chtls_io.c    |  4 +-
>  drivers/net/hamradio/baycom_epp.c             |  2 +-
>  drivers/net/hamradio/hdlcdrv.c                |  2 +-
>  drivers/net/hamradio/yam.c                    |  2 +-
>  drivers/net/phy/at803x.c                      |  2 +-
>  .../broadcom/brcm80211/brcmfmac/p2p.c         |  2 +-
>  .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
>  drivers/scsi/fcoe/fcoe_ctlr.c                 |  4 +-
>  drivers/scsi/qedi/qedi_main.c                 |  2 +-
>  fs/ceph/inode.c                               |  2 +-
>  fs/ceph/mdsmap.c                              |  2 +-
>  fs/ext4/super.c                               |  7 +-
>  fs/f2fs/gc.c                                  |  2 +-
>  fs/f2fs/segment.c                             |  8 +-
>  fs/ubifs/debug.c                              |  8 +-
>  fs/ubifs/lpt_commit.c                         | 14 +--
>  fs/ubifs/tnc_commit.c                         |  2 +-
>  fs/xfs/libxfs/xfs_alloc.c                     |  2 +-
>  fs/xfs/libxfs/xfs_ialloc.c                    |  2 +-
>  fs/xfs/xfs_error.c                            |  2 +-
>  kernel/time/clocksource.c                     |  2 +-
>  lib/fault-inject.c                            |  2 +-
>  lib/find_bit_benchmark.c                      |  4 +-
>  lib/reed_solomon/test_rslib.c                 |  6 +-
>  lib/sbitmap.c                                 |  4 +-
>  lib/test_list_sort.c                          |  2 +-
>  lib/test_vmalloc.c                            | 17 +---
>  net/ceph/mon_client.c                         |  2 +-
>  net/ceph/osd_client.c                         |  2 +-
>  net/core/neighbour.c                          |  2 +-
>  net/core/pktgen.c                             | 43 +++++-----
>  net/core/stream.c                             |  2 +-
>  net/ipv4/igmp.c                               |  6 +-
>  net/ipv4/inet_connection_sock.c               |  2 +-
>  net/ipv4/inet_hashtables.c                    |  2 +-
>  net/ipv6/addrconf.c                           |  8 +-
>  net/ipv6/mcast.c                              | 10 +--
>  net/netfilter/ipvs/ip_vs_twos.c               |  4 +-
>  net/packet/af_packet.c                        |  2 +-
>  net/sched/act_gact.c                          |  2 +-
>  net/sched/act_sample.c                        |  2 +-
>  net/sched/sch_netem.c                         |  4 +-
>  net/sctp/socket.c                             |  2 +-
>  net/sunrpc/cache.c                            |  2 +-
>  net/sunrpc/xprtsock.c                         |  2 +-
>  net/tipc/socket.c                             |  2 +-
>  net/xfrm/xfrm_state.c                         |  2 +-
>  62 files changed, 173 insertions(+), 196 deletions(-)
> 
[...]
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index af4c7d65490b..d8b1417dc503 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -781,7 +781,7 @@ static struct socket *drbd_wait_for_connect(struct drbd_connection *connection,
>  
>  	timeo = connect_int * HZ;
>  	/* 28.5% random jitter */
> -	timeo += (prandom_u32() & 1) ? timeo / 7 : -timeo / 7;
> +	timeo += prandom_u32_max(2) ? timeo / 7 : -timeo / 7;
>  
>  	err = wait_for_completion_interruptible_timeout(&ad->door_bell, timeo);
>  	if (err <= 0)
> @@ -1004,7 +1004,7 @@ static int conn_connect(struct drbd_connection *connection)
>  				drbd_warn(connection, "Error receiving initial packet\n");
>  				sock_release(s);
>  randomize:
> -				if (prandom_u32() & 1)
> +				if (prandom_u32_max(2))
>  					goto retry;
>  			}
>  		}[...]

(Had to cut out most of the CC list because Google complains about "too many
recipients").

--
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
