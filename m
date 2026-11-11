Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378916;
	b=n0LPzGHsuFbdOW8IhD5yqYyUCrXspZFkubSTacmfSxjdWAL1TSJABzb5gzQpYAiK2KJ8
	 wk8LnxdewSPlWdFrAB1WUUfA6D2G6XewIZ76Y6G72mL1STZqqB8IVNgoKfw7s8mUMKSR3
	 9iZ84HGv5UfDlr04v1THzkSa6nV54eUFEmDzzYb0OnSJPtRhVIzjf4HyOLVPI9N8iKwkC
	 ndx93192cnrFsfzAJYxLx45UWQZ4k76ZJsjXHWOWoxITxqhMf7i0UzJczhcJkZSbw2sTv
	 ALH+DJwtb1G6y8I4E6hHQlGOAsWUY0F+QRwdII0QcQtu1Y4M+WN+gYPZQFp4+JBWC3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378916;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=LfrfIaPttMHy+NA0zvlHejMmVLNzLwc+BVG+NmJ2ceI=;
	b=GCjpH3U4TURMItHQhKic0fiGAMaOFk0SJIoW/3MbG6YkhsJWcYTazT2Dq0jt0QUQw2cc
	 X28yXM1hZok04yhGMI4KmKNRJCQGD0c7Ni/dipwZP4t6j0L1+dr/DnoRukg3l9MPpjWNj
	 HBlvoLs6m7jRDuaSvbJwflND7fZ8YskAKmAyYY6fOcCT9F0oRndqUy/ncD7WfjArtOO59
	 n7KAa8xYoh/D9PyTe98Tv0uXs2qop9MhBcDZd+XQJ/WFWp5tZUbaNp3jmmS1m3CQ4mnES
	 6G0htijjEFw0ZnwgGx1Hj4hV1BRUCcz3quMRC+1UZ51bGA2jrraiJnPR4AqdHgBIw6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wv8pIcIT;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99630606A31C;
	Wed, 11 Nov 2026 06:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99630606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wv8pIcIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794378915; x=1825914915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xhFBa4njc9EoXTAaq558iOAlHkCa8Su/UIORcA2qYro=;
  b=Wv8pIcITxgUEde2U0eXo9PXAfzJUIYKqe+vvDwIKalqw5y/eQXADre79
   XFQbPo5MjRwQ5TCYX+yXPgyIfhAg5kUXvQ8yFceYXmneCWl2wO0h7dOa1
   ulsyn28BWXT5A4Yn4aj+EuZT0waLrdqO5BRLSPT6Pe2KFgqEGVJpPVEPm
   znmZ5EmJI9zE8wTI8XDWLWduAwXxn5mQMp6SAXHxv+nKH1Qw4KRzMB+1h
   ddk1NwrrZDFUijiWdDQ+lXoeuFRRHjsyqmjwXi6OABZYRtJVYcth5kKFy
   tceljukKLit24vwIV0Pse/6yZHbG0JIv/oASpTApNWpLGO1fiqVqP6NDb
   A==;
X-CSE-ConnectionGUID: kZPNUumeTGWoXo3D77e8Nw==
X-CSE-MsgGUID: zlFD2BXwT/C8CwYZ+JhxAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3046357"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3046357"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 22:35:14 -0800
X-CSE-ConnectionGUID: SYVqADMXQtCcqIHgGHaURg==
X-CSE-MsgGUID: yaBwFRXMQ1S1C44y/ZnpQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8203937"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Nov 2026 22:35:11 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xR1vI-00000000yHH-3MXn;
	Wed, 11 Nov 2026 06:35:08 +0000
