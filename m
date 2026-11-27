Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795816859;
	b=xe7CXyJ4I98nfSK1VX3OxlDkJ0xxiOlXeouOEJ+BqTXJ4Wqtww+zs2t4PodPY2T3a93m
	 AT08uRG1Znr+g7wLklCI+k26emyF5pC8Gz5Fq90mv0rp8rb8obG25PxQL5Fh40Bx7wp8W
	 chcAt1rauXp52Aeris7QNEIEokrLAOgn16VkrbgmhPZZ+peO30+DJEhh1CUmQn6fxiLmn
	 bn44tJCr0fAaQec0ace7YE7DRj8yK7uJxzczK0sX44RJWA0HAoPl/4GV4KoDyvhPp6t72
	 ALK7uo+Gt9UUtAWBzbDaAAN6Ql0lYy+fFf8djfMT5sC8YUX6u94HxWj3BttpqppaNOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795816859;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=EhC5tfKA+obQaF9F2vL/sKIvqAuyU6rhDxiLKjO4/k4=;
	b=BW5BLdbkuaBkUUeNFNN4HzA95GB6VumzrjidzKDmoOdsMaW+46CQ+N86bmLwUjJTtzXt
	 li0lvslgAF7MWhWe1mm57UtV4VY1tJSUuujZHbwWrusBzJnsz+csWi0kQF9JfJ0fVsO5Q
	 dJOEaKEWALKB+wgWy4Ql46TZWozinjevPV4HM0h0OijLpmWWk7V0A3zmK7WsqE6XFdFAk
	 /Ewwf0rsjG2wMqxBmY5bC/+r1xQkekstJp8bcrecpaccnbMZybKiQMyQJexm4Q17ptqkh
	 nxH8Cy5aJBouvW/tl+CMuiliqaOZcBVpTO4QjEu0h6iBjv95QmThYm1fWnMvyVIr//A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ROjABghT;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D37606A31C;
	Fri, 27 Nov 2026 22:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64D37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ROjABghT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795816856; x=1827352856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/kinawJp655nHFK2/uMv9s2ppdT7DIpKXGcoFVJqh0Q=;
  b=ROjABghTBxy7m4mMr82df6BKtcpNy0oMdUSIySqJUvRmNmqvbDyxkp8c
   mzpncMxQ58PYFQEZA42XMbjPMh4/sMlwb62IBguHDtM8u2h4XoWlD9iHd
   05XzC7taHpsypHE1SPCrmF/o04QhLjKbnnsKDM0tmpqBL4wQ+WojVyBoZ
   KptxluQoC+MzHbnT9d2JgsOohHTHiUEEItV/Ngn/AasiC/bO5VZrJX0i0
   5eCfha2P2id8CQu6DYjaictdoqdHa14oL4XpsaOzjC5gDLN3s/w7hsVjy
   tNrAB1PYJEtjsTAhCBiCCMPcKXJ9T1NtQlCMc1vs70IENipSNhM0LZ8ZQ
   w==;
X-CSE-ConnectionGUID: oZvTvVY6S76VNpIBpEr6uQ==
X-CSE-MsgGUID: y9YDF8L1Rp2Z7VjwQy1J/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4819181"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4819181"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 14:00:55 -0800
X-CSE-ConnectionGUID: 5iwiGlbxTfqITZEgWtHxjg==
X-CSE-MsgGUID: kWMOYS7gQJSu5J4Sh96EnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="12338673"
Received: from igk-lkp-server01.igk.intel.com (HELO 146cf1e082f1) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 27 Nov 2026 14:00:52 -0800
Received: from kbuild by 146cf1e082f1 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xX3zt-000000000Mw-227Q;
	Fri, 27 Nov 2026 22:00:49 +0000
Date: Fri, 27 Nov 2026 23:00:17 +0100
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH v4 21/21] drbd: remove BROKEN for DRBD
Message-ID: <20261127225619.usGsRzsm-lkp@intel.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125153511.3060599-22-christoph.boehmwalder@linbit.com>

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aa7014f8d7565cfea117eac36a5de0a05eba65a4]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-mark-as-BROKEN-during-DRBD-9-rework/20261125-163451
base:   aa7014f8d7565cfea117eac36a5de0a05eba65a4
patch link:    https://lore.kernel.org/r/20261125153511.3060599-22-christoph.boehmwalder%40linbit.com
patch subject: [PATCH v4 21/21] drbd: remove BROKEN for DRBD
config: riscv-randconfig-r2303-20261127 (https://download.01.org/0day-ci/archive/20261127/20261127225619.usGsRzsm-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.5.0
sparse: v0.6.5-rc1-21-g84ec0658
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127225619.usGsRzsm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127225619.usGsRzsm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/block/drbd/drbd_legacy_84.c:91:30: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_legacy_84.c:91:30: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_legacy_84.c:91:30: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_legacy_84.c:91:30: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_legacy_84.c:91:30: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_legacy_84.c:91:30: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_legacy_84.c:91:30: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_legacy_84.c:91:30: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_legacy_84.c:91:30: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_legacy_84.c:91:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:92:28: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:92:28: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:92:28: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:92:28: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:92:28: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:92:28: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:92:28: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:92:28: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:92:28: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:92:28: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:95:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:95:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:95:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:95:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:95:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:95:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:95:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:95:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:95:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:95:27: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_legacy_84.c:96:28: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_legacy_84.c:96:28: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_legacy_84.c:96:28: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_legacy_84.c:96:28: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_legacy_84.c:96:28: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_legacy_84.c:96:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:97:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:97:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:97:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:97:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:97:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:97:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:99:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:99:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:99:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:99:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:99:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:99:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:101:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:101:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:101:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:101:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:101:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:101:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:105:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:105:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:105:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:105:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:105:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:105:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:107:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:107:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:107:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:107:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:107:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:107:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:108:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:108:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:108:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:108:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:108:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:108:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_legacy_84.c:130:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:130:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:130:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:130:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:130:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:130:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:130:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:130:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:130:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:130:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:134:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:134:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:134:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:134:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:134:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:134:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:134:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:134:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:134:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_legacy_84.c:134:40: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_legacy_84.c:149:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] la_size_sect @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:149:30: sparse:     expected unsigned long long [usertype] la_size_sect
   drivers/block/drbd/drbd_legacy_84.c:149:30: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:150:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] device_uuid @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:150:29: sparse:     expected unsigned long long [usertype] device_uuid
   drivers/block/drbd/drbd_legacy_84.c:150:29: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:151:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:151:34: sparse:     expected unsigned long long
   drivers/block/drbd/drbd_legacy_84.c:151:34: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_legacy_84.c:152:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:152:33: sparse:     expected unsigned long long
   drivers/block/drbd/drbd_legacy_84.c:152:33: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_legacy_84.c:154:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:154:52: sparse:     expected unsigned long long
   drivers/block/drbd/drbd_legacy_84.c:154:52: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:156:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:156:23: sparse:     expected unsigned int [usertype] flags
   drivers/block/drbd/drbd_legacy_84.c:156:23: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:157:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] magic @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:157:23: sparse:     expected unsigned int [usertype] magic
   drivers/block/drbd/drbd_legacy_84.c:157:23: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:158:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] md_size_sect @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:158:30: sparse:     expected unsigned int [usertype] md_size_sect
   drivers/block/drbd/drbd_legacy_84.c:158:30: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:159:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_offset @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:159:27: sparse:     expected unsigned int [usertype] al_offset
   drivers/block/drbd/drbd_legacy_84.c:159:27: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:160:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_nr_extents @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:160:31: sparse:     expected unsigned int [usertype] al_nr_extents
   drivers/block/drbd/drbd_legacy_84.c:160:31: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:161:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bm_offset @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:161:27: sparse:     expected unsigned int [usertype] bm_offset
   drivers/block/drbd/drbd_legacy_84.c:161:27: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:162:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bm_bytes_per_bit @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:162:34: sparse:     expected unsigned int [usertype] bm_bytes_per_bit
   drivers/block/drbd/drbd_legacy_84.c:162:34: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:163:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] la_peer_max_bio_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:163:38: sparse:     expected unsigned int [usertype] la_peer_max_bio_size
   drivers/block/drbd/drbd_legacy_84.c:163:38: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:165:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_stripes @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:165:28: sparse:     expected unsigned int [usertype] al_stripes
   drivers/block/drbd/drbd_legacy_84.c:165:28: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_legacy_84.c:166:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_stripe_size_4k @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_legacy_84.c:166:35: sparse:     expected unsigned int [usertype] al_stripe_size_4k
   drivers/block/drbd/drbd_legacy_84.c:166:35: sparse:     got restricted __be32 [usertype]
