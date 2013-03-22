Return-Path: <axboe@kernel.dk>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A1E521019A78
	for <drbd-dev@lists.linbit.com>; Fri, 22 Mar 2013 18:33:24 +0100 (CET)
Date: Fri, 22 Mar 2013 11:17:06 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20130322171706.GF1628@kernel.dk>
References: <1363713419-17803-1-git-send-email-philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1363713419-17803-1-git-send-email-philipp.reisner@linbit.com>
Cc: lars.ellenberg@linbit.com, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/18] RFC: Non blocking submit for activity
	log misses
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

On Tue, Mar 19 2013, Philipp Reisner wrote:
> The Issues
> 
> Since the beginning DRBD was written with the assumption that the write
> pattern has spacial locality. (This assumption was driven from the fact,
> that rotating media performs better if you do not send the head too far too
> often)
> 
> Backed by this assumption a caller that submits a request that is outside of
> the current active set, was blocked until the active set was changed.
> (Changing the active set is a synchronous write operation to the meta-data
> area on the backing storage = "an AL-update" in DRBD-speak)
> 
> A second effect was that DRBD's meta-data was located in a very narrow
> area. When DRBD is used on top of a RAID0 stripe set, this causes all
> AL-updates to got to the same disk.
> 
> 
> The Proposed Solution
> 
> This patch series improves DRBD's behavior. A submitter is no longer blocked
> in the case of a AL-miss. For this a dedicated submitter worker is introduced
> (patch 13).
> 
> In order to better distribute the AL-updates to more disks in a stripe set
> this patch series also introduces an optional striped layout of the part
> of the meta-data that holds the AL-updates (patch 4).
> 
> 
> The Results
> 
> This of course drastically improves DRBD's performance if the write pattern
> does not have any spacial locality. E.g. random writes spread out over the
> whole device.
> 
> In the test systems we have SSDs with are able to do up to 50000 writes per
> second. The test does random distributed writes over a work set size of
> 128GiB with IO depths from 1 to 1024.
> 
> At an IO depth of 64:
> without this patch we observed ~100 IOPs.
> With this patches we observed about 20000 IOPs.
> 
> Please find charts of the results here:
> http://blogs.linbit.com/p/469/843-random-writes-faster/

Patchset doesn't apply to current tree. 10/18 gets into problems, last
hunk of drbd_main.c. What is this based on?

-- 
Jens Axboe

