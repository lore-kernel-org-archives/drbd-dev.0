Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-053-158.arcor-ip.net [145.254.53.158])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id F06A9142F9
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jul 2004 17:46:36 +0200 (CEST)
Date: Wed, 28 Jul 2004 17:46:42 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Message-ID: <x4NCadkbozyeuCSwjPJQBoQ=lge@web.de>
References: <20040728080645.GB7918@tmathiasen> <200407281408.00730.philipp.reisner@linbit.com> <20040728141220.GV26564@marowsky-bree.de> <200407281655.18277.philipp.reisner@linbit.com> <20040728153314.GW26564@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040728153314.GW26564@marowsky-bree.de>
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

/ 2004-07-28 17:33:14 +0200
\ Lars Marowsky-Bree:
> On 2004-07-28T16:55:18,
>    Philipp Reisner <philipp.reisner@linbit.com> said:
> 
> > Yes I want to do this. Rolling upgrades are possible. 
> > I do not think that anybody actually cares about the major number 
> > or the name of the device node. 
> 
> Thanks for the 0.6 -> 0.7 upgrade path.

> You need to manually fix the application configuration files up, custom
> scripts etc - for example, you forgot heartbeat's haresources, and if
> someone is running raw device access to drbd w/ a database...
> 
> This is _not_ a change we can push out. The major number _might_ be
> changed, but the device path absolutely has to stay stable.

Um. now, nobody actually has drbd 0.7.0 in production yet.
Or am I wrong?

and, you always can do rm /dev/nb0 ; ln -s /dev/{drbd0,nb0}
 :-) 


> You'll have to allow a transition period where we accept and work with
> the old configuration and setups, allow and encourage the sane new way
> for new deployments, and eventually "force" the migration in 0.8.x.
> 
> 0.7.0 -> 0.7.1 must work by just dropping it in place of the old
> version, or I'm going to have to patch that.

0.7.0 had a configurable major_nr as module parameter.
I could put that back in, (I only commented it anyways),
but now default it to be LANANA_DRBD_MAJOR now, instead of NBD_MAJOR.
when it is NBD_MAJOR, devfs name will be nbd.
if someone (suse) insists,
she can put some options major_nr=43 into modules.conf ...

konsensfähig?

	Lars
