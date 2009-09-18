Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9E3AA10623C3
	for <drbd-dev@lists.linbit.com>; Fri, 18 Sep 2009 10:24:03 +0200 (CEST)
Resent-Message-ID: <20090918082403.GD8039@barkeeper1-xen.linbit>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8B08410623A9
	for <drbd-dev@lists.linbit.com>; Fri, 18 Sep 2009 05:31:09 +0200 (CEST)
From: Neil Brown <neilb@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Date: Fri, 18 Sep 2009 13:32:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <19122.65335.126937.476968@notabene.brown>
In-Reply-To: message from Christoph Hellwig on Thursday September 17
References: <200909151645.14256.philipp.reisner@linbit.com>
	<20090915231931.GB7636@infradead.org>
	<20090917081251.GC8045@barkeeper1-xen.linbit>
	<1253203365.7845.14.camel@mulgrave.site>
	<20090917161108.GA3361@infradead.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Sam Ravnborg <sam@ravnborg.org>,
	Nikanth Karthikesan <knikanth@suse.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Bart Van Assche <bart.vanassche@gmail.com>,
	James Bottomley <James.Bottomley@suse.de>,
	Lars Marowsky-Bree <lmb@suse.de>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Jens Axboe <jens.axboe@oracle.com>, Dave Jones <davej@redhat.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thursday September 17, hch@infradead.org wrote:
> On Thu, Sep 17, 2009 at 10:02:45AM -0600, James Bottomley wrote:
> > So I think Christoph's NAK is rooted in the fact that we have a
> > proliferation of in-kernel RAID implementations and he's trying to
> > reunify them all again.
> > 
> > As part of the review, reusing the kernel RAID (and actually logging)
> > logic did come up and you added it to your todo list.  Perhaps expanding
> > on the status of that would help, since what's being looked for is that
> > you're not adding more work to the RAID reunification effort and that
> > you do have a plan and preferably a time frame for coming into sync with
> > it.
> 
> Yes.  RDBD has spend tons of time out of tree, and if they want to put
> it in now I think requiring them to do their homework is a good idea.

What homework?

If there was a sensible unifying framework in the kernel that they
could plug in to, then requiring them do to that might make sense.  But
there isn't.  You/I/We haven't created a solution (i.e. there is no
equivalent of the VFS for virtual block devices) and saying that
because we haven't they cannot merge DRBD hardly seems fair.

Indeed, merging DRBD must be seen as a *good* thing as we then have
more examples of differing requirements against which a proposed
solution can be measured and tested.

I thought the current attitude was "merge then fix".  That is what the
drivers/staging tree seems to be all about.  Maybe you could argue
that DRBD should go in to 'staging' first (though I don't think that
is appropriate or require myself), but keeping it out just seems
wrong.

> 
> Note that the in-kernel raid implementation is just a rather small part
> of this, what's much more important is the user interface.  A big part
> of raid unification is that we can support on proper interface to deal
> with raid vs volume management, and DRBD adds another totally
> incompatible one to that.  We'd be much better off adding the drbd in
> the write protocol (at least the most recent version) to DM instead of
> adding another big chunk of framework.

I agree that the interface is very important.  But the 'dm' interface
and the 'md' interface (both imperfect) are not going away any time
soon and there is no reason to expect that the DRBD interface has to
be sacrificed simply because they didn't manage to get it in-kernel
before now.

Let me try to paint a partial picture for you to show how my thoughts
have been going.  I'm looking at this from the perspective of the
driver model, particularly exposed through sysfs.

A 'block device' like 'sda' has a parent in sysfs, which represents
(e.g.) the SCSI device which provides the storage that is exposed
through 'sda'.  e.g.
  .../target0:0:0/0:0:0:0/block/sda
      ^target     ^lun   ^padding ^block-device
Block devices 'md0' or 'mapper/whatever' don't have a real parent and
so live in /sys/devices/virtual/block which is really just a
place-holder because there is no real parent.  There should be.

So I would propose a 'bus' device which contains virtual block devices
- 'vbd's.  There is probably just one instance of this bus.

A 'vbd' is somewhat like a SCSI target (or maybe 'lun').
The preferred way to create a vbd is to write a device name to a
'scan' file in the 'bus' device. (similar to ....scsi_host/host0/scan).
Legacy interfaces (md,dm,drbd,loop,...) would be able to do the same
thing using an internal interface.

This would make the named vbd appear in the bus and it would have some
attribute files which could be filled in to describe the device.
Writing one of these attributes would activate the device and make a
'block device' come into existence.  The block device would be a child
of the vbd, just like sda is a child of a SCSI target.

When a vbd is being managed by a legacy interface (md, dm, drbd...) it
would probably has a second child device which represents that
interface.

So to be a bit concrete:

  /sys/devices/virtual/vdbus   would be the bus
  /sys/devices/virtual/vdbus/md0  would be the vbd for an md device
  /sys/devices/virtual/vdbus/md0/block/md0 would be the block device
  /sys/devices/virtual/vdbus/md0/md/md0 would be an 'md' device
                           representing the (legacy) md interface.

For compatibility (maybe only temporarily),
  /sys/devices/virtual/vdbus/md0/block/md0/md -> /sys/devices/virtual/vdbus/md0/md/md0
 
so the current /sys/block/mdX/md/ directory still works.
that directory would largely have symlink up to the parent,
though possible with different names.


The next bit is the messy bit that I haven't come up with an adequate
solution yet:
  What is the relationship between the component devices and the vdb
  device?

This is clearly a dependency, and sysfs has a clear model for
representing dependencies:  The child is dependent on the parent.
However with vdb, the child is dependent on multiple parents and those
dependencies change.
As reported in http://lwn.net/Articles/347573/, other things have
multiple dependencies too, so we should probably try to make sure a
solution is created that fits both needs.
Personally, I would much rather all the dependencies were links, and
the directory hierarchy was
   /sys/subsystem/$SUBSYSTEM/devices/$DEVICE
(where 'subsystem' subsumes both 'class' and 'bus').  But it is
probably 7 years too late for that.

The other thing I would really like to be able to manage is for a
'class/block' device to be able to be moved from one parent to
another.  This would make it possible to change a block device to a
RAID1 containing the same data while it was mounted.   It isn't too
hard to implement that internally, but making it fit with the sysfs
model is hard.  It requires changeable dependencies again.


So yeah, let's have a discussion and find a good universal interface
which can subsume all the others and provide even more functionality,
but I don't think we can justify using the fact that we haven't
devised such an interface yet as reason to exclude DRBD.

NeilBrown
