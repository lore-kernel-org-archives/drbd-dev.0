Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [93.163.65.50])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AC46A1063E15
	for <drbd-dev@lists.linbit.com>; Tue,  6 Oct 2009 09:31:17 +0200 (CEST)
Date: Tue, 6 Oct 2009 09:31:16 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Message-ID: <20091006073116.GE5216@kernel.dk>
References: <20091006140154.8d94d95c.sfr@canb.auug.org.au>
	<20091006071700.GA7665@johann>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091006071700.GA7665@johann>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] linux-next: block/drbd tree build warning
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Oct 06 2009, Lars Ellenberg wrote:
> On Tue, Oct 06, 2009 at 02:01:54PM +1100, Stephen Rothwell wrote:
> > Hi Jens, Philipp,
> > 
> > Today's linux-next build (x86_64 allmodconfig) produced this warning:
> > 
> > drivers/block/drbd/drbd_nl.c: In function 'drbd_nl_init':
> > drivers/block/drbd/drbd_nl.c:2309: warning: passing argument 3 of 'cn_add_callback' from incompatible pointer type
> > include/linux/connector.h:167: note: expected 'void (*)(struct cn_msg *, struct netlink_skb_parms *)' but argument is of type 'void (*)(struct cn_msg *)'
> 
> Thanks, expected after our connector related patches got in.

Thanks for fixing it quickly, I've added the patch and updated for-next.

-- 
Jens Axboe

