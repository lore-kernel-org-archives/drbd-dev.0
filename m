Return-Path: <Lars.Ellenberg@linbit.com>
Date: Fri, 30 Jul 2004 14:14:01 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Message-ID: <uaTOpLQubcD5XbUapszkYGk=lge@web.de>
References: <20040728080645.GB7918@tmathiasen> <20040729223253.GD3794@marowsky-bree.de> <200407301156.18099.philipp.reisner@linbit.com> <200407301332.20680.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407301332.20680.philipp.reisner@linbit.com>
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

/ 2004-07-30 13:32:20 +0200
\ Philipp Reisner:
> On Friday 30 July 2004 11:56, Philipp Reisner wrote:
> > On Friday 30 July 2004 00:32, Lars Marowsky-Bree wrote:
> > > On 2004-07-28T19:56:09,
> > >
> > >    Philipp Reisner <philipp.reisner@linbit.com> said:
> > > > > This is _not_ a change we can push out. The major number _might_ be
> > > > > changed, but the device path absolutely has to stay stable.
> > > >
> > > > Maybe
> > > > for ((i=0;i<16;i++)); do mknod /dev/nb$i b 147 $i; done
> > >
> > > No. Because the user might have the RPM installed (thus the post-install
> > > would get triggered on update), but may in fact be using nbd.
> > >
> > > We'll have to make the drbd we ship default to the old major/minor and
> > > also keep the examples consistent with that.
> > >
> > > However, we can advise them use the different major in the future, but
> > > for a GA'ed product, we cannot break what is essentially the ABI to
> > > userspace.
> >
> > So then, we will reenable the major_nr module parameter.
> > Then SuSE only needs to patch the init script to pass the module
> > parameter..
> >
> 
> You could even use the supplied init script and put
> ADD_MOD_PARAM="major_nr=43" into /etc/default/drbd

patch will follow soon which will replace that with
"use_nbd_major"

ok?

	lge
