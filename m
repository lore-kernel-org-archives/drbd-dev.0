Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 546881013803
	for <drbd-dev@lists.linbit.com>; Wed,  5 Sep 2012 10:44:57 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Date: Wed, 05 Sep 2012 10:44:55 +0200
Message-ID: <3029802.oqG0dEY71l@fat-tyre>
In-Reply-To: <20120904224620.GB9092@dhcp-172-17-108-109.mtv.corp.google.com>
References: <8439412.RChiDciQdh@fat-tyre>
	<20120904224620.GB9092@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] FLUSH/FUA documentation & code discrepancy
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> Currently, FLUSH/FUA doesn't enforce any ordering requirement.  File
> systems are responsible for draining all writes which have to happen
> before and not issue further writes which should come after.

Ok. That is a clear statement. So we will do it that way.

The "Currently" in you statement, suggests that there might be something
more mighty in the future. Is that true?

We are looking for a method that allows us to submit some writes, then
an IO-barrier, and then further writes. 

Best,
 Phil
