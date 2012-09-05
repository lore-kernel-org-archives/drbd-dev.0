Return-Path: <htejun@gmail.com>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 502D9100540F
	for <drbd-dev@lists.linbit.com>; Wed,  5 Sep 2012 10:49:21 +0200 (CEST)
Received: by dadr6 with SMTP id r6so253026dad.27
	for <drbd-dev@lists.linbit.com>; Wed, 05 Sep 2012 01:49:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 5 Sep 2012 01:49:15 -0700
From: Tejun Heo <tj@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20120905084915.GF3195@dhcp-172-17-108-109.mtv.corp.google.com>
References: <8439412.RChiDciQdh@fat-tyre>
	<20120904224620.GB9092@dhcp-172-17-108-109.mtv.corp.google.com>
	<3029802.oqG0dEY71l@fat-tyre>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3029802.oqG0dEY71l@fat-tyre>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] FLUSH/FUA documentation & code discrepancy
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Sep 05, 2012 at 10:44:55AM +0200, Philipp Reisner wrote:
> > Currently, FLUSH/FUA doesn't enforce any ordering requirement.  File
> > systems are responsible for draining all writes which have to happen
> > before and not issue further writes which should come after.
> 
> Ok. That is a clear statement. So we will do it that way.
> 
> The "Currently" in you statement, suggests that there might be something
> more mighty in the future. Is that true?

Heh, I was more thinking about the past.  We used to have barrier
support with much stricter ordering.  I don't think we're gonna change
the ordering requirement in any foreseeable future.

Thanks.

-- 
tejun
