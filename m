Return-Path: <lkp@intel.com>
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 568D9160867
	for <drbd-dev@lists.linbit.com>; Sat, 28 Mar 2026 13:29:42 +0100 (CET)
Date: Sat, 28 Mar 2026 20:21:48 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 20/20] drbd: remove BROKEN for DRBD
Message-ID: <202603282006.UELjhGio-lkp@intel.com>
References: <20260327223820.2244227-21-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327223820.2244227-21-christoph.boehmwalder@linbit.com>
Cc: linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
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
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20260328/202603282006.UELjhGio-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603282006.UELjhGio-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603282006.UELjhGio-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/block/drbd/drbd_receiver.c:496 function parameter 'peer_device' not described in 'drbd_alloc_peer_req'
>> Warning: drivers/block/drbd/drbd_receiver.c:496 function parameter 'peer_device' not described in 'drbd_alloc_peer_req'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