--
>> drivers/block/drbd/drbd_transport.c:395:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct list_head *[addressable] pos @@     got struct list_head [noderef] __rcu * @@
   drivers/block/drbd/drbd_transport.c:395:21: sparse:     expected struct list_head *[addressable] pos
   drivers/block/drbd/drbd_transport.c:395:21: sparse:     got struct list_head [noderef] __rcu *
--
>> drivers/block/drbd/drbd_transport_tcp.c:633:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] magic @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_transport_tcp.c:633:17: sparse:     expected unsigned int [usertype] magic
   drivers/block/drbd/drbd_transport_tcp.c:633:17: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_transport_tcp.c:634:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] command @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_transport_tcp.c:634:19: sparse:     expected unsigned short [usertype] command
   drivers/block/drbd/drbd_transport_tcp.c:634:19: sparse:     got restricted __be16 [usertype]
>> drivers/block/drbd/drbd_transport_tcp.c:931:25: sparse: sparse: restricted __be32 degrades to integer
>> drivers/block/drbd/drbd_transport_tcp.c:932:17: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_transport_tcp.c:932:17: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_transport_tcp.c:932:17: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_transport_tcp.c:932:17: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_transport_tcp.c:932:17: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_transport_tcp.c:932:17: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_transport_tcp.c:936:16: sparse: sparse: cast to restricted __be16
>> drivers/block/drbd/drbd_transport_tcp.c:936:16: sparse: sparse: cast to restricted __be16
>> drivers/block/drbd/drbd_transport_tcp.c:936:16: sparse: sparse: cast to restricted __be16
>> drivers/block/drbd/drbd_transport_tcp.c:936:16: sparse: sparse: cast to restricted __be16
--
>> drivers/block/drbd/drbd_req.c:924:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_request [noderef] __rcu *volatile @@     got struct drbd_request *[assigned] found_req @@
   drivers/block/drbd/drbd_req.c:924:9: sparse:     expected struct drbd_request [noderef] __rcu *volatile
   drivers/block/drbd/drbd_req.c:924:9: sparse:     got struct drbd_request *[assigned] found_req
>> drivers/block/drbd/drbd_req.c:1092:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct drbd_request [noderef] __rcu **cache_ptr @@     got struct drbd_request ** @@
   drivers/block/drbd/drbd_req.c:1092:48: sparse:     expected struct drbd_request [noderef] __rcu **cache_ptr
   drivers/block/drbd/drbd_req.c:1092:48: sparse:     got struct drbd_request **
   drivers/block/drbd/drbd_req.c:1099:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct drbd_request [noderef] __rcu **cache_ptr @@     got struct drbd_request ** @@
   drivers/block/drbd/drbd_req.c:1099:48: sparse:     expected struct drbd_request [noderef] __rcu **cache_ptr
   drivers/block/drbd/drbd_req.c:1099:48: sparse:     got struct drbd_request **
   drivers/block/drbd/drbd_req.c:1125:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct drbd_request [noderef] __rcu **cache_ptr @@     got struct drbd_request ** @@
   drivers/block/drbd/drbd_req.c:1125:48: sparse:     expected struct drbd_request [noderef] __rcu **cache_ptr
   drivers/block/drbd/drbd_req.c:1125:48: sparse:     got struct drbd_request **
--
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:658:42: sparse:     got restricted __le32 [usertype]
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:658:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:662:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:663:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got int @@
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     expected restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:663:36: sparse:     got int
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse:     got restricted __le32 [usertype]
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:669:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:672:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int w @@     got restricted __le32 @@
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     expected unsigned int w
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse:     got restricted __le32
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/block/drbd/drbd_bitmap.c:732:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/block/drbd/drbd_bitmap.c:566:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:566:24: sparse:     got restricted __le32 const [usertype]
>> drivers/block/drbd/drbd_bitmap.c:568:22: sparse: sparse: cast to restricted __le32
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 const [usertype] @@
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_bitmap.c:573:24: sparse:     got restricted __le32 const [usertype]
   drivers/block/drbd/drbd_bitmap.c:575:34: sparse: sparse: cast to restricted __le32
