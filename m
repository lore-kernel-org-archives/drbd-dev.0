Return-Path: <lmb@suse.de>
Date: Wed, 28 Jul 2004 17:33:14 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Message-ID: <20040728153314.GW26564@marowsky-bree.de>
References: <20040728080645.GB7918@tmathiasen> <200407281408.00730.philipp.reisner@linbit.com> <20040728141220.GV26564@marowsky-bree.de> <200407281655.18277.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407281655.18277.philipp.reisner@linbit.com>
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

On 2004-07-28T16:55:18,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> Yes I want to do this. Rolling upgrades are possible. 
> I do not think that anybody actually cares about the major number 
> or the name of the device node. 

Thanks for the 0.6 -> 0.7 upgrade path.

> DRBD upgrade instructions from 0.7.0 to 0.7.1
> 
> With drbd-0.7.1 we have our own major number, and our own device
> files. (=No longer misuse /dev/nbX)
> 
> * Start on the node, on which all devices are secondary.
> * /etc/init.d/drbd stop
> * Install drbd-0.7.1
> * Run these commands as root:
> 
> sed -e "s/\/dev\/nb/\/dev\/drbd/" < /etc/drbd.conf > /etc/drbd.conf_new
> mv /etc/drbd.conf /etc/drbd.conf_old ; mv /etc/drbd.conf_new /etc/drbd.conf
> sed -e "s/\/dev\/nb/\/dev\/drbd/" < /etc/fstab > /etc/fstab_new
> mv /etc/fstab /etc/fstab_old ; mv /etc/fstab_new /etc/fstab
> for ((i=0;i<16;i++)); do mknod /dev/drbd$i b 147 $i; done
> 
> * /etc/init.d/drbd start
> * migrate all services to the just upgraded node and 
>   upgrade the other node.

You need to manually fix the application configuration files up, custom
scripts etc - for example, you forgot heartbeat's haresources, and if
someone is running raw device access to drbd w/ a database...

This is _not_ a change we can push out. The major number _might_ be
changed, but the device path absolutely has to stay stable.

You'll have to allow a transition period where we accept and work with
the old configuration and setups, allow and encourage the sane new way
for new deployments, and eventually "force" the migration in 0.8.x.

0.7.0 -> 0.7.1 must work by just dropping it in place of the old
version, or I'm going to have to patch that.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

