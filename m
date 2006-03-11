Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 02580163F3
	for <drbd-dev@lists.linbit.com>; Sat, 11 Mar 2006 17:35:03 +0100 (CET)
Date: Sat, 11 Mar 2006 17:35:05 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] freeze under postmark io bench
Message-ID: <20060311163505.GC3816@soda.linbit>
References: <6ed4c8790602101017l48d1b24s9fd684c82998e34f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed4c8790602101017l48d1b24s9fd684c82998e34f@mail.gmail.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-02-10 19:17:17 +0100
\ Laurent Denel:


Sorry for answering so late, and for letting this post lingering on hold
for over a month now. Seemingly 'someone' [guess who that might have
been *gee*] did not take his duty being moderator for drbd-dev too
seriously...


> I'm currently experiencing freezes with drbd each time I run PostMark,
> an io benchmark from NetApp. It was working all right on a 2.6.12
> kernel and version 0.7.11 but I'm currently switching to 2.6.15 with
> version 0.7.15.
> 
> Freezes occur on the primary node while creating thousands of files.
> Secondary node is not impacted.
> 
> I've tried latest svn commit (2064) and kernel 2.6.15.4. Same problem.
> My kernel is configured with high memory support (64GB), PREEMPT, ...
> The filesystem drbd is on is xfs. Hardware is a pair of DL380 from HP.
> Network for drbd is a private Gb link on bcm5700 interfaces.
> 
> You can find the postmark benchmark here :
> http://www.eecs.harvard.edu/~syrah/filesystems/code/postmark-1_13.c
> (The one we really use is 1_5 but I cannot find it anymore on the
> Netapp website, I can post it if needed)

please try with latest svn
 svn co http://svn.drbd.org/drbd/branches/drbd-0.7

I just checked in a one line change where we used GFP_KERNEL where we
should have used GFP_NOIO...

cheers,

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
