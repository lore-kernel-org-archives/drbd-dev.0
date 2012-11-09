Return-Path: <axboe@kernel.dk>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BDAFB1055F44
	for <drbd-dev@lists.linbit.com>; Fri,  9 Nov 2012 10:25:01 +0100 (CET)
Message-ID: <509CCBEA.3070201@kernel.dk>
Date: Fri, 09 Nov 2012 10:24:58 +0100
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <20121109001231.98243100047@wpzn3.hot.corp.google.com>
	<2422446.NXjlELuTI5@fat-tyre>
In-Reply-To: <2422446.NXjlELuTI5@fat-tyre>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: akpm@linux-foundation.org, akinobu.mita@gmail.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [patch 6/6] drbd: use copy_highpage
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2012-11-09 10:24, Philipp Reisner wrote:
> Thanks, I will put it in my tree today.

Philip, I already queued it up in for-linus for 3.7.

-- 
Jens Axboe

