Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (Ad56a.a.pppool.de [213.6.213.106])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 185F414332
	for <drbd-dev@lists.linbit.com>; Tue, 21 Sep 2004 19:15:52 +0200 (CEST)
Date: Tue, 21 Sep 2004 19:15:46 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] docs reworking (was: Does DRDB do 'intelligent'
	mirroring?)
Message-ID: <PxBJbrdXd5eQ5abIw6F/r6M=lge@web.de>
References: <97851D36-08AC-11D9-9842-000A95E071BA@multimap.com>
	<414B12E9.3040408@unix.sh> <cig3mt$71s$1@sea.gmane.org>
	<200409211627.19567.philipp.reisner@linbit.com>
	<41505858.5080909@wollmersdorfer.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41505858.5080909@wollmersdorfer.at>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-09-21 18:35:36 +0200
\ Helmut Wollmersdorfer:
> Philipp Reisner wrote:
> >On Saturday 18 September 2004 03:40, Helmut Wollmersdorfer wrote:
> 
> >>From the middle of next week I should have time to do some dozens of
> >>hours docu work.
> 
> >Are you going to work on the docs only ?
> >Could you imagine to go over the web-pages ?
> 
> Yeah, everything should be done.
> 
> It's just a matter of time;-)
> 
> Personally I do not like CMS' or wikis, but I can live with it. Content 
> should be brought to an actual state, but I will not touch the structure.

the moinmoin wiki is nice, it is all plain files. one can take it
offline (or readonly), and grep/sed/perl/mv/cp the content, if one knows
...

> Priorities:
> - man pages (very high)

and you already did a great job on those so far.

> - HOWTO (high)
> - web (medium - high)
> - docbook.sgml -> docbook.xml (low)
> - german translation (low)

agreed to your priorities.

> Problems to discuss:
> 1) The pt and jp versions are outdated.
>    We should either remove them from 0.7.x or include a "NOTE: This
>    translation is outdated. Feel free to improve it."

I already removed them from drbd/trunk, which is 0.8-pre1.

> 2) Can I take some useful parts of text from Linbit, LGE and LMB?
>    Appropriate references would be included.

sure. well, I did not do much beyond the DRBD pages in the HA wiki
and the drbd article in the linux mag. you know the urls:
http://wiki.trick.ca/linux-ha/DRBD
http://www.drbd.org/publications.html

or was it something else that you had in mind?

	lge


