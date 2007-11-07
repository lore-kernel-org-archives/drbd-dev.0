Return-Path: <lars.ellenberg@linbit.com>
Date: Wed, 7 Nov 2007 15:03:02 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>
Subject: Re: [Drbd-dev] Handling on-disk caches
Message-ID: <20071107140302.GE11379@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B376710707496D@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B376710707496D@EXNA.corp.stratus.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Nov 06, 2007 at 10:54:02PM -0500, Graham, Simon wrote:
> A few months ago, we had a discussion about how to handle systems with
> on-disk caches enabled in the face of failures which can cause the cache
> to be lost after disk writes are completed back to DRBD. At the time,
> the suggestion was to rely on the Linux barrier implementation which is
> used by the file systems to ensure correct behavior in the face of disk
> caches.
> 
> I've now had time to get back to this and review the Linux barrier
> implementation and it's become clear to me that the barrier
> implementation is insufficient -- imagine the case where a write is
> being done, it completes on the secondary (but is still in disk cache
> there), then we power off this node -- NO errors are reported to Linux
> on the primary (because the other half of the raid set is still there,
> the original IO completes successfully BUT we have a difference side to
> side...
> 
> So a failure of the secondary is NOT reflected back to linux and
> therefore we can get out of sync in a way that does not track the blocks
> that need to be resynced independent of the use of barriers.
> 
> Consider the following sequence of writes:
> 
> [1] [2] [3] [barrier] [4] [5]
> 
> If we've processed [1] through [3] and the writes have completed on both
> primary and secondary but the data is sitting in the disk cache and then
> the secondary is powered off, the following occurs:
> 
> 1. The primary doesn't return any error to Linux
> 2. The primary goes ahead and processes the [barrier] (which flushes
> [1]-[3] to disk then
>    performs [4] and [5] and includes the blocks covered by these in the
> DRBD bitmap.
> 3. Now the Secondary comes back -- we ONLY resync [4] and [5] even
> though [1]-[3] never made it
>    to disk (because we didn't execute the [barrier] on the secondary)
> 
> I think the solution to this consists of a number of changes:

I think there is no solution to this short of fixing the lower
layers/hardware to not tell lies.

> 1. As suggested previously, DRBD should respect barriers on the
> secondary (by passing the appropriate flags to the secondary) -- this
> will handle unexpected failure of the primary.

actually, we do not support "barriers" in the sense of  tagged command
queuing or even only "BIO_RW_BARRIER" at all, yet.
we only support a "flush" like barrier, i.e. if kernel wants a barrier,
it needs to wait for all outstanding requests to be finished.

we do however provide our own "drbd barriers",
to ensure that write ordering on the secondary is respected.

yes, we trust (as the linux kernel in total) that once a completion
event happens for a bio, it is indeed on stable storage.
if the storage lies, there is not much we can do about that.

we probably should start to support BIO_RW_BARRIER.
but still, we have to trust the lower layers.

> 2. Meta-data updates (certainly the AL but possibly all meta-data
> updates) should be issued as barrier requests (so that we know these
> are on disk before issuing the associated writes) (I don't think they
> are currently)

I may be wrong, but even with barrier requests,
I doubt that a device with volatile write cache enabled would
handle such a "barrier" thing any different.

the assumption are
 a disk accepts a write request,
 and "completes" it (reports as on stable storage)
 when it is in the "on disk cache", even when that cache is volatile,
 not stable (battery backed).

 that same disk would somehow treat a "barrier" write request different,
 and this time in fact get the things from its on disk cache
 to stable storage.

I think this assumption will not hold true.
but my hardware knowlegde is lacking, so I may be wrong.
what makes you know that this assumption is valid?

if I am right,
there is no point in trying to do "3.",
because it would not "solve" the issue,
but only make it less likely to see any bad things.

> 3. DRBD should include the area addressed by the AL when recovering from
> an unexpected
>    secondary failure. There are two approaches for this:
>    a) Maintain the AL on both sides - when the secondary restarts, add
> the AL to the
>       set of blocks needing to be resynced as is done on the primary
> today
>    b) Add the current AL to the bitmap on the primary when it loses
> contact with the
>       secondary.
>   The second is probably easier and is, I think, just as effective --
> even if the primary
>   fails as well (so we lose the in memory bitmap), when it comes back it
> WILL add the on-disk
>   AL to the bitmap and we wont resync until it comes back...

and even if I am wrong, and "barrier" writes would in fact induce a
write through, thus we could trust our bitmap and metadata...

any network hickup would cause a resync of the area equivalent to the
activity log (several GB in most cases), were it would have caused only
very few blocks to be resynced now.

hm. but better sync some GB to much than overlook one KB, right.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
