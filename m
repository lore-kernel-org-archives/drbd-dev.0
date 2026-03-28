Return-Path: <lkp@intel.com>
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A30CB160867
	for <drbd-dev@lists.linbit.com>; Sat, 28 Mar 2026 15:20:38 +0100 (CET)
Date: Sat, 28 Mar 2026 22:20:04 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 20/20] drbd: remove BROKEN for DRBD
Message-ID: <202603282234.zZBLE37a-lkp@intel.com>
References: <20260327223820.2244227-21-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327223820.2244227-21-christoph.boehmwalder@linbit.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 67807fbaf12719fca46a622d759484652b79c7c3]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-mark-as-BROKEN-during-DRBD-9-rework/20260328-153634
base:   67807fbaf12719fca46a622d759484652b79c7c3
patch link:    https://lore.kernel.org/r/20260327223820.2244227-21-christoph.boehmwalder%40linbit.com
patch subject: [PATCH 20/20] drbd: remove BROKEN for DRBD
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260328/202603282234.zZBLE37a-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603282234.zZBLE37a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603282234.zZBLE37a-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/drbd/drbd_transport_rdma.c:618:11: warning: variable 'i' set but not used [-Wunused-but-set-variable]
     618 |         int err, i = 0;
         |                  ^
   1 warning generated.


vim +/i +618 drivers/block/drbd/drbd_transport_rdma.c

bc43430bc671a7 Christoph Böhmwalder 2026-03-27  610  
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  611  
221cfdc61a60c9 Christoph Böhmwalder 2026-03-27  612  static int dtr_recv_bio(struct drbd_transport *transport, struct bio_list *bios, size_t size)
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  613  {
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  614  	struct dtr_transport *rdma_transport =
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  615  		container_of(transport, struct dtr_transport, transport);
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  616  	struct dtr_stream *rdma_stream = &rdma_transport->stream[DATA_STREAM];
221cfdc61a60c9 Christoph Böhmwalder 2026-03-27  617  	struct page *page;
221cfdc61a60c9 Christoph Böhmwalder 2026-03-27 @618  	int err, i = 0;
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  619  
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  620  	if (!dtr_transport_ok(transport))
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  621  		return -ECONNRESET;
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  622  
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  623  	// pr_info("%s: in recv_pages, size: %zu\n", rdma_stream->name, size);
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  624  	TR_ASSERT(transport, rdma_stream->current_rx.bytes_left == 0);
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  625  	dtr_recycle_rx_desc(transport, DATA_STREAM, &rdma_stream->current_rx.desc, GFP_NOIO);
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  626  	dtr_refill_rx_desc(rdma_transport, DATA_STREAM);
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  627  
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  628  	while (size) {
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  629  		struct dtr_rx_desc *rx_desc = NULL;
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  630  		long t;
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  631  
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  632  		t = wait_event_interruptible_timeout(rdma_stream->recv_wq,
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  633  					dtr_receive_rx_desc(rdma_transport, DATA_STREAM, &rx_desc),
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  634  					rdma_stream->recv_timeout);
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  635  
221cfdc61a60c9 Christoph Böhmwalder 2026-03-27  636  		if (t <= 0)
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  637  			return t == 0 ? -EAGAIN : -EINTR;
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  638  
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  639  		page = rx_desc->page;
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  640  		/* put_page() if we would get_page() in
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  641  		 * dtr_create_rx_desc().  but we don't. We return the page
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  642  		 * chain to the user, which is supposed to give it back to
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  643  		 * drbd_free_pages() eventually. */
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  644  		rx_desc->page = NULL;
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  645  		size -= rx_desc->size;
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  646  
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  647  		/* If the sender did dtr_send_page every bvec of a bio with
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  648  		 * unaligned bvecs (as xfs often creates), rx_desc->size and
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  649  		 * offset may well be not the PAGE_SIZE and 0 we hope for.
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  650  		 */
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  651  
221cfdc61a60c9 Christoph Böhmwalder 2026-03-27  652  		err = drbd_bio_add_page(transport, bios, page, rx_desc->size, 0);
221cfdc61a60c9 Christoph Böhmwalder 2026-03-27  653  		if (err < 0)
221cfdc61a60c9 Christoph Böhmwalder 2026-03-27  654  			return err;
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  655  
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  656  		atomic_dec(&rx_desc->cm->path->flow[DATA_STREAM].rx_descs_allocated);
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  657  		dtr_free_rx_desc(rx_desc);
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  658  
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  659  		i++;
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  660  		dtr_refill_rx_desc(rdma_transport, DATA_STREAM);
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  661  	}
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  662  
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  663  	// pr_info("%s: rcvd %d pages\n", rdma_stream->name, i);
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  664  	return 0;
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  665  }
bc43430bc671a7 Christoph Böhmwalder 2026-03-27  666  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
