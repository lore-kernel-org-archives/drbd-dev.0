Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (dslb-088-075-197-174.pools.arcor-ip.net
	[88.75.197.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E1C4D2E05451
	for <drbd-dev@lists.linbit.com>; Sat, 16 Aug 2008 17:22:46 +0200 (CEST)
Date: Sat, 16 Aug 2008 17:22:46 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Huge latency issue with 8.2.6
Message-ID: <20080816152246.GA11083@racke>
References: <DA0E7D869C862D4095C265233CD1D41EC3105F@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DA0E7D869C862D4095C265233CD1D41EC3105F@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Aug 12, 2008 at 12:31:42PM -0400, Graham, Simon wrote:
> We've been benchmarking DRBD 8.2.6 and have found that some specific benchmarks (SQL) have absolutely terrible performance (a factor of 100 worse than the non DRBD case - 30 transactions per second versus 3000). These issues go away when we power off the secondary system, so it seems likely that it's somehow related to the network component. After some analysis of network traces, we found the following:
> 
> 1. When we are doing 30TPS, we're also doing about 30 1K writes/s - the conclusion here is
>    that one transaction needs 1 1K (2 block) write. This means we are seeing a write-to-write
>    time of around 33ms. To hit the 3000TPS mark, we'd need to be handling 3000 1K writes/s
>    which means a total write-to-write time of 333us
> 
> 2. When we do a tcpdump on the node running the benchmark, we see the following DRBD protocol 
>    consistently:
>    . Node issues barrier + 1K write + unplug remote in a single packet
>    . Receives barrier ack on meta-data connection 30-130us later
>    . Receives Data ack on meta-data connection ~250us later (after original rq issued)
>    . Receives TCP level ack on data connection 35-40ms later
>    . The next write is not sent on the wire for 35-40ms
> 
> 3. tcpdump on the other node shows the time between sending the barrierack and sending the
>    data ack is around 120us -- this is basically the disk write time.
> 
> Conclusion 1 -- network latency has nothing to do with the horrendous
> perf we are seeing. What's more, we are adding (250 - write_time)us to
> the overall time to write the block - it seems that the disk write
> time is of the order of 120us, so we are adding around 130us to the
> total write time -- this should lead us to a max possible TPS value
> around 4000...
> 
> Conclusion 2 -- the problem here has to do with the time is takes the secondary to send the TCP ACK.

in git on the way to 8.2.7, we added the TCP_NODELAY socket option,

we also added the possibility to set "sndbuf-size" to 0,
to leverage tcp stack autotuning of tcp-buffer size.

both have been released with 8.0.13, and will be released with 8.2.7.

it should help here as well.

-- 
: Lars Ellenberg                
: LINBIT HA-Solutions GmbH
: DRBD®/HA support and consulting    http://www.linbit.com

DRBD® and LINBIT® are registered trademarks
of LINBIT Information Technologies GmbH
__
please don't Cc me, but send to list   --   I'm subscribed
