Return-Path: <lkp@intel.com>
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C104416084A
	for <drbd-dev@lists.linbit.com>; Sat, 18 Apr 2026 06:37:19 +0200 (CEST)
Date: Sat, 18 Apr 2026 06:36:19 +0200
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/4] drbd: switch from genl_magic macros to YNL-generated
	code
Message-ID: <202604180607.iqIlyAER-lkp@intel.com>
References: <20260407173356.873887-5-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407173356.873887-5-christoph.boehmwalder@linbit.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
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

kernel test robot noticed the following build errors:

[auto build test ERROR on a9c4b1d37622ed01b75f94a4f68cf55f33153a31]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-move-UAPI-headers-to-include-uapi-linux/20260417-214347
base:   a9c4b1d37622ed01b75f94a4f68cf55f33153a31
patch link:    https://lore.kernel.org/r/20260407173356.873887-5-christoph.boehmwalder%40linbit.com
patch subject: [PATCH 4/4] drbd: switch from genl_magic macros to YNL-generated code
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260418/202604180607.iqIlyAER-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260418/202604180607.iqIlyAER-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604180607.iqIlyAER-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/drbd.h:18:10: fatal error: sys/types.h: No such file or directory
      18 | #include <sys/types.h>
         |          ^~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
