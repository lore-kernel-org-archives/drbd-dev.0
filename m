Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7E4111057FD4
	for <drbd-dev@lists.linbit.com>; Thu,  1 Jun 2017 08:28:46 +0200 (CEST)
Date: Thu, 1 Jun 2017 08:28:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Message-ID: <20170601062845.GA16682@lst.de>
References: <20170410160807.23674-1-hch@lst.de>
	<20170410160807.23674-3-hch@lst.de>
	<1491975041.8231.131.camel@haakon3.risingtidesystems.com>
	<1496298421.27407.206.camel@haakon3.risingtidesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496298421.27407.206.camel@haakon3.risingtidesystems.com>
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

On Wed, May 31, 2017 at 11:27:01PM -0700, Nicholas A. Bellinger wrote:
> Hey HCH & Jens,
> 
> Is this already queued up for v4.13 to address the missing LBPRZ feature
> bit..?
> 
> If not, I'll happy to take it via target-pending along with the
> following to re-enable it via max_write_zeroes_sectors.

It's not queued up.  Feel free to take it through the target tree.
