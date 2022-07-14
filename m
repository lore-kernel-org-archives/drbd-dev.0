Return-Path: <tytso@mit.edu>
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CA2F1420F75
	for <drbd-dev@lists.linbit.com>; Thu, 14 Jul 2022 17:00:03 +0200 (CEST)
Date: Thu, 14 Jul 2022 10:54:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <YtAuHaiK+Me08swz@mit.edu>
References: <20220713055317.1888500-1-hch@lst.de>
	<20220713055317.1888500-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713055317.1888500-9-hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
	Mark Fasheh <mark@fasheh.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Joel Becker <jlbec@evilplan.org>, Jan Kara <jack@suse.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	linux-ext4@vger.kernel.org, Jack Wang <jinpu.wang@ionos.com>,
	ocfs2-devel@oss.oracle.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 8/9] ext4: only initialize mmp_bdevname once
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

On Wed, Jul 13, 2022 at 07:53:16AM +0200, Christoph Hellwig wrote:
> mmp_bdevname is currently both initialized nested inside the kthread_run
> call in ext4_multi_mount_protect and in the kmmpd thread started by it.
> 
> Lift the initiaization out of the kthread_run call in
> ext4_multi_mount_protect, move the BUILD_BUG_ON next to it and remove
> the duplicate assignment inside of kmmpd.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Theodore Ts'o <tytso@mit.edu>
