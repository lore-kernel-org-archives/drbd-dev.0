Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (1Cust64.tnt12.ber2.deu.da.uu.net [149.225.238.64])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 571B014311
	for <drbd-dev@lists.linbit.com>; Wed, 25 Aug 2004 15:12:17 +0200 (CEST)
Date: Wed, 25 Aug 2004 14:54:02 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Summary (=Idems for 0.8 Roadmap)
Message-ID: <FcbaFJHhBNyUmurvwLCdHbA=lge@web.de>
References: <200408251207.20479.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408251207.20479.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-08-25 12:07:20 +0200
\ Philipp Reisner:
> Hi,
> 
> New configuration options:
> 
>   primary-after-sb  (SB = splitbrain) = 
>    older	The node that was primary before split brain (current behaviour)
>    younger	The node that became primary during split brain 
>    most-mod	The node that modified more of it's data during the SB.
>    wait		None, wait for operator's decission. 

would this block current activity on the Primary/both nodes?
what if _both_ are still Primary?

>    node-"nodename"	The node prefered by the user.[suggested by Helmut]

>   wrong-gencnt (secondary-with-higher-genctn) =
>    refuse	(Current behaviour)
>          	I think the secondary should drop its net-conf.

currently the Primary goes StandAlone.
you suggest the Secondary goes StandAlone, too,
                       or goes StandAlone instead?

>    update-data	Make the joining node sync-target.

so, in a peer to peer scenario, who joins whom?
this of course means make the Secondary with the higher gencounts
sync-target in the presence of a running Primary.

this is a delicate decision... do we really want this to be automated?
maybe that could become at least an undocumented feature?

additional questions:
who would adopt the gencounts of the other?
do we want to preserve strict non-decreasing monotonicity?



>   secondary-after-sb = 
>    keep-data		The secondray drops its net-config.
>    update-data	Make the looser sync-target (Current behaviour)

um. I don't see this at all?
what scenario is this?

	lge
