Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 12D5B1056446
	for <drbd-dev@lists.linbit.com>; Thu, 20 Apr 2017 03:34:31 +0200 (CEST)
To: Paolo Bonzini <pbonzini@redhat.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170405172125.22600-1-hch@lst.de>
	<20170405172125.22600-27-hch@lst.de>
	<58c3d6a6-924e-cc86-1907-a9fd02a39c0e@redhat.com>
Date: Wed, 19 Apr 2017 21:34:18 -0400
In-Reply-To: <58c3d6a6-924e-cc86-1907-a9fd02a39c0e@redhat.com> (Paolo
	Bonzini's message of "Wed, 19 Apr 2017 16:56:31 +0200")
Message-ID: <yq1a87bsvz9.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, martin.petersen@oracle.com,
	snitzer@redhat.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, lars.ellenberg@linbit.com,
	shli@kernel.org, Christoph Hellwig <hch@lst.de>, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 26/27] scsi: sd: Separate zeroout and discard
	command choices
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


Paolo,

> Should this be conditional on lbprz, lbpws, lbpws10 and max_ws_blocks?

It is intentional that things can be overridden from userland for
devices that report the "wrong" thing. We do the same for discard so
people can set up udev rules.

-- 
Martin K. Petersen	Oracle Linux Engineering
