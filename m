Return-Path: <lmb@suse.de>
Date: Wed, 18 Aug 2004 20:42:47 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Message-ID: <20040818184247.GP9601@marowsky-bree.de>
References: <20040728080645.GB7918@tmathiasen> <20040729223253.GD3794@marowsky-bree.de> <200407301156.18099.philipp.reisner@linbit.com> <200407301332.20680.philipp.reisner@linbit.com> <uaTOpLQubcD5XbUapszkYGk=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uaTOpLQubcD5XbUapszkYGk=lge@web.de>
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

On 2004-07-30T14:14:01,
   Lars Ellenberg <Lars.Ellenberg@linbit.com> said:

> > You could even use the supplied init script and put
> > ADD_MOD_PARAM="major_nr=43" into /etc/default/drbd
> 
> patch will follow soon which will replace that with
> "use_nbd_major"

BTW, in real life our maintenance crew has rejected this. I will have to
patch the module to default to the old major by default. Upgrading the
kernel must work w/o updating the user-space at the same time, I'm
afraid.

We are in maintenance only mode already, so it's a matter of policy; we
only do bugfixes and security changes right now.

I can probably re-align with the first service-pack in March or so,
where we can "force" the customers to swallow a bigger chunk of packages
as a single bite.

Changing such fundamental behaviour in a stable series really is not
very good. You are breaking the kernel/user-space boundary. Nobody cares
what you do _in_ the kernel, or _within_ user-space, but this really
ain't good. Common policy for stable series (also adhered to by most
other projects) is _never_ to change the default.

I'll need to check whether that works, or whether the ioctls etc also
break, which would be very bad. That's just not a thing to do within a
stable series, but maybe we have different concepts of "stable" ;)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \        This space          /
SUSE Labs, Research and Development |       intentionally        |
SUSE LINUX AG - A Novell company    \        left blank          /
