Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: Update to handle I/O failures during resync
Date: Tue, 10 Oct 2006 13:42:05 +0200
References: <342BAC0A5467384983B586A6B0B3767103C3B0DB@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767103C3B0DB@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610101342.05647.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 9. Oktober 2006 20:05 schrieb Graham, Simon:

Hi Simon,

Apart from a little whitespace change to make it to conform to
Linus' Linux coding style. I applied the patch as you sent it.

I read through it, and I could not spot anything wrong...

> 1. New fields are added to the mdev and bm_extent structs to count the
>    number of failed requests during resync - the field in bm_extent is
>    used to determine when we are finished with the extent at which
>    time it is zeroed so that next time we process the same extent,
>    we'll try to resync everything again.
>
> 2. Resync is considered done when the remaining count of block to sync
>    is <=3D the count of failed requests.
>
> 3. When a failure occurs, a new routine, drbd_rs_failed_io() is called
>    to handle this - it takes care of incrementing the failed counts
>    and determining if the resync operation is now done. This is called
>    when a NegRSDreply is sent or received and also when a NegAck is
>    received for a resync operation (this is necessary to ensure that
>    the SyncSource correctly knows when the resync is done).
>
> 4. When a resync operation completes and there have been failure, the
>    new code does NOT rotate the UUIDs - I felt this was correct
>    because the resync really hasn't completed in this case (also, I
>    found that if I did not do this, the code would end up resyncing
>    the entire disk next time!)
>
> I did not introduce any new states for this - let me know if you think
> there needs
> to be one; with this patch, we simply end up Connected and Inconsistent.
>

Right. I will test it here in my environment as well. What more and more
gets obvious that we need a method to start resync without setting the=20
bitmap, only to resync what is currently set.

Maybe "drbdadm resync".

Right now I do not see a reason for more states...

Thanks or the patch, great work!

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
