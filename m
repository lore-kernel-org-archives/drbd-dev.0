Return-Path: <philipp.reisner@linbit.com>
Received: from amd.localdomain (chello080110205223.112.11.tuwien.teleweb.at [80.110.205.223])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 5C34D142FC
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jul 2004 19:56:10 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Date: Wed, 28 Jul 2004 19:56:09 +0200
References: <20040728080645.GB7918@tmathiasen> <200407281655.18277.philipp.reisner@linbit.com> <20040728153314.GW26564@marowsky-bree.de>
In-Reply-To: <20040728153314.GW26564@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407281956.10022.philipp.reisner@linbit.com>
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

Am Mittwoch, 28. Juli 2004 17:33 schrieb Lars Marowsky-Bree:
> On 2004-07-28T16:55:18,
>
>    Philipp Reisner <philipp.reisner@linbit.com> said:
> > Yes I want to do this. Rolling upgrades are possible.
> > I do not think that anybody actually cares about the major number
> > or the name of the device node.
>
> Thanks for the 0.6 -> 0.7 upgrade path.
>
> > DRBD upgrade instructions from 0.7.0 to 0.7.1
> >
> > With drbd-0.7.1 we have our own major number, and our own device
> > files. (=No longer misuse /dev/nbX)
> >
> > * Start on the node, on which all devices are secondary.
> > * /etc/init.d/drbd stop
> > * Install drbd-0.7.1
> > * Run these commands as root:
> >
> > sed -e "s/\/dev\/nb/\/dev\/drbd/" < /etc/drbd.conf > /etc/drbd.conf_new
> > mv /etc/drbd.conf /etc/drbd.conf_old ; mv /etc/drbd.conf_new
> > /etc/drbd.conf sed -e "s/\/dev\/nb/\/dev\/drbd/" < /etc/fstab >
> > /etc/fstab_new
> > mv /etc/fstab /etc/fstab_old ; mv /etc/fstab_new /etc/fstab
> > for ((i=0;i<16;i++)); do mknod /dev/drbd$i b 147 $i; done
> >
> > * /etc/init.d/drbd start
> > * migrate all services to the just upgraded node and
> >   upgrade the other node.
>
> You need to manually fix the application configuration files up, custom
> scripts etc - for example, you forgot heartbeat's haresources, and if
> someone is running raw device access to drbd w/ a database...
>
> This is _not_ a change we can push out. The major number _might_ be
> changed, but the device path absolutely has to stay stable.

Maybe 
for ((i=0;i<16;i++)); do mknod /dev/nb$i b 147 $i; done

Currently you can not use NBD on a system on which DRBD is active.
So creating the /dev/nbX with DRBD's major number in SuSE's upgrade
path does not make anyhing worse...

But it preserves the "application configuration files & custom scripts"
compatibility...

PS: Thx for pointing out that heartbeat's haresources file is missing
    from the upgrade 

-Philipp
