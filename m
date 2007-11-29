Return-Path: <lars.ellenberg@linbit.com>
Date: Thu, 29 Nov 2007 12:35:50 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>
Subject: Re: [Drbd-dev] [PATCH] Supporting on-disk cache in DRBD, part 2
Message-ID: <20071129113550.GC5684@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B3767107283694@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107283694@EXNA.corp.stratus.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Nov 28, 2007 at 10:14:21PM -0500, Graham, Simon wrote:
> Attached is a proposed patch (against 8.0.6) for the second part of the work to
> support on-disk caches in DRBD – I took Phil’s excellent advice and used the
> existing transaction log – the change was simply to maintain this for Protocol
> C as well as A and B, everything else was already in place so that whenever we
> lose contact with the secondary, the existing TL log is added to the bitmap
> (covering everything sent since the last time a barrier was executed on the
> secondary).
> 
>  
> 
> I was a tad concerned about the perf impact of this, so I ran some simple
> non-scientific benchmarks to see – what I actually did was run 9 copies of
> bonnie (doing synchronous writes) against 9 different DRBD devices that were
> spread between two physical disks per system and averaged out the results for
> all the bonnie runs to get an idea of what one copy can expect to achieve
> (possibly not the best calculation, but it was the easiest to do). The results
> were actually encouraging – 98-100% of the throughput with no change in CPU
> usage (although I’m not entirely convinced bonnie is really a good test).
> 

thanks, looks basically like I'd have done it.
this is also the reason we I consolidated all those request state
handling into the one central function.

and this part is probably harmless and potentially beneficial to do
anyways, regardless of whether barriers are supported or not.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