--
>> drivers/block/drbd/drbd_main.c:155:31: sparse: sparse: symbol 'param_ops_drbd_strict_names' was not declared. Should it be static?
>> drivers/block/drbd/drbd_main.c:210:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct list_head *[addressable] pos @@     got struct list_head [noderef] __rcu * @@
   drivers/block/drbd/drbd_main.c:210:21: sparse:     expected struct list_head *[addressable] pos
   drivers/block/drbd/drbd_main.c:210:21: sparse:     got struct list_head [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:258:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct list_head *[addressable] pos @@     got struct list_head [noderef] __rcu * @@
   drivers/block/drbd/drbd_main.c:258:21: sparse:     expected struct list_head *[addressable] pos
   drivers/block/drbd/drbd_main.c:258:21: sparse:     got struct list_head [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:870:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] magic @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:870:20: sparse:     expected unsigned int [usertype] magic
   drivers/block/drbd/drbd_main.c:870:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:871:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] command @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:871:20: sparse:     expected unsigned short [usertype] command
   drivers/block/drbd/drbd_main.c:871:20: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:872:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] length @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:872:20: sparse:     expected unsigned short [usertype] length
   drivers/block/drbd/drbd_main.c:872:20: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:877:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] magic @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:877:20: sparse:     expected unsigned short [usertype] magic
   drivers/block/drbd/drbd_main.c:877:20: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:878:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] command @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:878:20: sparse:     expected unsigned short [usertype] command
   drivers/block/drbd/drbd_main.c:878:20: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:879:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:879:19: sparse:     expected unsigned int [usertype] length
   drivers/block/drbd/drbd_main.c:879:19: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:885:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] magic @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:885:18: sparse:     expected unsigned int [usertype] magic
   drivers/block/drbd/drbd_main.c:885:18: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:886:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] volume @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:886:19: sparse:     expected unsigned short [usertype] volume
   drivers/block/drbd/drbd_main.c:886:19: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:887:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] command @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:887:20: sparse:     expected unsigned short [usertype] command
   drivers/block/drbd/drbd_main.c:887:20: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:888:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:888:19: sparse:     expected unsigned int [usertype] length
   drivers/block/drbd/drbd_main.c:888:19: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1271:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] mask @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1271:17: sparse:     expected unsigned long long [usertype] mask
   drivers/block/drbd/drbd_main.c:1271:17: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1272:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dagtag @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1272:19: sparse:     expected unsigned long long [usertype] dagtag
   drivers/block/drbd/drbd_main.c:1272:19: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1315:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] resync_rate @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1315:32: sparse:     expected unsigned int [usertype] resync_rate
   drivers/block/drbd/drbd_main.c:1315:32: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1316:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] c_plan_ahead @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1316:33: sparse:     expected unsigned int [usertype] c_plan_ahead
   drivers/block/drbd/drbd_main.c:1316:33: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1317:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] c_delay_target @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1317:35: sparse:     expected unsigned int [usertype] c_delay_target
   drivers/block/drbd/drbd_main.c:1317:35: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1318:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] c_fill_target @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1318:34: sparse:     expected unsigned int [usertype] c_fill_target
   drivers/block/drbd/drbd_main.c:1318:34: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1319:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] c_max_rate @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1319:31: sparse:     expected unsigned int [usertype] c_max_rate
   drivers/block/drbd/drbd_main.c:1319:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1322:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] resync_rate @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1322:32: sparse:     expected unsigned int [usertype] resync_rate
   drivers/block/drbd/drbd_main.c:1322:32: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1323:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] c_plan_ahead @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1323:33: sparse:     expected unsigned int [usertype] c_plan_ahead
   drivers/block/drbd/drbd_main.c:1323:33: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1324:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] c_delay_target @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1324:35: sparse:     expected unsigned int [usertype] c_delay_target
   drivers/block/drbd/drbd_main.c:1324:35: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1325:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] c_fill_target @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1325:34: sparse:     expected unsigned int [usertype] c_fill_target
   drivers/block/drbd/drbd_main.c:1325:34: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1326:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] c_max_rate @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1326:31: sparse:     expected unsigned int [usertype] c_max_rate
   drivers/block/drbd/drbd_main.c:1326:31: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1348:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected char const * @@     got char [noderef] __rcu * @@
   drivers/block/drbd/drbd_main.c:1348:17: sparse:     expected char const *
   drivers/block/drbd/drbd_main.c:1348:17: sparse:     got char [noderef] __rcu *
>> drivers/block/drbd/drbd_main.c:1382:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] protocol @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1382:26: sparse:     expected unsigned int [usertype] protocol
   drivers/block/drbd/drbd_main.c:1382:26: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1383:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] after_sb_0p @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1383:26: sparse:     expected unsigned int [usertype] after_sb_0p
   drivers/block/drbd/drbd_main.c:1383:26: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1384:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] after_sb_1p @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1384:26: sparse:     expected unsigned int [usertype] after_sb_1p
   drivers/block/drbd/drbd_main.c:1384:26: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1385:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] after_sb_2p @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1385:26: sparse:     expected unsigned int [usertype] after_sb_2p
   drivers/block/drbd/drbd_main.c:1385:26: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1386:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] two_primaries @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1386:26: sparse:     expected unsigned int [usertype] two_primaries
   drivers/block/drbd/drbd_main.c:1386:26: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1392:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] conn_flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1392:26: sparse:     expected unsigned int [usertype] conn_flags
   drivers/block/drbd/drbd_main.c:1392:26: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1417:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] current_uuid @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1417:25: sparse:     expected unsigned long long [usertype] current_uuid
   drivers/block/drbd/drbd_main.c:1417:25: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1418:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] bitmap_uuid @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1418:24: sparse:     expected unsigned long long [usertype] bitmap_uuid
   drivers/block/drbd/drbd_main.c:1418:24: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1420:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1420:37: sparse:     expected unsigned long long
   drivers/block/drbd/drbd_main.c:1420:37: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1424:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dirty_bits @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1424:23: sparse:     expected unsigned long long [usertype] dirty_bits
   drivers/block/drbd/drbd_main.c:1424:23: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1439:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] uuid_flags @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1439:23: sparse:     expected unsigned long long [usertype] uuid_flags
   drivers/block/drbd/drbd_main.c:1439:23: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1557:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] current_uuid @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1557:25: sparse:     expected unsigned long long [usertype] current_uuid
   drivers/block/drbd/drbd_main.c:1557:25: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1577:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1577:47: sparse:     expected unsigned long long
   drivers/block/drbd/drbd_main.c:1577:47: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1584:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1584:39: sparse:     expected unsigned long long
   drivers/block/drbd/drbd_main.c:1584:39: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1587:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] bitmap_uuids_mask @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1587:30: sparse:     expected unsigned long long [usertype] bitmap_uuids_mask
   drivers/block/drbd/drbd_main.c:1587:30: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1590:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dirty_bits @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1590:23: sparse:     expected unsigned long long [usertype] dirty_bits
   drivers/block/drbd/drbd_main.c:1590:23: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1595:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] node_mask @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1595:30: sparse:     expected unsigned long long [usertype] node_mask
   drivers/block/drbd/drbd_main.c:1595:30: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1598:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] node_mask @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1598:30: sparse:     expected unsigned long long [usertype] node_mask
   drivers/block/drbd/drbd_main.c:1598:30: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1601:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] uuid_flags @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1601:23: sparse:     expected unsigned long long [usertype] uuid_flags
   drivers/block/drbd/drbd_main.c:1601:23: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1647:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] uuid @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1647:17: sparse:     expected unsigned long long [usertype] uuid
   drivers/block/drbd/drbd_main.c:1647:17: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1648:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] weak_nodes @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1648:23: sparse:     expected unsigned long long [usertype] weak_nodes
   drivers/block/drbd/drbd_main.c:1648:23: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1673:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] uuid @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1673:25: sparse:     expected unsigned long long [usertype] uuid
   drivers/block/drbd/drbd_main.c:1673:25: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1710:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] physical_block_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1710:46: sparse:     expected unsigned int [usertype] physical_block_size
   drivers/block/drbd/drbd_main.c:1710:46: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1712:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] logical_block_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1712:45: sparse:     expected unsigned int [usertype] logical_block_size
   drivers/block/drbd/drbd_main.c:1712:45: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1714:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] alignment_offset @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1714:43: sparse:     expected unsigned int [usertype] alignment_offset
   drivers/block/drbd/drbd_main.c:1714:43: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1716:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] io_min @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1716:33: sparse:     expected unsigned int [usertype] io_min
   drivers/block/drbd/drbd_main.c:1716:33: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1717:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] io_opt @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1717:33: sparse:     expected unsigned int [usertype] io_opt
   drivers/block/drbd/drbd_main.c:1717:33: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1727:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] physical_block_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1727:46: sparse:     expected unsigned int [usertype] physical_block_size
   drivers/block/drbd/drbd_main.c:1727:46: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1729:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] logical_block_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1729:45: sparse:     expected unsigned int [usertype] logical_block_size
   drivers/block/drbd/drbd_main.c:1729:45: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1732:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] io_min @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1732:33: sparse:     expected unsigned int [usertype] io_min
   drivers/block/drbd/drbd_main.c:1732:33: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1733:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] io_opt @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1733:33: sparse:     expected unsigned int [usertype] io_opt
   drivers/block/drbd/drbd_main.c:1733:33: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1752:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] d_size @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1752:19: sparse:     expected unsigned long long [usertype] d_size
   drivers/block/drbd/drbd_main.c:1752:19: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1753:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] u_size @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1753:19: sparse:     expected unsigned long long [usertype] u_size
   drivers/block/drbd/drbd_main.c:1753:19: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1758:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] c_size @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1758:19: sparse:     expected unsigned long long [usertype] c_size
   drivers/block/drbd/drbd_main.c:1758:19: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1759:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] max_bio_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1759:25: sparse:     expected unsigned int [usertype] max_bio_size
   drivers/block/drbd/drbd_main.c:1759:25: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1760:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] queue_order_type @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:1760:29: sparse:     expected unsigned short [usertype] queue_order_type
   drivers/block/drbd/drbd_main.c:1760:29: sparse:     got restricted __be16 [usertype]
