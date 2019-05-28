Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2940E101AC67
	for <drbd-dev@lists.linbit.com>; Tue, 28 May 2019 15:18:26 +0200 (CEST)
Received: by mail-wr1-f67.google.com with SMTP id d9so20215897wrx.0
	for <drbd-dev@lists.linbit.com>; Tue, 28 May 2019 06:18:26 -0700 (PDT)
Date: Tue, 28 May 2019 15:18:23 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Eric Wheeler <drbd-dev@lists.ewheeler.net>
Message-ID: <20190528131823.GD5803@soda.linbit>
References: <15124635.GA4107@soda.linbit>
	<1516057231-21756-1-git-send-email-drbd-dev@lists.ewheeler.net>
	<20180116072615.GA3940@infradead.org>
	<20180116094907.GD4107@soda.linbit>
	<alpine.LRH.2.11.1905101728280.1835@mx.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LRH.2.11.1905101728280.1835@mx.ewheeler.net>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: fix discard_zeroes_if_aligned
	regression
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

On Fri, May 10, 2019 at 05:36:32PM +0000, Eric Wheeler wrote:
> Hi Lars,
> 
> We just tried 4.19.x and this bugs still exists. We applied the patch 
> which was originally submitted to this thread and it still applies cleanly 
> and seems to work for our use case. You mentioned that you had some older 
> code which zeroed out unaligned discard requests (or perhaps it was for a 
> different purpose) that you may be able to use to patch this. Could you 
> dig those up and see if we can get this solved?
> 
> It would be nice to be able to use drbd with thin backing volumes from the 
> vanilla kernel. If this has already been fixed in something newer than 
> 4.19, then please point me to the commit.

I think it was merged upstream in 5.0
f31e583aa2c2 drbd: introduce P_ZEROES (REQ_OP_WRITE_ZEROES on the "wire")

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
