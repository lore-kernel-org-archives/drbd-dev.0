Return-Path: <philipp.reisner@linbit.com>
Received: from amd.localdomain (chello080110205223.112.11.tuwien.teleweb.at [80.110.205.223])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 49C91142F8
	for <drbd-dev@lists.linbit.com>; Wed, 18 Aug 2004 21:31:36 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Date: Wed, 18 Aug 2004 21:31:35 +0200
References: <20040728080645.GB7918@tmathiasen> <uaTOpLQubcD5XbUapszkYGk=lge@web.de> <20040818184247.GP9601@marowsky-bree.de>
In-Reply-To: <20040818184247.GP9601@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408182131.36198.philipp.reisner@linbit.com>
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

Am Mittwoch, 18. August 2004 20:42 schrieb Lars Marowsky-Bree:
> On 2004-07-30T14:14:01,
>
>    Lars Ellenberg <Lars.Ellenberg@linbit.com> said:
> > > You could even use the supplied init script and put
> > > ADD_MOD_PARAM="major_nr=43" into /etc/default/drbd
> >
> > patch will follow soon which will replace that with
> > "use_nbd_major"
>
> BTW, in real life our maintenance crew has rejected this. I will have to
> patch the module to default to the old major by default. Upgrading the
> kernel must work w/o updating the user-space at the same time, I'm
> afraid.
>
> We are in maintenance only mode already, so it's a matter of policy; we
> only do bugfixes and security changes right now.
>
> I can probably re-align with the first service-pack in March or so,
> where we can "force" the customers to swallow a bigger chunk of packages
> as a single bite.
>
> Changing such fundamental behaviour in a stable series really is not
> very good. You are breaking the kernel/user-space boundary. Nobody cares
> what you do _in_ the kernel, or _within_ user-space, but this really
> ain't good. Common policy for stable series (also adhered to by most
> other projects) is _never_ to change the default.
>
> I'll need to check whether that works, or whether the ioctls etc also
> break, which would be very bad. That's just not a thing to do within a
> stable series, but maybe we have different concepts of "stable" ;)
>

Ok, go on with whatever you think (or your policies instruct you to) is
the right way. The patch is rather trivial.

Index: drbd/drbd_main.c
===================================================================
--- drbd/drbd_main.c    (revision 1491)
+++ drbd/drbd_main.c    (working copy)
@@ -128,7 +128,7 @@
 #endif

 // module parameter, defined
-int use_nbd_major = 0;
+int use_nbd_major = 1;
 int major_nr = LANANA_DRBD_MAJOR;
 #ifdef MODULE
 int minor_count = 2;

Regarding IOCTL interface. It changed from 0.7 to 0.7.1...

-Philipp
