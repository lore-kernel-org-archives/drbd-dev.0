Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 829A1105648F
	for <drbd-dev@lists.linbit.com>; Wed, 12 Apr 2017 07:51:02 +0200 (CEST)
Date: Wed, 12 Apr 2017 07:51:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Message-ID: <20170412055102.GA20020@lst.de>
References: <20170410160807.23674-1-hch@lst.de>
	<20170410160807.23674-3-hch@lst.de>
	<1491975041.8231.131.camel@haakon3.risingtidesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491975041.8231.131.camel@haakon3.risingtidesystems.com>
Cc: axboe@kernel.dk, linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
	philipp.reisner@linbit.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	lars.ellenberg@linbit.com, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/8] target: remove iblock WRITE_SAME
	passthrough	support
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

Hi Nic,

this patch looks fine, and I'll include it for the next post.  I'll
move some of the explanation in this mail into the patch, though.
