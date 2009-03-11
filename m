Return-Path: <lars.ellenberg@linbit.com>
Date: Wed, 11 Mar 2009 20:44:16 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: "ILLES, Marton" <illes.marton@balabit.hu>
Message-ID: <20090311194416.GI8646@soda.linbit>
References: <1236792621.7981.25.camel@octane>
	<20090311183504.GH8646@soda.linbit>
	<1236797912.7981.30.camel@octane>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1236797912.7981.30.camel@octane>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] invalidate broken in 8.3.0 regression from 8.2.6
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Mar 11, 2009 at 07:58:32PM +0100, ILLES, Marton wrote:
> On Wed, 2009-03-11 at 19:35 +0100, Lars Ellenberg wrote:
> > On Wed, Mar 11, 2009 at 06:30:21PM +0100, ILLES, Marton wrote:
> > > Hi,
> > > 
> > > First of all thanks for drbd, it is such a nice piece of code, we love
> > > to use it.
> > > 
> > > In my current setup I use drbd 8.3.0 with linux 2.6.27 and some ubuntu
> > > patches (but it does not really matter), while I discovered that
> > > "drbdsetup /dev/drbd0 invalidate" does not do anything. No error code,
> > > nothing. In 8.2.6 it worked well, so some regression is here.
> > 
> > was drbd0 configured while you did "drbdsetup /dev/drbd0 invalidate"?
> > 
> > if not, that is a known bug, which we unfortunately not have fixed yet.
> > drbdadm should try drbdsetup, and if that fails because the device is
> > unconfigured, it should use drbdmeta to mark it as invalid in the meta
> > data itself.
> > 
> > unfortunately drbdsetup invalidate exits with 0 for unconfigured
> > devices.
> > 
> > if drbdsetup invalidate does nothing even while it is configured,
> > that would be new to me.
> > 
> 
> Hi,
> 
> It was configured in StandAlone Secondary/DUnknown state. I do not use
> drbdadm only drbdsetup. Though I still believe that the cause was the
> missed patch.

ok.

drbdadm invalidate
 - works as intended when connected
	(also for you?)
 - is broken when standalone in drbd 8.3
	(regression as per this report)
 - is broken when unconfigured (possibly for a long time already).
	(I found out a while back)

we'll fix that.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