>> drivers/block/drbd/drbd_main.c:1761:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] dds_flags @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:1761:22: sparse:     expected unsigned short [usertype] dds_flags
   drivers/block/drbd/drbd_main.c:1761:22: sparse:     got restricted __be16 [usertype]
   drivers/block/drbd/drbd_main.c:1782:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] state @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1782:18: sparse:     expected unsigned int [usertype] state
   drivers/block/drbd/drbd_main.c:1782:18: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1853:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1853:17: sparse:     expected unsigned int [usertype] mask
   drivers/block/drbd/drbd_main.c:1853:17: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1854:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1854:16: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_main.c:1854:16: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1871:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tid @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1871:16: sparse:     expected unsigned int [usertype] tid
   drivers/block/drbd/drbd_main.c:1871:16: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1873:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1873:26: sparse:     expected unsigned int [usertype] flags
   drivers/block/drbd/drbd_main.c:1873:26: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1878:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] u32_initiator_node_id @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1878:42: sparse:     expected unsigned int [usertype] u32_initiator_node_id
   drivers/block/drbd/drbd_main.c:1878:42: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1879:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] u32_target_node_id @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1879:39: sparse:     expected unsigned int [usertype] u32_target_node_id
   drivers/block/drbd/drbd_main.c:1879:39: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1881:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] nodes_to_reach @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1881:27: sparse:     expected unsigned long long [usertype] nodes_to_reach
   drivers/block/drbd/drbd_main.c:1881:27: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1886:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1886:33: sparse:     expected unsigned int [usertype] mask
   drivers/block/drbd/drbd_main.c:1886:33: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1887:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1887:32: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_main.c:1887:32: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1889:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] primary_nodes @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1889:42: sparse:     expected unsigned long long [usertype] primary_nodes
   drivers/block/drbd/drbd_main.c:1889:42: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1892:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] reachable_nodes @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1892:52: sparse:     expected unsigned long long [usertype] reachable_nodes
   drivers/block/drbd/drbd_main.c:1892:52: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1895:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1895:41: sparse:     expected unsigned int [usertype] mask
   drivers/block/drbd/drbd_main.c:1895:41: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1896:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1896:40: sparse:     expected unsigned int [usertype] val
   drivers/block/drbd/drbd_main.c:1896:40: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1902:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] user_size @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1902:38: sparse:     expected unsigned long long [usertype] user_size
   drivers/block/drbd/drbd_main.c:1902:38: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1903:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] dds_flags @@     got restricted __be16 [usertype] @@
   drivers/block/drbd/drbd_main.c:1903:38: sparse:     expected unsigned short [usertype] dds_flags
   drivers/block/drbd/drbd_main.c:1903:38: sparse:     got restricted __be16 [usertype]
>> drivers/block/drbd/drbd_main.c:1905:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] diskful_primary_nodes @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1905:50: sparse:     expected unsigned long long [usertype] diskful_primary_nodes
   drivers/block/drbd/drbd_main.c:1905:50: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1907:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] exposed_size @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1907:41: sparse:     expected unsigned long long [usertype] exposed_size
   drivers/block/drbd/drbd_main.c:1907:41: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1924:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] retcode @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1924:28: sparse:     expected unsigned int [usertype] retcode
   drivers/block/drbd/drbd_main.c:1924:28: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1936:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tid @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1936:24: sparse:     expected unsigned int [usertype] tid
   drivers/block/drbd/drbd_main.c:1936:24: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1937:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] initiator_node_id @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1937:38: sparse:     expected unsigned int [usertype] initiator_node_id
   drivers/block/drbd/drbd_main.c:1937:38: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1938:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] reachable_nodes @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1938:36: sparse:     expected unsigned long long [usertype] reachable_nodes
   drivers/block/drbd/drbd_main.c:1938:36: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1941:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] primary_nodes @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1941:42: sparse:     expected unsigned long long [usertype] primary_nodes
   drivers/block/drbd/drbd_main.c:1941:42: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1942:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] weak_nodes @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1942:39: sparse:     expected unsigned long long [usertype] weak_nodes
   drivers/block/drbd/drbd_main.c:1942:39: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1945:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] diskful_primary_nodes @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1945:50: sparse:     expected unsigned long long [usertype] diskful_primary_nodes
   drivers/block/drbd/drbd_main.c:1945:50: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1946:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] max_possible_size @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1946:46: sparse:     expected unsigned long long [usertype] max_possible_size
   drivers/block/drbd/drbd_main.c:1946:46: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1959:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1959:27: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1959:27: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1960:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] mask @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1960:25: sparse:     expected unsigned long long [usertype] mask
   drivers/block/drbd/drbd_main.c:1960:25: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1961:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1961:25: sparse:     expected unsigned int [usertype] size
   drivers/block/drbd/drbd_main.c:1961:25: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1975:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dagtag @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1975:19: sparse:     expected unsigned long long [usertype] dagtag
   drivers/block/drbd/drbd_main.c:1975:19: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:1976:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] node_id @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1976:20: sparse:     expected unsigned int [usertype] node_id
   drivers/block/drbd/drbd_main.c:1976:20: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:1989:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] flush_sequence @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1989:27: sparse:     expected unsigned long long [usertype] flush_sequence
   drivers/block/drbd/drbd_main.c:1989:27: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:2003:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] flush_sequence @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:2003:27: sparse:     expected unsigned long long [usertype] flush_sequence
   drivers/block/drbd/drbd_main.c:2003:27: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:2004:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] initiator_node_id @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:2004:30: sparse:     expected unsigned int [usertype] initiator_node_id
   drivers/block/drbd/drbd_main.c:2004:30: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:2018:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] flush_sequence @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:2018:27: sparse:     expected unsigned long long [usertype] flush_sequence
   drivers/block/drbd/drbd_main.c:2018:27: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:2019:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] primary_node_id @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:2019:28: sparse:     expected unsigned int [usertype] primary_node_id
   drivers/block/drbd/drbd_main.c:2019:28: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:2389:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:2389:27: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:2389:27: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:2390:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:2390:28: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:2390:28: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:2398:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:2398:22: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:2398:22: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:2399:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:2399:23: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:2399:23: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:2413:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:2413:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:2413:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:2415:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:2415:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:2415:20: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_main.c:2438:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dagtag_node_id @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:2438:35: sparse:     expected unsigned int [usertype] dagtag_node_id
   drivers/block/drbd/drbd_main.c:2438:35: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:2439:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dagtag @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:2439:27: sparse:     expected unsigned long long [usertype] dagtag
   drivers/block/drbd/drbd_main.c:2439:27: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:2453:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:2453:28: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:2453:28: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:2455:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:2455:29: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:2455:29: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:2586:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:2586:28: sparse:     expected unsigned int [usertype] size
   drivers/block/drbd/drbd_main.c:2586:28: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:2597:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:2597:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:2597:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:2599:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] seq_num @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:2599:20: sparse:     expected unsigned int [usertype] seq_num
   drivers/block/drbd/drbd_main.c:2599:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:2609:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dp_flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:2609:21: sparse:     expected unsigned int [usertype] dp_flags
   drivers/block/drbd/drbd_main.c:2609:21: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:2677:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:2677:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:2677:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:2705:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:2705:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:2705:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:2706:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:2706:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:2706:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:2720:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dagtag @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:2720:19: sparse:     expected unsigned long long [usertype] dagtag
   drivers/block/drbd/drbd_main.c:2720:19: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_main.c:3517:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got struct fifo_buffer [noderef] __rcu *rs_plan_s @@
   drivers/block/drbd/drbd_main.c:3517:26: sparse:     expected void const *objp
   drivers/block/drbd/drbd_main.c:3517:26: sparse:     got struct fifo_buffer [noderef] __rcu *rs_plan_s
