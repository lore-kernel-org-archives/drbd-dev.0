Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DBFA21056446
	for <drbd-dev@lists.linbit.com>; Thu, 30 Mar 2017 11:04:59 +0200 (CEST)
Date: Thu, 30 Mar 2017 11:04:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, agk@redhat.com, snitzer@redhat.com,
	shli@kernel.org, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com, dm-devel@redhat.com, linux-raid@vger.kernel.org
Message-ID: <20170330090459.GE12015@lst.de>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323155410.GD1138@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323155410.GD1138@soda.linbit>
Subject: Re: [Drbd-dev] RFC: always use REQ_OP_WRITE_ZEROES for zeroing
	offload
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

Lars, can you please take a look a patch 22 and check if it's safe?

That's the big thing I want to know before posting the next version
of the series.  If it's not safe I'd like to drop that patch.
