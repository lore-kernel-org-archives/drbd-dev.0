Return-Path: <lars.ellenberg@linbit.com>
Date: Sat, 12 Jan 2008 18:04:46 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>
Subject: Re: [Drbd-dev] Crash in lru_cache.c
Message-ID: <20080112170446.GA26053@debian-etc-mailname>
References: <342BAC0A5467384983B586A6B0B3767107C5B0B7@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107C5B0B7@EXNA.corp.stratus.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Jan 12, 2008 at 10:23:58AM -0500, Graham, Simon wrote:
> > > Because there WAS a disk when the request was issued - in fact, the
> > > local write to disk completed successfully, but the request is still
> > > sitting in the TL waiting for the next barrier to complete.
> > Subsequent
> > > to that but while the request is still in the TL, the local disk is
> > > detached.
> > 
> > AND it is re-attached so fast,
> > that we have a new (uhm; well, probably the same?) disk again,
> > while still the very same request is sitting there
> > waiting for that very barrier ack?
> > 
> 
> You got it!
> 
> > now, how unlikely is THAT to happen in real life.
> > 
> 
> Fairly rare I agree although someone could do a 'drbdadm detach' and
> then 'drbdadm attach' -- that's how we hit this situation (and the
> reason for THAT is as a way to test errors on meta-data reads)
> 
> Given that there is no real boundary on the lifetime of a request in the
> TL, it's also feasible (although unlikely I agree) that a disk could
> fail and be replaced and reattached whilst an old request is still in
> the TL...

well, there is.
the request will only live in the tl until either
 - connection is lost, and we call tl_clear
 - the corresponding barrier ack comes in

right, currently, a barrier is not sent when the epoch closes,
but before the next epoch start, which may be a very long time.
but, we are changing this anyways, and will now send the barrier
as soon as we close the current epoch.
once that is done, soon (milliseconds) after any request is reported as
completed to upper layers (which is the event that is causing the
current epoch to close, the barrier to be send),
it will also be cleared from the tl.

> > > I think this might work but only as a side effect -- if you look
> back
> > to
> > > the sequence I documented, you will see that there has to be a write
> > > request to the same AL area after the disk is reattached - this is
> > > because drbd_al_complete_io quietly ignores the case where no active
> > AL
> > > extent is found for the request being completed.
> > 
> > huh?
> > I simply disallow re-attaching while there are still requests pending
> > from before the detach.
> > no more (s & RQ_LOCAL_MASK), no more un-accounted for references.
> > 
> 
> Yes but those requests that have unaccounted references from before the
> detach are still in the TL 

no they are not, I just said I would not allow an attach
while they are still in there.

> -- it so happens that the code does not crash
> in this case (completing a request in the TL when there is no matching
> AL cache entry) but that's not very safe I think.
> 
> You also have to trigger a barrier as part of this -- not only block new
> requests during attach until the TL is empty but also trigger a barrier
> so that the TL will be emptied...

as outlined earlier, and implemented next week hopefully,
barriers will be sent as soon as the old epoch is closed,
not only when the first new request for the new epoch comes in.

> Both of these are why I like the idea of "reconnecting" the requests in
> the TL to the AL cache when doing an attach...
> 
> > if I understand correctly,
> > you can reproduce this easily.
> > to underline my point,
> > does it still trigger when you do
> >  "dd if=/dev/drbdX of=/dev/null bs=1b count=1 iflag=direct ; sleep 5"
> > before the re-attach?
> 
> So, the real test is to do this _before_ the DETACH, then see what
> happens when the requests are removed from the TL.

no. only a remote read can trigger a barrier.
as long as i have valid local data, all reads are local.

> > for other reasons, I think we need to rewrite the barrier code anyways
> > to send out the barrier as soon as possible, and not wait until the
> > next io request comes in.
> 
> That's an interesting idea -- it would also allow you to use the Linux
> barrier mechanism to implement. Still wouldn't handle this case I think
> though -- you can have requests in the TL that do not yet require a
> barrier when you lose the local disk...

sure I can have requests there, but they are not yet completed to upper
layers.  if they are, their correponding barrier will have been send out
already.

for attach, we would then do
  block new incomming request
  wait for ap count to reach zero
  [in current code, send out a barrier now;
   with the idea outline above, there is no need for that]
  wait for the lates barrier ack
      (tl now empty)
  attach
  unblock

am I still missing something?

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
