Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (Ad530.a.pppool.de [213.6.213.48])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 79C60142FB
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jul 2004 20:51:37 +0200 (CEST)
Date: Wed, 28 Jul 2004 20:45:40 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Message-ID: <JAd8M75s2Kw3KlQnchTCfao=lge@web.de>
References: <20040728080645.GB7918@tmathiasen> <200407281655.18277.philipp.reisner@linbit.com> <20040728153314.GW26564@marowsky-bree.de> <200407281956.10022.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407281956.10022.philipp.reisner@linbit.com>
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

/ 2004-07-28 19:56:09 +0200
\ Philipp Reisner:
> > You need to manually fix the application configuration files up, custom
> > scripts etc - for example, you forgot heartbeat's haresources, and if
> > someone is running raw device access to drbd w/ a database...
> >
> > This is _not_ a change we can push out. The major number _might_ be
> > changed, but the device path absolutely has to stay stable.
> 
> Maybe 
> for ((i=0;i<16;i++)); do mknod /dev/nb$i b 147 $i; done

> Currently you can not use NBD on a system on which DRBD is active.
> So creating the /dev/nbX with DRBD's major number in SuSE's upgrade
> path does not make anyhing worse...
> 
> But it preserves the "application configuration files & custom scripts"
> compatibility...

I'd rather go for symlinks, if it really needs to be that way ...

> PS: Thx for pointing out that heartbeat's haresources file is missing
>     from the upgrade 

it is for the Filesystem resource, right?
"mount: no such device" ... outch! :-/

anyways:
do we have consense to keep the major_nr module parameter?
maybe only allow two major numbers, NBD_MAJOR and LANANA_DRBD_MAJOR.
then the parameter is not "major_nr=%d", but rather "use_nbd_major" ...
and it should clearly be marked as deprecated in the description,
and be a little bit noisy on device registration :-)

	Lars
