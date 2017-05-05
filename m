Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CB0B41057FCB
	for <drbd-dev@lists.linbit.com>; Fri,  5 May 2017 10:57:14 +0200 (CEST)
Date: Fri, 5 May 2017 10:57:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <20170505085713.GA5008@lst.de>
References: <20170412084809.8245-1-hch@lst.de> <yq1mvbjwwvl.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1mvbjwwvl.fsf@oracle.com>
Cc: axboe@kernel.dk, linux-scsi@vger.kernel.org, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, lars.ellenberg@linbit.com,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] remove REQ_OP_WRITE_SAME
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

On Thu, Apr 13, 2017 at 10:23:10PM -0400, Martin K. Petersen wrote:
> The other thing that keeps me a bit on the fence is that a bunch of the
> plumbing to handle a bio with a payload different from bi_size is needed
> for the copy offload token. I'm hoping to have those patches ready for
> 4.13. Right now there are a bunch of places where handling of
> REQ_OP_COPY_IN and REQ_OP_COPY_OUT share conditionals with WRITE SAME.

Any chance to get a sneak preview of that work?