Date: Wed, 11 Nov 2026 14:34:47 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH v3 20/20] drbd: remove BROKEN for DRBD
Message-ID: <202611111410.3QaA5yy6-lkp@intel.com>
References: <20261110162646.3028472-21-christoph.boehmwalder@linbit.com>
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
In-Reply-To: <20261110162646.3028472-21-christoph.boehmwalder@linbit.com>

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aa7014f8d7565cfea117eac36a5de0a05eba65a4]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-mark-as-BROKEN-during-DRBD-9-rework/20261110-172626
base:   aa7014f8d7565cfea117eac36a5de0a05eba65a4
patch link:    https://lore.kernel.org/r/20261110162646.3028472-21-christoph.boehmwalder%40linbit.com
patch subject: [PATCH v3 20/20] drbd: remove BROKEN for DRBD
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20261111/202611111410.3QaA5yy6-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611111410.3QaA5yy6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611111410.3QaA5yy6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/block/drbd/drbd_nl_84.c: In function 'compat84_overlay':
>> drivers/block/drbd/drbd_nl_84.c:1125:1: warning: the frame size of 1856 bytes is larger than 1536 bytes [-Wframe-larger-than=]
    1125 | }
         | ^


vim +1125 drivers/block/drbd/drbd_nl_84.c

