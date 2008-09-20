Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (chello080108047253.34.11.vie.surfer.at
	[80.108.47.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 461A12E07835
	for <drbd-dev@lists.linbit.com>; Sat, 20 Sep 2008 15:48:28 +0200 (CEST)
Date: Sat, 20 Sep 2008 15:48:27 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] New Features
Message-ID: <20080920134827.GD16149@racke>
References: <48D3378E.3020201@gmail.com> <20080919155343.GD9779@soda.linbit>
	<91a37e890809190919g5a746367g54e76d36e1a825f6@mail.gmail.com>
	<20080919221339.GB15916@soda.linbit>
	<48D42783.1050403@gmail.com> <20080920131821.GB16149@racke>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20080920131821.GB16149@racke>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Sep 20, 2008 at 03:18:21PM +0200, Lars Ellenberg wrote:

"Write-Back" cache:

some things to think of when introducing a write back cache,
 * need to do some cache coherency protocol
 * need to track which block is where, so we can read the correct
   version in case it has not yet been committed to final location
 * if using a ram buffer as log disk, we need to track the latest
   position for overwrites.
 * if we have stages, i.e. ram buffer first, then log disk, then real
   storage, we are the most flexible.
   if peers are sufficiently close, we can send_page from the ram
   buffer (and calculate checksums there, for data integrity).
   if we use it as ring buffer, we'd not have to worry about
   inconsistencies resulting from changes to in-flight buffers,
   as they are all private.
 * if we can use some efficient combination of digital tree,
   btree and hash table to track which block is where,
   we might be able to track a large, staged log device
   as a sort of log-structured block device, making snapshots after the
   fact for data generations still covered by the log very easy.
 * we need a good refcount scheme on the ram buffers.

of course we can start out "simple", and just provide a static cache, no
ring buffer or anything.

this should probably be implemented as a generic device-mapper target,
which also makes testing much easier.

which would make it possible to even add it to the current drbd
by just stacking it in front of the "lower-level device".

for the "write-back" to "write-through" change,
we only need a minimal change in the current drbd module, which we can
enable based on the type of the device directly below us.
we could detect whether its a device-mapper target,
if so, which one, and access its special methods if any.

this still sound a little quirky, so I'd suggest to introduce a special
BIO_RW_WRITE_THROUGH (to be defined) bit for the bi_flags.

when not using it, that is write back.
when using it, it would trigger a flush of any pending requests,
and a direct remapping to the lower level device.

BIO_RW_BARRIER requests would still need to trigger a flush as well,
and to go straight through.

in the new architecture, where "drbd" probably becomes just a special
implementation and collection of device-mapper targets, communicating
with other device mapper targets becomes more easy (I hope).

does that make sense?

-- 
: Lars Ellenberg                
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
__
please don't Cc me, but send to list   --   I'm subscribed
