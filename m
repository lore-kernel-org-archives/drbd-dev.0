Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (1Cust191.tnt1.ber2.deu.da.uu.net [149.225.52.191])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id D823B1433F
	for <drbd-dev@lists.linbit.com>; Wed, 22 Sep 2004 16:55:47 +0200 (CEST)
Date: Wed, 22 Sep 2004 16:53:57 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] GFS support in DRBD-0.8
Message-ID: <YkV400xn7A/9fpEKf0bWsA0=lge@web.de>
References: <200409211616.59305.philipp.reisner@linbit.com>
	<3+B6NrvPixc+6shooEioqTc=lge@web.de>
	<200409221518.45324.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409221518.45324.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-09-22 15:18:45 +0200
\ Philipp Reisner:
> > I'd like to keep Primary, but introduce "active" as well, so we can have
> > active Secondaries. a Primary is by definition always active.
> >
> 
> So it would be Primary/Active ?? What is the difference between
> an Active and an Primary node ?

Primary and Active => is the writable Coordinator
just Active is a writable Secondary.

its just a suggestion anyways.


I'll think about your other questions...

	lge
