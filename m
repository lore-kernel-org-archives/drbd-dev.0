Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Running Protocol C with disk cache enabled
Date: Wed, 20 Jun 2007 15:33:14 +0200
References: <342BAC0A5467384983B586A6B0B3767105BD4EEC@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767105BD4EEC@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706201533.14467.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tuesday 19 June 2007 17:16:40 Graham, Simon wrote:
> I've been thinking recently about making sure that DRBD handles failures
> properly when the disks are run with their caches enabled - in most
> cases, I believe that the existing activity log code in DRBD will
> correctly handle this by ensuring that portions of the disk that _might_
> have been in cache only when a failure occurred are resynchronized.
>

Well, right. An interesting question. But do we really need to solve
it in DRBD ? 

In the end it is the file system that wants to ensure that something
is on disk.

The first answer that I had for this was (Linux-2.2 and Linux-2.4)

  wait until IO is completed, then it is on disk.

This of course totally ignored that even at that time most
IDE drives already had write caches in write-back mode. Even worse,
on most drives it is not possible to disable these caches. 

The message to our customers was: 
  Either use a (RAID) disk controller with battery backed RAM
  or with write caches in write-through, not in write-back mode.

Now since the time of Linux-2.6 we (finally) got IO-barriers.

Each driver can not state what it needs to really write the
stuff on the fly to disk:

	 * NONE		: hardbarrier unsupported
	 * DRAIN	: ordering by draining is enough
	 * DRAIN_FLUSH	: ordering by draining w/ pre and post flushes
	 * DRAIN_FUA	: ordering by draining w/ pre flush and FUA write
	 * TAG		: ordering by tag is enough
	 * TAG_FLUSH	: ordering by tag w/ pre and post flushes
	 * TAG_FUA	: ordering by tag w/ pre flush and FUA write

The last time I looked I realized that non of the machines in 
our LAB had a driver that exposed something else than NONE. 

Filesystems slowly start to use the WRITE_BARRIER flag on
BIOs with is then translated by the queuing layer to right
request flags on the requests according to the Queue settings.

What we see of those filesystems is:
"JBD: barrier-based sync failed on XXX - disabling barriers"

Ok, so far the theory and the facts IMHO.

How is DRBD concerned with all this. I think we are done as long
as we pass the BIO_RW_BARRIER and BIO_RW_SYNC flags from the primary
to the secondary. -- And we need to respect the implicit write
barriers that arise out of the the usage pattern:

 submit_bio()
 wait_for_io_complation()
 submit_bio()

>
> However - there is one case that I don't think is covered currently;
> it's entirely possible that I'm missing something, but I wanted to
> check; the case in question is if the Secondary system suffers an
> unexpected power loss, therebye potentially losing some writes that were
> acknowledged prior to the failure. Now, I think that the activity log
> maintained by the Primary actually includes the necessary information
> about blocks which should be resynchronized _but_ I don't see any code
> that would actually add these blocks to the bitmap when such a failure
> occurs.
>

Right we do not do this. The current opinion on this is: If the
disk reported IO completion it has to be on disk. (actually a point
of view of the Linux-2.2 and Linux-2.4 time).

Hmm, I can see you point let me think about this for a few days.

Even if we would mark everything after the last acknoweldeg
BIO_RW_BARRIER, we have to keep in mind that today most drivers'
queues are of type NONE.

>
> Conversely, if the Primary suffers an unexpected power loss, when it
> comes back up, it will add all the blocks described by its on-disk
> activity log to the bitmap as part of the attach processing on that
> node.
>

Right. We do this.
The original intention of the AL was to "revert" blocks that got written
on the primary shortly before a crash, and made it to disk but not to
network before the crash.

>
> Maybe this is overkill, but perhaps the Primary should add the contents
> of the current AL to the in-memory and on-disk bitmaps whenever it loses
> contact with the secondary unexpectedly?
>

Simon, I definitely see your point.

It is necessary for disk subsystems that "lie" to the upper layers
with their completion events. -- But you are right, most of todays'
disk subsystems do this. -- Maybe it should be configurable...

Let me think about it... , further comments and opinions welcome of course!

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
