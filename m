Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-058-150.arcor-ip.net [145.254.58.150])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id D5F0F142F8
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jul 2004 14:20:00 +0200 (CEST)
Date: Wed, 28 Jul 2004 14:17:19 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Message-ID: </bbTlzk5MC/V8tV+74lLfZI=lge@web.de>
References: <20040728080645.GB7918@tmathiasen> <200407281210.14894.philipp.reisner@linbit.com> <N0M0aajdbaoiib5RP3b+bp4=lge@web.de> <200407281408.00730.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407281408.00730.philipp.reisner@linbit.com>
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

/ 2004-07-28 14:08:00 +0200
\ Philipp Reisner:
> On Wednesday 28 July 2004 12:58, Lars Ellenberg wrote:
> > / 2004-07-28 12:10:14 +0200
> >
> > \ Philipp Reisner:
> > > On Wednesday 28 July 2004 10:06, Torben Mathiasen wrote:
> > > > Hi,
> > > >
> > > > Sorry for the delay. We are moving to a new lanana maintainer (me).
> > > >
> > > > Regarding your Major number. You will receive block major 147. How do
> > > > you want to minors named? /dev/drbd0, /dev/drbd1, ok?
> > >
> > > /dev/drbd0, /dev/drbd1... are fine
> >
> > great.
> >
> > so, do we include that right away?
> > i.e. remove CONFIG_DRBD_MAJOR and module param major_nr again,
> > and make it fixed on 147 ?
> >
> > or just "default" to 147 for now?
> >
> 
> Yes I think so. The users should move to 147 with 0.7.1. 
> Do you like to do the removal of module param ?

done in a minute...

I'll commit my change in receive_data_tail, too...
or is there still something special with the value of that NUMBER >= 24?

	Lars

