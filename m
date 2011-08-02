Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (unknown [95.166.99.235])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7118810567A3
	for <drbd-dev@lists.linbit.com>; Tue,  2 Aug 2011 12:44:04 +0200 (CEST)
Message-ID: <4E37D4F5.7050203@kernel.dk>
Date: Tue, 02 Aug 2011 12:44:05 +0200
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: akpm@linux-foundation.org
References: <201107282052.p6SKq1TZ007835@imap1.linux-foundation.org>
In-Reply-To: <201107282052.p6SKq1TZ007835@imap1.linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: hsweeten@visionengravers.com, hartleys@visionengravers.com,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [patch 1/1] drivers/block/drbd/drbd_nl.c: use
 bitmap_parse instead of __bitmap_parse
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2011-07-28 22:52, akpm@linux-foundation.org wrote:
> From: H Hartley Sweeten <hartleys@visionengravers.com>
> 
> The buffer 'sc.cpu_mask' is a kernel buffer.  If bitmap_parse is used
> instead of __bitmap_parse the extra parameter that indicates a kernel
> buffer is not needed.

Applied, thanks.

-- 
Jens Axboe

