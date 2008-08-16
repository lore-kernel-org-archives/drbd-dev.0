Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (dslb-088-075-197-174.pools.arcor-ip.net
	[88.75.197.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 63E2E2E0545C
	for <drbd-dev@lists.linbit.com>; Sat, 16 Aug 2008 18:55:19 +0200 (CEST)
Date: Sat, 16 Aug 2008 18:55:18 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Huge latency issue with 8.2.6
Message-ID: <20080816165518.GA15331@racke>
References: <DA0E7D869C862D4095C265233CD1D41EC3105F@EXNA.corp.stratus.com>
	<DA0E7D869C862D4095C265233CD1D41EEE9B7D@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DA0E7D869C862D4095C265233CD1D41EEE9B7D@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Aug 16, 2008 at 12:44:33PM -0400, Graham, Simon wrote:
> > > Conclusion 2 -- the problem here has to do with the time is takes
> > > the secondary to send the TCP ACK.
> > 
> > in git on the way to 8.2.7, we added the TCP_NODELAY socket option,
> > 
> 
> I saw that and it's goodness BUT this controls the Nagle algorithm and
> NOT the Ack Delay timer - you need (I believe) TCP_QUICKACK as well (or
> a global change on the connection to lower the ack delay but I think
> that would be bad - the nice thing about TCP_QUICKACK is that it's a one
> time setting that causes pending acks to be sent right now but does not
> change the normal ack delay).

I had the impression that the NODELAY would imply QUICKACK behaviour,
and together witht the CORK and UNCORK should do the trick.
but I'm happy to be enlightened.

will commit a slightly modified verion of your quickack soonish.

thanks,


-- 
: Lars Ellenberg                
: LINBIT HA-Solutions GmbH
: DRBD®/HA support and consulting    http://www.linbit.com

DRBD® and LINBIT® are registered trademarks
of LINBIT Information Technologies GmbH
__
please don't Cc me, but send to list   --   I'm subscribed