>> drivers/block/drbd/drbd_main.c:3518:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got struct drbd_peer_device_conf [noderef] __rcu *conf @@
   drivers/block/drbd/drbd_main.c:3518:26: sparse:     expected void const *objp
   drivers/block/drbd/drbd_main.c:3518:26: sparse:     got struct drbd_peer_device_conf [noderef] __rcu *conf
>> drivers/block/drbd/drbd_main.c:4273:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got struct drbd_net_conf [noderef] __rcu *net_conf @@
   drivers/block/drbd/drbd_main.c:4273:36: sparse:     expected void const *objp
   drivers/block/drbd/drbd_main.c:4273:36: sparse:     got struct drbd_net_conf [noderef] __rcu *net_conf
--
>> drivers/block/drbd/drbd_nl.c:2516:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_disk_conf *old_disk_conf @@     got struct drbd_disk_conf [noderef] __rcu *disk_conf @@
   drivers/block/drbd/drbd_nl.c:2516:23: sparse:     expected struct drbd_disk_conf *old_disk_conf
   drivers/block/drbd/drbd_nl.c:2516:23: sparse:     got struct drbd_disk_conf [noderef] __rcu *disk_conf
>> drivers/block/drbd/drbd_nl.c:2896:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got struct drbd_disk_conf [noderef] __rcu *disk_conf @@
   drivers/block/drbd/drbd_nl.c:2896:19: sparse:     expected void const *objp
   drivers/block/drbd/drbd_nl.c:2896:19: sparse:     got struct drbd_disk_conf [noderef] __rcu *disk_conf
>> drivers/block/drbd/drbd_nl.c:3539:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_disk_conf [noderef] __rcu *disk_conf @@     got struct drbd_disk_conf *[assigned] new_disk_conf @@
   drivers/block/drbd/drbd_nl.c:3539:24: sparse:     expected struct drbd_disk_conf [noderef] __rcu *disk_conf
   drivers/block/drbd/drbd_nl.c:3539:24: sparse:     got struct drbd_disk_conf *[assigned] new_disk_conf
>> drivers/block/drbd/drbd_nl.c:4486:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_net_conf *old_net_conf @@     got struct drbd_net_conf [noderef] __rcu *net_conf @@
   drivers/block/drbd/drbd_nl.c:4486:22: sparse:     expected struct drbd_net_conf *old_net_conf
   drivers/block/drbd/drbd_nl.c:4486:22: sparse:     got struct drbd_net_conf [noderef] __rcu *net_conf
>> drivers/block/drbd/drbd_nl.c:4650:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_peer_device_conf *old_peer_device_conf @@     got struct drbd_peer_device_conf [noderef] __rcu *conf @@
   drivers/block/drbd/drbd_nl.c:4650:30: sparse:     expected struct drbd_peer_device_conf *old_peer_device_conf
   drivers/block/drbd/drbd_nl.c:4650:30: sparse:     got struct drbd_peer_device_conf [noderef] __rcu *conf
>> drivers/block/drbd/drbd_nl.c:4760:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_peer_device_conf [noderef] __rcu *conf @@     got struct drbd_peer_device_conf *[assigned] conf @@
   drivers/block/drbd/drbd_nl.c:4760:27: sparse:     expected struct drbd_peer_device_conf [noderef] __rcu *conf
   drivers/block/drbd/drbd_nl.c:4760:27: sparse:     got struct drbd_peer_device_conf *[assigned] conf
>> drivers/block/drbd/drbd_nl.c:4926:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const *tmp_name @@     got char [noderef] __rcu * @@
   drivers/block/drbd/drbd_nl.c:4926:26: sparse:     expected char const *tmp_name
   drivers/block/drbd/drbd_nl.c:4926:26: sparse:     got char [noderef] __rcu *
   drivers/block/drbd/drbd_nl.c:5102:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_net_conf *old_net_conf @@     got struct drbd_net_conf [noderef] __rcu *net_conf @@
   drivers/block/drbd/drbd_nl.c:5102:22: sparse:     expected struct drbd_net_conf *old_net_conf
   drivers/block/drbd/drbd_nl.c:5102:22: sparse:     got struct drbd_net_conf [noderef] __rcu *net_conf
   drivers/block/drbd/drbd_nl.c:6070:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_disk_conf *old_disk_conf @@     got struct drbd_disk_conf [noderef] __rcu *disk_conf @@
   drivers/block/drbd/drbd_nl.c:6070:31: sparse:     expected struct drbd_disk_conf *old_disk_conf
   drivers/block/drbd/drbd_nl.c:6070:31: sparse:     got struct drbd_disk_conf [noderef] __rcu *disk_conf
>> drivers/block/drbd/drbd_nl.c:7576:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_net_conf *nc @@     got struct drbd_net_conf [noderef] __rcu *net_conf @@
   drivers/block/drbd/drbd_nl.c:7576:12: sparse:     expected struct drbd_net_conf *nc
   drivers/block/drbd/drbd_nl.c:7576:12: sparse:     got struct drbd_net_conf [noderef] __rcu *net_conf
>> drivers/block/drbd/drbd_nl.c:7858:67: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *name @@     got char [noderef] __rcu * @@
   drivers/block/drbd/drbd_nl.c:7858:67: sparse:     expected char *name
   drivers/block/drbd/drbd_nl.c:7858:67: sparse:     got char [noderef] __rcu *
