Return-Path: <philipp.reisner@linbit.com>
Received: from amd.localdomain (chello080108092198.22.11.tuwien.teleweb.at
	[80.108.92.198])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 730F62E07893
	for <drbd-dev@lists.linbit.com>; Fri, 22 Jun 2007 20:41:14 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Running Protocol C with disk cache enabled
Date: Fri, 22 Jun 2007 20:41:34 +0200
References: <342BAC0A5467384983B586A6B0B3767105DEB765@EXNA.corp.stratus.com>
	<20070621132606.GB22863@ogo.aicooma.com>
In-Reply-To: <20070621132606.GB22863@ogo.aicooma.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706222041.34776.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

Lars and I discussed various implementation ideas about the issue 
today. I was just about to write them down. -- But then this though
came to my head:
 
 * The message would be: You no longer need good disk IO subsystems
   that tell the operating system the truth. Go out and use the
   cheapest RAID5 controllers with enormous on-controller memory,
   without battery unit...

   In case your secondary crash, DRBD will take care and replay
   the data, that was lost in your controller's RAM.

   But, how does this work on the primary ? Our activity-log 
   depends on an working disk subsystem. If you have an IO
   subsystem with write-back caches on the primary, we will not
   have a complete AL after the crash.

Does it make sense to solve an issue with broken hardware for
a DRBD node in secondary role, when we depend on working hardware
when the same node is in primary role ? -- I do not think so.

The bottom line:
There is lots of working hardware around. SCSI drives do not have
write-back caches (enabled). I guess SATA drives are okay as well,
but I do not know for sure. All serious raid5 controllers have 
battery units. People have to use those.

Just a comment to this:

> Well, I look at this slightly differently; use of the on-disk cache is
> really the only way to get decent (i.e. competitive) performance out of
> rotating rust, so what we have to do is find ways to allow this and
> still be correct.

A disk drive or a controller is really fine to take over thousands of
IO operations. -- And in fact Linux (2.6) (and DRBD) takes advantage
of this. I have seen an HP raid5 controller that accepted up 10000 
write requests at without blocking acceptance of further write requests.
-- But when the controller signals IO completion to the operating
system it is its task to ensure that the data either is on disk, or
save by other means ( battery backed up RAM ).

-Phil
