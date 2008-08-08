Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 70ACC2DDC12B
	for <drbd-dev@lists.linbit.com>; Fri,  8 Aug 2008 11:15:53 +0200 (CEST)
Date: Fri, 8 Aug 2008 11:15:53 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] The drbd resync process
Message-ID: <20080808091553.GB9742@soda.linbit>
References: <20080806100003.E28A12E3A53E@mail.linbit.com>
	<1218183403.3749.16.camel@niko.infocore.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1218183403.3749.16.camel@niko.infocore.cn>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Aug 08, 2008 at 04:16:43PM +0800, niko wrote:
> Consider node A crashed as primary and rejoining the cluster,B as the
> surviving node.
> What's the resync process ?
> 
> I can't find how the drbd_start_resync () function call the
> w_make_resync_request() to send RSDataRequest message to the SyncSource

it is "queued for the worker",
and requeued via a timer.

> When the peer node recovers or the connection is re-established, DRBD
> combines the bitmap information from both nodes to determine the total
> data set that it must re-synchronize.
> 
> Why DRBD needs to combines the bitmap information from both nodes since
> one is Primary,the other is Secondary?

both nodes may have changed the data independently.

> Thanks ,I'm just a learner.

now, I'd like to learn a bit more about you, still. so let me repeat my
question,

What is your motivation for this?
How can you help us?
How can you help us help you?


-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