>> drivers/block/drbd/drbd_nl.c:811:32: sparse: sparse: dereference of noderef expression
   drivers/block/drbd/drbd_nl.c:3431:37: sparse: sparse: dereference of noderef expression
   drivers/block/drbd/drbd_nl.c:3821:63: sparse: sparse: dereference of noderef expression
   drivers/block/drbd/drbd_nl.c:3829:9: sparse: sparse: dereference of noderef expression
   drivers/block/drbd/drbd_nl.c:3838:75: sparse: sparse: dereference of noderef expression
   drivers/block/drbd/drbd_nl.c:3842:40: sparse: sparse: dereference of noderef expression
   drivers/block/drbd/drbd_nl.c:5431:45: sparse: sparse: dereference of noderef expression
--
   drivers/block/drbd/drbd_receiver.c:10088:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10088:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10088:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10088:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10088:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10088:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10089:57: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10089:57: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10089:57: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10089:57: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10089:57: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10089:57: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10089:57: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10089:57: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10089:57: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10089:57: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10094:60: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10094:60: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10094:60: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10094:60: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10094:60: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10094:60: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10094:60: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10094:60: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10094:60: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10094:60: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10095:60: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:10095:60: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:10095:60: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:10095:60: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:10098:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10098:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10098:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10098:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10098:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10098:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10098:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10098:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10098:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10098:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10099:59: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10099:59: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10099:59: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10099:59: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10099:59: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10099:59: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10099:59: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10099:59: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10099:59: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10099:59: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10135:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10135:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10135:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10135:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10135:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10135:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10135:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10135:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10135:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10135:40: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:10188:17: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_receiver.c:1521:31: sparse: sparse: restricted __be32 degrades to integer
>> drivers/block/drbd/drbd_receiver.c:1522:31: sparse: sparse: restricted __be16 degrades to integer
   drivers/block/drbd/drbd_receiver.c:1533:28: sparse: sparse: restricted __be32 degrades to integer
   drivers/block/drbd/drbd_receiver.c:1535:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1535:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1535:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1535:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1541:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1541:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1541:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1541:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1542:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1542:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1542:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1542:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1542:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1542:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1545:34: sparse: sparse: restricted __be16 degrades to integer
   drivers/block/drbd/drbd_receiver.c:1548:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1548:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1548:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1548:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1549:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1549:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1549:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1549:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1549:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1549:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1553:35: sparse: sparse: restricted __be32 degrades to integer
   drivers/block/drbd/drbd_receiver.c:1556:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1556:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1556:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1556:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1557:28: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1557:28: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1557:28: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1557:28: sparse: sparse: cast to restricted __be16
>> drivers/block/drbd/drbd_receiver.c:1800:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] set_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:1800:21: sparse:     expected unsigned int [usertype] set_size
   drivers/block/drbd/drbd_receiver.c:1800:21: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_receiver.c:1842:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] set_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:1842:21: sparse:     expected unsigned int [usertype] set_size
   drivers/block/drbd/drbd_receiver.c:1842:21: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_receiver.c:2449:21: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2449:21: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2449:21: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2449:21: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2449:21: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2449:21: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2449:21: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2449:21: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2449:21: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2449:21: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2451:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2451:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2451:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2451:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2451:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2451:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2452:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2452:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2452:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2452:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2452:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2452:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2454:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2454:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2454:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2454:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2454:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2454:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3547:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:3547:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:3547:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:3547:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:3547:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:3547:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:3547:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:3547:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:3547:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:3547:18: sparse: sparse: cast to restricted __be64
>> drivers/block/drbd/drbd_receiver.c:3587:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] seq_num @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3587:20: sparse:     expected unsigned int [usertype] seq_num
   drivers/block/drbd/drbd_receiver.c:3587:20: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_receiver.c:3613:31: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3613:31: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_receiver.c:3613:31: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_receiver.c:3614:31: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3614:31: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_receiver.c:3614:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_receiver.c:3622:49: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3622:49: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_receiver.c:3622:49: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_receiver.c:3622:70: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3622:70: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_receiver.c:3622:70: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_receiver.c:3635:31: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3635:31: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_receiver.c:3635:31: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_receiver.c:3636:31: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3636:31: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_receiver.c:3636:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_receiver.c:3648:33: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3648:33: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_receiver.c:3648:33: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_receiver.c:3649:33: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3649:33: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_receiver.c:3649:33: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_receiver.c:3650:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned long long [usertype] block_id @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3650:33: sparse:     expected unsigned long long [usertype] block_id
   drivers/block/drbd/drbd_receiver.c:3650:33: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_receiver.c:3658:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3658:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_receiver.c:3658:19: sparse:     got restricted __be64 [usertype]
>> drivers/block/drbd/drbd_receiver.c:3660:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3660:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_receiver.c:3660:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_receiver.c:3661:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] seq_num @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3661:20: sparse:     expected unsigned int [usertype] seq_num
   drivers/block/drbd/drbd_receiver.c:3661:20: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_receiver.c:3662:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] result @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:3662:19: sparse:     expected unsigned int [usertype] result
   drivers/block/drbd/drbd_receiver.c:3662:19: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_receiver.c:5263:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5263:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5263:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5263:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5263:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5263:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5263:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5263:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5263:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5263:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5264:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5264:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5264:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5264:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5264:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5264:29: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5265:32: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5265:32: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5265:32: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5265:32: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5265:32: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5265:32: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5266:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5266:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5266:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5266:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5266:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5266:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5266:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5266:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5266:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5266:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5368:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5368:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5368:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5368:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5368:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5368:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5368:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5368:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5368:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5368:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5371:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5371:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5371:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5371:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5371:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5371:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5687:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5687:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5687:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5687:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5687:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5687:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5687:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5687:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5687:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5687:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5687:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5687:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5687:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5687:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5687:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5687:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5696:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5696:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5696:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5696:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5696:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5696:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5696:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5696:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5696:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5696:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5698:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5698:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5698:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5698:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5698:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5698:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5766:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5766:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5766:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5766:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5766:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5766:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5766:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5766:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5766:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5766:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5766:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5766:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5766:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5766:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5766:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5766:64: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5806:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5806:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5806:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5806:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5806:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5806:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5806:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5806:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5806:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5806:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5849:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5849:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5849:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5849:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5849:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5849:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5849:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5849:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5849:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5849:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5850:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5850:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5850:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5850:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5850:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5850:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7668:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7668:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7668:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7668:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7668:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7668:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7669:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7669:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7669:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7669:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7669:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7669:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7670:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7670:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7670:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7670:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7670:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7670:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7671:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7671:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7671:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7671:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7671:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7671:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7672:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7672:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7672:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7672:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7672:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7672:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7673:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7673:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7673:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7673:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7673:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:7673:27: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_receiver.c:7771:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_net_conf *old_net_conf @@     got struct drbd_net_conf [noderef] __rcu *net_conf @@
   drivers/block/drbd/drbd_receiver.c:7771:22: sparse:     expected struct drbd_net_conf *old_net_conf
   drivers/block/drbd/drbd_receiver.c:7771:22: sparse:     got struct drbd_net_conf [noderef] __rcu *net_conf
   drivers/block/drbd/drbd_receiver.c:7890:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_net_conf *old_net_conf @@     got struct drbd_net_conf [noderef] __rcu *net_conf @@
   drivers/block/drbd/drbd_receiver.c:7890:22: sparse:     expected struct drbd_net_conf *old_net_conf
   drivers/block/drbd/drbd_receiver.c:7890:22: sparse:     got struct drbd_net_conf [noderef] __rcu *net_conf
   drivers/block/drbd/drbd_receiver.c:8083:30: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8083:30: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8083:30: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8083:30: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8083:30: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8083:30: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8084:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8084:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8084:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8084:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8084:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8084:31: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8186:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8186:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8186:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8186:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8186:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8186:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8186:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8186:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8186:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8186:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8187:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8187:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8187:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8187:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8187:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8187:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8187:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8187:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8187:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8187:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8188:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8188:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8188:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8188:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8188:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8188:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8188:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8188:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8188:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8188:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8217:46: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8217:46: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8217:46: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8217:46: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8217:46: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8217:46: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8219:16: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:8219:16: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:8219:16: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:8219:16: sparse: sparse: cast to restricted __be16
