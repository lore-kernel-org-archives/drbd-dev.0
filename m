Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638271;
	b=MTkfXg5I6MQpxJ8+VfnncEEkiCM81hHwdbNY+PqTQ9SLd9HraWLjUF1I0fwjoOL4LYqg
	 9JbDCxN2v0WZQPInScmfyp5+UL8e6h1M/gffzmOQvFIlGpoucDAch8h3vEAKsF2qtCIDZ
	 ONMQ3172fNIQXCDnHr6l36aYaJ4Su7ftokZbCe6LvNhC18/Pnw4OzAH9Q5ZfXvurpYDQB
	 FeTvzBZVSTRgIISNUtDbZvXpsOcRYnACXvMJn/L6f6XGBkEdnnwDQ3xZfaWeh/e9t+koE
	 0T98FYNHZwZRL8ei+PA7KsTBBVJcHdOIVLmILIDKUyHkfEroydgKmZARAPHa4eBsSIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638271;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=W6kSkTrweSQ0wcU2dbEyxHrUIkg5Sek2FnfGWXLCYjc=;
	b=1s/hBarQWwDU8iQMZNUMd4suk88+ybXYdsnlvPyUYCxxB2i5D9pdj1GlDy28SksEoC28
	 XrsBlh2TfkkJ+q8EMnRijX1jqXH7lHe0ayKfNklmRZYnRKDRixPwOiYVCVykMBJO8aap2
	 QnTho39nH8RWLnxeSJ0Er9O9OIWZQVZe1oVqphCj+9DIG0vu2k3w3QlZ8txF6qkIlbi7X
	 NMJqrNCzAGaHTMh682YjxTiEigerlnq0VNpCu8ony50XLdRkJTMLynxkF6tqxt+ZIHWre
	 Es27LB47SSldGLnd3nQOKWUPs4hifQemrDIZINhmR/rPlbg1gBPQurQMCkBurEGKcEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SQFDt3z5;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F9606A321;
	Wed, 25 Nov 2026 20:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A2F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SQFDt3z5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795638271; x=1827174271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=opOUzu9CI5VspuCJ7TqUH2I8StJt23oLfhcFKQY18Qk=;
  b=SQFDt3z5WA4IKyGJB5hlp239vQ5NmWzBWzffMV3Ab6v3pkZc/L23tsCi
   /7Ob2izsFjov8j5st606HAR8fMJXpqwBr6vuUbKDiOE4tKvvW2sdrtY4P
   yy6oHBOhpUIYAu5sdHbblFJo+F1bXIVGVLKozJjLy/M9bR2kWr0wJ6shE
   uRiCwnEW5aH40SlpgW/MH+efxJ9h/Ql08+2S0OW4cXzJJjjGeVpdYjyvv
   tJWZMKU1SMhAbXJQMbDAgq4HnlHNlxmRZgUC2lbCm/r7lyWZnYYwlhxgT
   YDnCiV5LOSkGgIxGVgIUbqveYiDOLojt2kTEvOLcXT7SREwcr3DigmXNy
   w==;
X-CSE-ConnectionGUID: lRKKR29YQqS8kgRg157wwg==
X-CSE-MsgGUID: ij398mCFQqiaU1WzABX8Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4419665"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4419665"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 12:24:30 -0800
X-CSE-ConnectionGUID: fnaUMappR4mcIFMGaoFcEg==
X-CSE-MsgGUID: DG4ecEMZS5Sj2YHpzK1moQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11835676"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Nov 2026 12:24:28 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWJXV-00000001SXe-2kch;
	Wed, 25 Nov 2026 20:24:25 +0000
Date: Thu, 26 Nov 2026 04:23:37 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH v4 21/21] drbd: remove BROKEN for DRBD
Message-ID: <20261126041726.kXD9a5hZ-lkp@intel.com>
References: <20261125153511.3060599-22-christoph.boehmwalder@linbit.com>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125153511.3060599-22-christoph.boehmwalder@linbit.com>

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aa7014f8d7565cfea117eac36a5de0a05eba65a4]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-mark-as-BROKEN-during-DRBD-9-rework/20261125-163451
base:   aa7014f8d7565cfea117eac36a5de0a05eba65a4
patch link:    https://lore.kernel.org/r/20261125153511.3060599-22-christoph.boehmwalder%40linbit.com
patch subject: [PATCH v4 21/21] drbd: remove BROKEN for DRBD
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20261126/20261126041726.kXD9a5hZ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261126/20261126041726.kXD9a5hZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261126041726.kXD9a5hZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/block/drbd/drbd_receiver.c:407 function parameter 'connection' not described in 'alloc_pages_throttled'
>> Warning: drivers/block/drbd/drbd_receiver.c:407 function parameter 'throttle' not described in 'alloc_pages_throttled'
>> Warning: drivers/block/drbd/drbd_receiver.c:407 expecting prototype for drbd_alloc_pages(). Prototype was for alloc_pages_throttled() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
