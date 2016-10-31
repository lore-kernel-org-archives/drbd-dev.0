Return-Path: <BATV+d7add8a7bef99f8e6f52+4817+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DE09C10556DB
	for <drbd-dev@lists.linbit.com>; Mon, 31 Oct 2016 16:54:05 +0100 (CET)
Date: Mon, 31 Oct 2016 08:25:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Message-ID: <20161031152519.GA25791@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@redhat.com>,
	Takashi Iwai <tiwai@suse.de>,
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"open list:NVM EXPRESS TARGET DRIVER" <linux-nvme@lists.infradead.org>,
	Zheng Liu <gnehzuil.liu@gmail.com>, Keith Busch <keith.busch@intel.com>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	"open list:DEVICE-MAPPER  \(LVM\)" <dm-devel@redhat.com>,
	"open list:TARGET SUBSYSTEM" <target-devel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>, "open list:LogFS" <logfs@logfs.org>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>,
	Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	"open list:GFS2 FILE SYSTEM" <cluster-devel@redhat.com>,
	Mike Christie <mchristi@redhat.com>, Guoqing Jiang <gqjiang@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Petr Mladek <pmladek@suse.com>, Johannes Berg <johannes.berg@intel.com>,
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
	Toshi Kani <toshi.kani@hpe.com>, Coly Li <colyli@suse.de>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kent Overstreet <kmo@daterainc.com>, Hannes Reinecke <hare@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	"open list:BCACHE \(BLOCK LAYER CACHE\)" <linux-bcache@vger.kernel.org>,
	Jens Axboe <axboe@fb.com>,
	"open list:SOFTWARE RAID \(Multiple Disks\) SUPPORT"
	<linux-raid@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	linux-kernel@vger.kernel.org,
	"open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
	"open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
	Minchan Kim <minchan@kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
	Minfei Huang <mnghuan@gmail.com>,
	Zheng Liu <wenqing.lz@taobao.com>, Joe Perches <joe@perches.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Wheeler <git@linux.ewheeler.net>,
	"open list:OSD LIBRARY and FILESYSTEM" <osd-dev@open-osd.org>
Subject: Re: [Drbd-dev] [PATCH 00/60] block: support multipage bvec
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

Hi Ming,

can you send a first patch just doing the obvious cleanups like
converting to bio_add_page and replacing direct poking into the
bio with the proper accessors?  That should help reducing the
actual series to a sane size, and it should also help to cut
down the Cc list.