>> drivers/block/drbd/drbd_receiver.c:8286:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct drbd_disk_conf *old_disk_conf @@     got struct drbd_disk_conf [noderef] __rcu *disk_conf @@
   drivers/block/drbd/drbd_receiver.c:8286:39: sparse:     expected struct drbd_disk_conf *old_disk_conf
   drivers/block/drbd/drbd_receiver.c:8286:39: sparse:     got struct drbd_disk_conf [noderef] __rcu *disk_conf
   drivers/block/drbd/drbd_receiver.c:8302:61: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8302:61: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8302:61: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8302:61: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8302:61: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8302:61: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8303:60: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8303:60: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8303:60: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8303:60: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8303:60: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8303:60: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8304:58: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8304:58: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8304:58: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8304:58: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8304:58: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8304:58: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8305:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8305:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8305:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8305:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8305:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8305:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8306:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8306:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8306:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8306:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8306:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8306:48: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:8414:47: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:8414:47: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:8414:47: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:8414:47: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:8795:37: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8795:37: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8795:37: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8795:37: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8795:37: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8795:37: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8795:37: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8795:37: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8795:37: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8795:37: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8796:46: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8796:46: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8796:46: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8796:46: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8796:46: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8796:46: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8796:46: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8796:46: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8796:46: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8796:46: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8798:49: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8798:49: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8798:49: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8798:49: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8798:49: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8798:49: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8798:49: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8798:49: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8798:49: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8798:49: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8801:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8801:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8801:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8801:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8801:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8801:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8801:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8801:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8801:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8801:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8802:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8802:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8802:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8802:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8802:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8802:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8802:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8802:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8802:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8802:35: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8824:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8824:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8824:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8824:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8824:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8824:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8824:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8824:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8824:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8824:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8870:45: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8870:45: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8870:45: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:8870:45: sparse: sparse: cast to restricted __be64
--
   drivers/block/drbd/drbd_receiver.c:11669:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11669:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11669:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11669:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11669:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11669:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11670:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11670:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11670:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11670:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11670:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11670:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11670:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11670:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11670:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11670:55: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11672:78: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11672:78: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11672:78: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11672:78: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11672:78: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11672:78: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11672:78: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11672:78: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11672:78: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11672:78: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11691:74: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11691:74: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11691:74: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11691:74: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11691:74: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11691:74: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11691:74: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11691:74: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11691:74: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11691:74: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11692:73: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11692:73: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11692:73: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11692:73: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11692:73: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11692:73: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:11824:24: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11824:24: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11824:24: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11824:24: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11824:24: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11824:24: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11824:24: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11824:24: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11824:24: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11824:24: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11825:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11825:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11825:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11825:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11825:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11825:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11825:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11825:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11825:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:11825:22: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12071:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12071:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12071:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12071:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12071:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12071:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12071:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12071:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12071:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12071:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12072:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:12072:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:12072:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:12072:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:12072:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:12072:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:12077:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12077:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12077:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12077:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12077:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12077:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12077:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12077:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12077:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12077:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:12078:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:12078:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:12078:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:12078:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:12078:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:12078:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13262:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] protocol_min @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:13262:25: sparse:     expected unsigned int [usertype] protocol_min
   drivers/block/drbd/drbd_receiver.c:13262:25: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_receiver.c:13263:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] protocol_max @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:13263:25: sparse:     expected unsigned int [usertype] protocol_max
   drivers/block/drbd/drbd_receiver.c:13263:25: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_receiver.c:13264:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sender_node_id @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:13264:27: sparse:     expected unsigned int [usertype] sender_node_id
   drivers/block/drbd/drbd_receiver.c:13264:27: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_receiver.c:13265:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] receiver_node_id @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:13265:29: sparse:     expected unsigned int [usertype] receiver_node_id
   drivers/block/drbd/drbd_receiver.c:13265:29: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_receiver.c:13266:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] feature_flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:13266:26: sparse:     expected unsigned int [usertype] feature_flags
   drivers/block/drbd/drbd_receiver.c:13266:26: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_receiver.c:13313:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13313:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13313:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13313:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13313:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13313:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13314:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13314:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13314:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13314:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13314:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13314:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13339:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13339:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13339:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13339:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13339:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13339:54: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13380:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13380:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13380:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13380:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13380:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13380:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13381:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13385:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13385:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13385:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13385:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13385:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13385:21: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13386:25: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_receiver.c:13527:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] i @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:13527:29: sparse:     expected unsigned int [usertype] i
   drivers/block/drbd/drbd_receiver.c:13527:29: sparse:     got restricted __be32 [usertype]
>> drivers/block/drbd/drbd_receiver.c:13576:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [usertype] i @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:13576:32: sparse:     expected unsigned int [addressable] [usertype] i
   drivers/block/drbd/drbd_receiver.c:13576:32: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_receiver.c:13733:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13733:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13733:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13733:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13733:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13733:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13733:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13733:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13733:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13733:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13734:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13734:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13734:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13734:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13734:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13734:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13735:56: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13735:56: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13735:56: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13735:56: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13735:56: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13735:56: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13735:56: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13735:56: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13735:56: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13735:56: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13755:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13755:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13755:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13755:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13755:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13755:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13776:56: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13776:56: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13776:56: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13776:56: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13776:56: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13776:56: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13777:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13777:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13777:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13777:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13777:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13777:42: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13787:43: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13787:43: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13787:43: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13787:43: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13787:43: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13787:43: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13787:43: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13787:43: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13787:43: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13787:43: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13802:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13802:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13802:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13802:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13802:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13802:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13802:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13802:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13802:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13802:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13804:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13804:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13804:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13804:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13804:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13804:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13804:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13804:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13804:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13804:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13811:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13811:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13811:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13811:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13811:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13811:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13811:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13811:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13811:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13811:41: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13812:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13812:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13812:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13812:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13812:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13812:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13812:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13812:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13812:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13812:44: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:13831:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13831:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13831:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:13831:17: sparse: sparse: cast to restricted __be32