4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   693  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   694  /*
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   695   * The generated *_from_attrs() parsers fill the vendored v1 wire
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   696   * structs (struct disk_conf, struct net_conf, ...), whose field sets
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   697   * differ from the core's neutral structs, so every set below parses into
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   698   * a local v1 struct and translates field by field into dst.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   699   *
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   700   * For the persistent config sets (disk_conf, net_conf, res_opts), dst
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   701   * already holds the object's current values. The parser only writes a
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   702   * field whose attribute is present, so the local struct is pre-seeded
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   703   * from dst and copied back whole: an absent attribute round-trips its
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   704   * old value, preserving drbd_nl.h's "absent attributes leave dst
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   705   * untouched" contract. Most one-shot action parms start from a zeroed
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   706   * dst, so a zeroed local struct already matches; resize_parms and
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   707   * start_ov_parms do not, and are pre-seeded the same way.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   708   *
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   709   * The v1 disk_conf treats backing_dev/meta_dev/meta_dev_idx as required, so
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   710   * a plain disk-options call parses with err == -ENOMSG while every other
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   711   * field is still filled in. drbd_nl.c tolerates -ENOMSG as non-fatal, so
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   712   * each case copies back (and stashes) before returning err, never on an
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   713   * early return.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   714   */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   715  static int compat84_overlay(struct drbd_adm_ctx *ctx, enum drbd_nl_attr_set set, void *dst)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   716  {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   717  	struct genl_info *info = compat84_req(ctx)->info;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   718  	struct compat84_req *req = compat84_req(ctx);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   719  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   720  	switch (set) {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   721  	case DRBD_NL_SET_DISK_CONF: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   722  		struct drbd_disk_conf *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   723  		struct disk_conf c = {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   724  			.meta_dev_idx			= d->meta_dev_idx,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   725  			.disk_size			= d->disk_size,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   726  			.on_io_error			= d->on_io_error,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   727  			.resync_after			= d->resync_after,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   728  			.al_extents			= d->al_extents,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   729  			.disk_barrier			= d->disk_barrier,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   730  			.disk_flushes			= d->disk_flushes,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   731  			.disk_drain			= d->disk_drain,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   732  			.md_flushes			= d->md_flushes,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   733  			.disk_timeout			= d->disk_timeout,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   734  			.read_balancing			= d->read_balancing,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   735  			.al_updates			= d->al_updates,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   736  			.discard_zeroes_if_aligned	= d->discard_zeroes_if_aligned,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   737  			.rs_discard_granularity		= d->rs_discard_granularity,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   738  			.disable_write_same		= d->disable_write_same,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   739  		};
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   740  		struct nlattr **ntb;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   741  		int err, ntb_err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   742  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   743  		memcpy(c.backing_dev, d->backing_dev, sizeof(c.backing_dev));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   744  		c.backing_dev_len = d->backing_dev_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   745  		memcpy(c.meta_dev, d->meta_dev, sizeof(c.meta_dev));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   746  		c.meta_dev_len = d->meta_dev_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   747  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   748  		err = disk_conf_from_attrs(&c, info);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   749  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   750  		/*
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   751  		 * Copy back and stash before returning err: -ENOMSG from a
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   752  		 * plain disk-options call (see above) must not discard the
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   753  		 * fields it did send. Any other error leaves c at its
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   754  		 * pre-seeded values, so copying back is a no-op.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   755  		 */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   756  		memcpy(d->backing_dev, c.backing_dev, sizeof(d->backing_dev));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   757  		d->backing_dev_len = c.backing_dev_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   758  		memcpy(d->meta_dev, c.meta_dev, sizeof(d->meta_dev));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   759  		d->meta_dev_len = c.meta_dev_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   760  		d->meta_dev_idx = c.meta_dev_idx;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   761  		d->disk_size = c.disk_size;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   762  		d->on_io_error = c.on_io_error;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   763  		d->resync_after = c.resync_after;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   764  		d->al_extents = c.al_extents;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   765  		d->disk_barrier = c.disk_barrier;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   766  		d->disk_flushes = c.disk_flushes;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   767  		d->disk_drain = c.disk_drain;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   768  		d->md_flushes = c.md_flushes;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   769  		d->disk_timeout = c.disk_timeout;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   770  		d->read_balancing = c.read_balancing;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   771  		d->al_updates = c.al_updates;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   772  		d->discard_zeroes_if_aligned = c.discard_zeroes_if_aligned;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   773  		d->rs_discard_granularity = c.rs_discard_granularity;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   774  		d->disable_write_same = c.disable_write_same;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   775  		/* max_bio_bvecs: no DRBD 9 equivalent, dropped. */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   776  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   777  		/*
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   778  		 * The resync-tuning fields belong to struct drbd_peer_device_conf,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   779  		 * fencing to net_conf.fencing_policy; neither is reachable
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   780  		 * through this dst. Re-parse the nested table for per-field
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   781  		 * presence and stash them for the attach/disk-options
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   782  		 * handlers.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   783  		 */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   784  		ntb_err = disk_conf_ntb_from_attrs(&ntb, info);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   785  		if ((!ntb_err || ntb_err == -ENOMSG) && ntb) {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   786  			req->peer_device_conf_84.resync_rate = c.resync_rate;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   787  			req->peer_device_conf_84.has_resync_rate =
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   788  				ntb[DRBD_A_DISK_CONF_RESYNC_RATE] != NULL;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   789  			req->peer_device_conf_84.c_plan_ahead = c.c_plan_ahead;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   790  			req->peer_device_conf_84.has_c_plan_ahead =
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   791  				ntb[DRBD_A_DISK_CONF_C_PLAN_AHEAD] != NULL;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   792  			req->peer_device_conf_84.c_delay_target = c.c_delay_target;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   793  			req->peer_device_conf_84.has_c_delay_target =
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   794  				ntb[DRBD_A_DISK_CONF_C_DELAY_TARGET] != NULL;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   795  			req->peer_device_conf_84.c_fill_target = c.c_fill_target;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   796  			req->peer_device_conf_84.has_c_fill_target =
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   797  				ntb[DRBD_A_DISK_CONF_C_FILL_TARGET] != NULL;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   798  			req->peer_device_conf_84.c_max_rate = c.c_max_rate;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   799  			req->peer_device_conf_84.has_c_max_rate =
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   800  				ntb[DRBD_A_DISK_CONF_C_MAX_RATE] != NULL;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   801  			req->peer_device_conf_84.c_min_rate = c.c_min_rate;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   802  			req->peer_device_conf_84.has_c_min_rate =
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   803  				ntb[DRBD_A_DISK_CONF_C_MIN_RATE] != NULL;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   804  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   805  			req->fencing_policy_84 = c.fencing;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   806  			req->has_fencing_policy_84 =
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   807  				ntb[DRBD_A_DISK_CONF_FENCING] != NULL;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   808  		}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   809  		kfree(ntb);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   810  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   811  		return err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   812  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   813  	case DRBD_NL_SET_NET_CONF: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   814  		struct drbd_net_conf *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   815  		struct net_conf c = {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   816  			.wire_protocol			= d->wire_protocol,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   817  			.connect_int			= d->connect_int,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   818  			.timeout			= d->timeout,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   819  			.ping_int			= d->ping_int,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   820  			.ping_timeo			= d->ping_timeo,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   821  			.sndbuf_size			= d->sndbuf_size,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   822  			.rcvbuf_size			= d->rcvbuf_size,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   823  			.ko_count			= d->ko_count,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   824  			.max_buffers			= d->max_buffers,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   825  			.max_epoch_size			= d->max_epoch_size,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   826  			.after_sb_0p			= d->after_sb_0p,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   827  			.after_sb_1p			= d->after_sb_1p,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   828  			.after_sb_2p			= d->after_sb_2p,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   829  			.rr_conflict			= d->rr_conflict,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   830  			.on_congestion			= d->on_congestion,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   831  			.cong_fill			= d->cong_fill,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   832  			.cong_extents			= d->cong_extents,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   833  			.two_primaries			= d->two_primaries,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   834  			.tcp_cork			= d->tcp_cork,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   835  			.always_asbp			= d->always_asbp,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   836  			.use_rle			= d->use_rle,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   837  			.csums_after_crash_only		= d->csums_after_crash_only,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   838  			.sock_check_timeo		= d->sock_check_timeo,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   839  		};
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   840  		struct nlattr **ntb;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   841  		int err, ntb_err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   842  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   843  		memcpy(c.shared_secret, d->shared_secret, sizeof(c.shared_secret));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   844  		c.shared_secret_len = d->shared_secret_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   845  		memcpy(c.cram_hmac_alg, d->cram_hmac_alg, sizeof(c.cram_hmac_alg));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   846  		c.cram_hmac_alg_len = d->cram_hmac_alg_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   847  		memcpy(c.integrity_alg, d->integrity_alg, sizeof(c.integrity_alg));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   848  		c.integrity_alg_len = d->integrity_alg_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   849  		memcpy(c.verify_alg, d->verify_alg, sizeof(c.verify_alg));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   850  		c.verify_alg_len = d->verify_alg_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   851  		memcpy(c.csums_alg, d->csums_alg, sizeof(c.csums_alg));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   852  		c.csums_alg_len = d->csums_alg_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   853  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   854  		err = net_conf_from_attrs(&c, info);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   855  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   856  		/* Copy back and stash before returning err, as for DISK_CONF. */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   857  		memcpy(d->shared_secret, c.shared_secret, sizeof(d->shared_secret));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   858  		d->shared_secret_len = c.shared_secret_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   859  		memcpy(d->cram_hmac_alg, c.cram_hmac_alg, sizeof(d->cram_hmac_alg));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   860  		d->cram_hmac_alg_len = c.cram_hmac_alg_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   861  		memcpy(d->integrity_alg, c.integrity_alg, sizeof(d->integrity_alg));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   862  		d->integrity_alg_len = c.integrity_alg_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   863  		memcpy(d->verify_alg, c.verify_alg, sizeof(d->verify_alg));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   864  		d->verify_alg_len = c.verify_alg_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   865  		memcpy(d->csums_alg, c.csums_alg, sizeof(d->csums_alg));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   866  		d->csums_alg_len = c.csums_alg_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   867  		d->wire_protocol = c.wire_protocol;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   868  		d->connect_int = c.connect_int;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   869  		d->timeout = c.timeout;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   870  		d->ping_int = c.ping_int;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   871  		d->ping_timeo = c.ping_timeo;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   872  		d->sndbuf_size = c.sndbuf_size;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   873  		d->rcvbuf_size = c.rcvbuf_size;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   874  		d->ko_count = c.ko_count;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   875  		d->max_buffers = c.max_buffers;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   876  		d->max_epoch_size = c.max_epoch_size;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   877  		d->after_sb_0p = c.after_sb_0p;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   878  		d->after_sb_1p = c.after_sb_1p;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   879  		d->after_sb_2p = c.after_sb_2p;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   880  		d->rr_conflict = c.rr_conflict;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   881  		d->on_congestion = c.on_congestion;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   882  		d->cong_fill = c.cong_fill;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   883  		d->cong_extents = c.cong_extents;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   884  		d->two_primaries = c.two_primaries;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   885  		d->tcp_cork = c.tcp_cork;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   886  		d->always_asbp = c.always_asbp;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   887  		d->use_rle = c.use_rle;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   888  		d->csums_after_crash_only = c.csums_after_crash_only;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   889  		d->sock_check_timeo = c.sock_check_timeo;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   890  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   891  		/*
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   892  		 * fencing is a disk option in 8.4, so "net-options
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   893  		 * --set-defaults" must not reset it: keep the live value.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   894  		 * drbd_adm_net_opts() holds conf_update.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   895  		 */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   896  		if (ctx->set_defaults && ctx->connection) {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   897  			struct drbd_net_conf *old;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   898  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   899  			rcu_read_lock();
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   900  			old = rcu_dereference(ctx->connection->transport.net_conf);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   901  			if (old)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   902  				d->fencing_policy = old->fencing_policy;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   903  			rcu_read_unlock();
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   904  		}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   905  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   906  		/*
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   907  		 * unplug_watermark is dropped: no DRBD 9 code reads it, and
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   908  		 * net_conf is connection-scoped while disk_conf, its DRBD 9
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   909  		 * home, is per device. discard_my_data/tentative belong to
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   910  		 * struct drbd_connect_parms; stash them for the connect handler.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   911  		 */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   912  		ntb_err = net_conf_ntb_from_attrs(&ntb, info);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   913  		if ((!ntb_err || ntb_err == -ENOMSG) && ntb) {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   914  			req->connect_parms_84.discard_my_data = c.discard_my_data;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   915  			req->connect_parms_84.has_discard_my_data =
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   916  				ntb[DRBD_A_NET_CONF_DISCARD_MY_DATA] != NULL;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   917  			req->connect_parms_84.tentative = c.tentative;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   918  			req->connect_parms_84.has_tentative =
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   919  				ntb[DRBD_A_NET_CONF_TENTATIVE] != NULL;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   920  		}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   921  		kfree(ntb);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   922  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   923  		/*
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   924  		 * fencing lives in the v1 disk_conf on the wire but in
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   925  		 * drbd_net_conf.fencing_policy on DRBD 9. The attach/disk-options
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   926  		 * handler stashed it while parsing disk_conf and re-enters
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   927  		 * this overlay for NET_CONF once it has the connection. A
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   928  		 * real NET_CONF request never has this flag set.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   929  		 */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   930  		if (req->has_fencing_policy_84)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   931  			d->fencing_policy = req->fencing_policy_84;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   932  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   933  		/*
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   934  		 * DRBD 9 requires a connection name; v1 has no such concept.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   935  		 * Default it only for a freshly created connection (name_len
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   936  		 * == 0), matching the name drbd9 drbdsetup's own compat84 shim
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   937  		 * passes (--_name=remote).
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   938  		 */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   939  		if (!d->name_len) {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   940  			static const char v1_conn_name[] = "remote";
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   941  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   942  			strscpy(d->name, v1_conn_name, sizeof(d->name));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   943  			d->name_len = strlen(v1_conn_name);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   944  		}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   945  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   946  		return err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   947  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   948  	case DRBD_NL_SET_RES_OPTS: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   949  		struct drbd_res_opts *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   950  		struct res_opts c = {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   951  			.on_no_data = d->on_no_data,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   952  		};
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   953  		int err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   954  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   955  		memcpy(c.cpu_mask, d->cpu_mask, sizeof(c.cpu_mask));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   956  		c.cpu_mask_len = d->cpu_mask_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   957  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   958  		err = res_opts_from_attrs(&c, info);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   959  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   960  		/*
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   961  		 * The other fourteen DRBD 9 res_opts fields have no v1
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   962  		 * attribute, so v1's --set-defaults must not reset them
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   963  		 * either: that would drop drbd8_compat_mode and
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   964  		 * explicit_drbd8_compat and turn auto_promote back on.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   965  		 * drbd_adm_resource_opts() holds adm_mutex, so the live
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   966  		 * res_opts are stable here.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   967  		 */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   968  		if (ctx->set_defaults && ctx->resource)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   969  			*d = ctx->resource->res_opts;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   970  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   971  		/* Copy back before returning err, as for DISK_CONF. */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   972  		memcpy(d->cpu_mask, c.cpu_mask, sizeof(d->cpu_mask));
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   973  		d->cpu_mask_len = c.cpu_mask_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   974  		d->on_no_data = c.on_no_data;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   975  		return err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   976  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   977  	case DRBD_NL_SET_SET_ROLE_PARMS: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   978  		struct drbd_set_role_parms *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   979  		struct set_role_parms c = { };
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   980  		int err = set_role_parms_from_attrs(&c, info);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   981  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   982  		if (err)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   983  			return err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   984  		/* v1's assume_uptodate is drbd-utils 8.9.x's wire name for --force. */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   985  		d->force = c.assume_uptodate;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   986  		return 0;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   987  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   988  	case DRBD_NL_SET_RESIZE_PARMS: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   989  		struct drbd_resize_parms *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   990  		/* drbd_adm_resize() pre-fills the current AL layout. */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   991  		struct resize_parms c = {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   992  			.resize_size = d->resize_size,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   993  			.resize_force = d->resize_force,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   994  			.no_resync = d->no_resync,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   995  			.al_stripes = d->al_stripes,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   996  			.al_stripe_size = d->al_stripe_size,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   997  		};
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   998  		int err = resize_parms_from_attrs(&c, info);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10   999  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1000  		if (err)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1001  			return err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1002  		d->resize_size = c.resize_size;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1003  		d->resize_force = c.resize_force;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1004  		d->no_resync = c.no_resync;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1005  		d->al_stripes = c.al_stripes;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1006  		d->al_stripe_size = c.al_stripe_size;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1007  		return 0;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1008  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1009  	case DRBD_NL_SET_START_OV_PARMS: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1010  		struct drbd_start_ov_parms *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1011  		/* drbd_adm_start_ov() pre-fills the resume position. */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1012  		struct start_ov_parms c = {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1013  			.ov_start_sector = d->ov_start_sector,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1014  			.ov_stop_sector = d->ov_stop_sector,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1015  		};
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1016  		int err = start_ov_parms_from_attrs(&c, info);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1017  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1018  		if (err)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1019  			return err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1020  		d->ov_start_sector = c.ov_start_sector;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1021  		d->ov_stop_sector = c.ov_stop_sector;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1022  		return 0;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1023  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1024  	case DRBD_NL_SET_NEW_C_UUID_PARMS: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1025  		struct drbd_new_c_uuid_parms *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1026  		struct new_c_uuid_parms c = { };
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1027  		int err = new_c_uuid_parms_from_attrs(&c, info);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1028  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1029  		if (err)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1030  			return err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1031  		d->clear_bm = c.clear_bm;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1032  		/* force_resync: DRBD 9 only, no v1 attribute; leave untouched. */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1033  		return 0;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1034  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1035  	case DRBD_NL_SET_DISCONNECT_PARMS: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1036  		struct drbd_disconnect_parms *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1037  		struct disconnect_parms c = { };
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1038  		int err = disconnect_parms_from_attrs(&c, info);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1039  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1040  		if (err)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1041  			return err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1042  		d->force_disconnect = c.force_disconnect;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1043  		return 0;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1044  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1045  	case DRBD_NL_SET_DETACH_PARMS: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1046  		struct drbd_detach_parms *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1047  		struct detach_parms c = { };
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1048  		int err = detach_parms_from_attrs(&c, info);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1049  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1050  		if (err)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1051  			return err;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1052  		d->force_detach = c.force_detach;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1053  		/* intentional_diskless_detach: DRBD 9 only; leave untouched. */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1054  		return 0;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1055  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1056  	case DRBD_NL_SET_PEER_DEVICE_CONF: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1057  		struct drbd_peer_device_conf *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1058  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1059  		/*
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1060  		 * Not parsed from the wire: the DISK_CONF case stashed these
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1061  		 * while parsing the disk_conf that carried them. The
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1062  		 * attach/disk-options handler re-enters overlay() for
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1063  		 * PEER_DEVICE_CONF once it has the peer device.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1064  		 */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1065  		if (req->peer_device_conf_84.has_resync_rate)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1066  			d->resync_rate = req->peer_device_conf_84.resync_rate;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1067  		if (req->peer_device_conf_84.has_c_plan_ahead)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1068  			d->c_plan_ahead = req->peer_device_conf_84.c_plan_ahead;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1069  		if (req->peer_device_conf_84.has_c_delay_target)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1070  			d->c_delay_target = req->peer_device_conf_84.c_delay_target;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1071  		if (req->peer_device_conf_84.has_c_fill_target)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1072  			d->c_fill_target = req->peer_device_conf_84.c_fill_target;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1073  		if (req->peer_device_conf_84.has_c_max_rate)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1074  			d->c_max_rate = req->peer_device_conf_84.c_max_rate;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1075  		if (req->peer_device_conf_84.has_c_min_rate)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1076  			d->c_min_rate = req->peer_device_conf_84.c_min_rate;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1077  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1078  		return 0;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1079  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1080  	case DRBD_NL_SET_PATH_PARMS: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1081  		struct drbd_path_parms *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1082  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1083  		/*
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1084  		 * v1 carries the endpoint addresses in DRBD_NLA_CFG_CONTEXT,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1085  		 * parsed once per request into req; drbd_adm_new_path()
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1086  		 * calls here once per path.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1087  		 */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1088  		if (!req->ctx_my_addr_len || !req->ctx_peer_addr_len)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1089  			return -ENOMSG;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1090  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1091  		memcpy(d->my_addr, req->ctx_my_addr, req->ctx_my_addr_len);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1092  		d->my_addr_len = req->ctx_my_addr_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1093  		memcpy(d->peer_addr, req->ctx_peer_addr, req->ctx_peer_addr_len);
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1094  		d->peer_addr_len = req->ctx_peer_addr_len;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1095  		return 0;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1096  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1097  	case DRBD_NL_SET_CONNECT_PARMS: {
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1098  		struct drbd_connect_parms *d = dst;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1099  
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1100  		/*
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1101  		 * Stashed by the NET_CONF case; dst is a fresh zeroed struct,
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1102  		 * so an unsent field already defaults to false.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1103  		 */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1104  		if (req->connect_parms_84.has_discard_my_data)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1105  			d->discard_my_data = req->connect_parms_84.discard_my_data;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1106  		if (req->connect_parms_84.has_tentative)
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1107  			d->tentative = req->connect_parms_84.tentative;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1108  		return 0;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1109  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1110  	case DRBD_NL_SET_DEVICE_CONF:
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1111  	case DRBD_NL_SET_INVALIDATE_PARMS:
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1112  	case DRBD_NL_SET_INVALIDATE_PEER_PARMS:
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1113  	case DRBD_NL_SET_FORGET_PEER_PARMS:
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1114  	case DRBD_NL_SET_RENAME_RESOURCE_PARMS:
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1115  	case DRBD_NL_SET_SUSPEND_IO_PARMS:
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1116  	case DRBD_NL_SET_CBT_START_PARMS:
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1117  		/* No v1 counterpart: report a missing required attribute
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1118  		 * rather than silently proceeding with defaults.
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1119  		 */
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1120  		return -ENOMSG;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1121  	case __DRBD_NL_SET_MAX:
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1122  		break;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1123  	}
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1124  	return -EINVAL;
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10 @1125  }
4f5fcbdce4b889 Christoph Böhmwalder 2026-11-10  1126  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
