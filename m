Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 86B6C2E03722
	for <drbd-dev@lists.linbit.com>; Wed,  7 Mar 2007 01:04:01 +0100 (CET)
Date: Wed, 7 Mar 2007 01:04:01 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Suggestion: secondary socket address
Message-ID: <20070307000401.GF1055@barkeeper1.linbit>
References: <eshq85$cm0$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eshq85$cm0$1@sea.gmane.org>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2007-03-05 21:14:48 +0200
\ daliv@apollo.lv:
> suggestion in result of persistent development problems sky2 driver for "Marvell Technology" network cards:
> add possibility to set backup direction of socket for each drbd resource
> example :
> 
> on host01.domain {
>     device    /dev/drbd0;
>     disk      /dev/sdb1;
>     address   10.0.2.2:7788;
>     address-backup   10.0.1.200:7788;
>     meta-disk internal;
> }
>
> or may be with backup leveling
>     address-backup   10.0.1.200:7788 level 1; // if primary failed - then here
>     address-backup   10.0.3.200:7788 level 2; // if primary and secondary faled - then try to reconnect thru 
> this connection
> 
> eth0 : 10.0.1.0/24 - main corporate LAN
> eth1 : 10.0.2.0/24 - only interserver network - not for real client
> eth2 : 10.0.3.0/24 - additional lan/wan connections

I don't see us implementing a fallback
solution like this in module code.

you'd have to monitor and trigger this from userland.

we might add a drbdadm subcommand like
 "drbdadm reconnect --use-backup-link=3"
and we might add an optional configuration directive,
so the config would be all in one place.
but you can do something like that right
now already using drbdsetup directly.

btw, if we do something like that, be sure:
we won't do this because some nic driver is not yet stable.

but because it might have general usage to achieve a higher level of
redunancy in the network connection, beyond what is available with the
linux bonding driver.

> listeners for level 1,2 may be not initialised on startup, but only in error state of primary listener.
> when primary listener will back (periodical recheck) - drbd communication must return automaticaly to that.
> 
> + additionally notifies about channel changes to admin email.

since this would be triggered from monitoring (likely: scripts),
you may then trigger any other action you like as well.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