--
   drivers/block/drbd/drbd_receiver.c:14432:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14432:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14432:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14432:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14454:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14454:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14454:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14454:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14454:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14454:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14454:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14454:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14454:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14454:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14455:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14455:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14455:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14455:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14455:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14455:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14457:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14457:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14457:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14457:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14457:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14457:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14458:53: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14458:53: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14458:53: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14458:53: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14458:53: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14458:53: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14458:53: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14458:53: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14458:53: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14458:53: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14462:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14462:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14462:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14462:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14462:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14462:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14462:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14462:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14462:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14462:26: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14463:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14463:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14463:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14463:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14463:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14463:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14465:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14465:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14465:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14465:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14465:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14465:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14466:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14466:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14466:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14466:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14466:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14466:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14711:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14711:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14711:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14711:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14711:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14711:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14711:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14711:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14711:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14711:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14712:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14712:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14712:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14712:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14712:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14712:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14712:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14712:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14712:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14712:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14865:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14865:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14865:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14865:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14865:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14865:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14865:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14865:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14865:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14865:30: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:14866:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14866:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14866:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14866:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14866:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:14866:33: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_receiver.c:9794:37: sparse: sparse: dereference of noderef expression
   drivers/block/drbd/drbd_receiver.c: note: in included file:
   drivers/block/drbd/drbd_vli.h:301:23: sparse: sparse: cast to restricted __le64
   drivers/block/drbd/drbd_vli.h:301:23: sparse: sparse: cast to restricted __le64

vim +91 drivers/block/drbd/drbd_legacy_84.c

bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   75  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   76  /*
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   77   * 8.4 meta-data has one peer slot and no node ids. Before the first connect
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   78   * (my_node_id == -1) decode it into slot 0; drbd_setup_node_ids_84() moves
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   79   * it to the peer's slot. Once the node ids are set, decode it there right
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   80   * away, where drbd_md_peer_84() finds it once attach has set md->node_id.
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   81   */
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   82  void drbd_md_decode_84(struct meta_data_on_disk_84 *on_disk, struct drbd_md *md,
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   83  		       int my_node_id)
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   84  {
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   85  	struct drbd_peer_md *peer_md;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   86  	const int peer_node_id = my_node_id == 0 ? 1 : 0;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   87  	u32 on_disk_flags;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   88  	unsigned long flags;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   89  	int i;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   90  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  @91  	md->effective_size = be64_to_cpu(on_disk->la_size_sect);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   92  	md->current_uuid = be64_to_cpu(on_disk->uuid[UI_CURRENT]);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   93  	md->prev_members = 0;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   94  	md->prev_features = 0; /* no features field in the drbd-8.4 meta-data */
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   95  	md->device_uuid = be64_to_cpu(on_disk->device_uuid);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  @96  	md->md_size_sect = be32_to_cpu(on_disk->md_size_sect);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   97  	md->al_offset = be32_to_cpu(on_disk->al_offset);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   98  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25   99  	md->bm_offset = be32_to_cpu(on_disk->bm_offset);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  100  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  101  	on_disk_flags = be32_to_cpu(on_disk->flags);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  102  	md->flags = on_disk_flags & MDF_84_MASK;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  103  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  104  	md->max_peers = 1;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  105  	md->bm_block_size = be32_to_cpu(on_disk->bm_bytes_per_bit);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  106  	md->node_id = -1; /* no node_id in the drbd-8.4 meta-data */
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  107  	md->al_stripes = be32_to_cpu(on_disk->al_stripes);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  108  	md->al_stripe_size_4k = be32_to_cpu(on_disk->al_stripe_size_4k);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  109  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  110  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  111  	for (i = 0; i < DRBD_NODE_ID_MAX; i++) {
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  112  		peer_md = &md->peers[i];
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  113  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  114  		peer_md->bitmap_uuid = 0;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  115  		peer_md->bitmap_dagtag = 0;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  116  		peer_md->flags = 0;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  117  		peer_md->bitmap_index = -1;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  118  	}
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  119  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  120  	peer_md = &md->peers[peer_node_id];
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  121  	peer_md->bitmap_index = 0;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  122  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  123  	flags = (on_disk_flags & MDF_84_PEER_MASK) | MDF_HAVE_BITMAP;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  124  	flags |= on_disk_flags & MDF_84_PEER_OUTDATED ? MDF_PEER_OUTDATED : 0;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  125  	flags |= on_disk_flags & MDF_84_CONNECTED_IND ? MDF_PEER_CONNECTED : 0;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  126  	peer_md->flags = flags;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  127  	/* An 8.4 bitmap fully records the divergence; set the UUID (and its
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  128  	 * divergence flag) after the other flags so it is not overwritten.
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  129  	 */
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  130  	drbd_set_peer_bitmap_uuid(peer_md, be64_to_cpu(on_disk->uuid[UI_BITMAP]), 0);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  131  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  132  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  133  	for (i = 0; i < HISTORY_UUIDS_V08; i++)
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  134  		md->history_uuids[i] = be64_to_cpu(on_disk->uuid[UI_HISTORY_START + i]);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  135  }
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  136  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  137  void drbd_md_encode_84(struct drbd_device *device, struct meta_data_on_disk_84 *buffer)
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  138  {
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  139  	struct drbd_md *md = &device->ldev->md;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  140  	struct drbd_peer_md *peer_md = drbd_md_peer_84(md);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  141  	u32 flags = (md->flags & MDF_84_MASK) | (peer_md->flags & MDF_84_PEER_MASK);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  142  	int i;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  143  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  144  	if (device->bitmap == NULL)
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  145  		flags |= MDF_PEER_FULL_SYNC;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  146  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  147  	flags |= test_bit(__MDF_PEER_OUTDATED, &peer_md->flags) ? MDF_84_PEER_OUTDATED : 0;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  148  	flags |= test_bit(__MDF_PEER_CONNECTED, &peer_md->flags) ? MDF_84_CONNECTED_IND : 0;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @149  	buffer->la_size_sect = cpu_to_be64(md->effective_size);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @150  	buffer->device_uuid = cpu_to_be64(md->device_uuid);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @151  	buffer->uuid[UI_CURRENT] = cpu_to_be64(md->current_uuid);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  152  	buffer->uuid[UI_BITMAP] = cpu_to_be64(peer_md->bitmap_uuid);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  153  	for (i = 0; i < HISTORY_UUIDS_V08; i++)
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  154  		buffer->uuid[UI_HISTORY_START + i] = cpu_to_be64(md->history_uuids[i]);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  155  	buffer->reserved_u64_1 = 0;
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @156  	buffer->flags = cpu_to_be32(flags);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @157  	buffer->magic = cpu_to_be32(DRBD_MD_MAGIC_84_UNCLEAN);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @158  	buffer->md_size_sect = cpu_to_be32(md->md_size_sect);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @159  	buffer->al_offset = cpu_to_be32(md->al_offset);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @160  	buffer->al_nr_extents = cpu_to_be32(device->act_log->nr_elements);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @161  	buffer->bm_offset = cpu_to_be32(md->bm_offset);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @162  	buffer->bm_bytes_per_bit = cpu_to_be32(BM_BLOCK_SIZE_4k); /* treat as magic number */
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @163  	buffer->la_peer_max_bio_size = cpu_to_be32(device->device_conf.max_bio_size);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  164  
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @165  	buffer->al_stripes = cpu_to_be32(md->al_stripes);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25 @166  	buffer->al_stripe_size_4k = cpu_to_be32(md->al_stripe_size_4k);
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  167  }
bd3ba110bfc5d99 Christoph Böhmwalder 2026-11-25  168  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
