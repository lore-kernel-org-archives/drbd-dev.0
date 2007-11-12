Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Handling on-disk caches
Date: Mon, 12 Nov 2007 13:39:59 +0100
References: <342BAC0A5467384983B586A6B0B376710707496D@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B376710707496D@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711121339.59824.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wednesday 07 November 2007 04:54:02 Graham, Simon wrote:
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

Right. So far I completely agree.

> I think the solution to this consists of a number of changes:
>
> 1. As suggested previously, DRBD should respect barriers on the
> secondary (by passing the appropriate
>    flags to the secondary) -- this will handle unexpected failure of the
> primary.

Right. We should do that. 
I think that we do that for the BIO_RW_BARRIER, and the BIO_RW_SYNC
flag already.

> 2. Meta-data updates (certainly the AL but possibly all meta-data
> updates) should be
>    issued as barrier requests (so that we know these are on disk before
> issuing the
>    associated writes) (I don't think they are currently)

Right. We currently do not use BIO_RW_BARRIER here, but we should do so.

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

For item 3 I have an other opinion. 

On the primary we have a data structure called the "transfer log" or tl
in the code. Up to now this was mainly important for protocol A and B.

It is a data structure conaining objects for all our self-generated 
drbd-barriers on the fly, and objects for all write requests between
these barriers.

If we loose connection in protocol A or B we need to mark everything
we find in the transfer_log as out-of-sync in the bitmap.

When we also do this for protocol C, _AND_ use BIO_RW_BARRIER for
doing writing on the secondary we have solved the issue you
described in the first part of the mail.

I took this as occasion to write down what we are currently up
to in development of DRBD-8.2.

1  Online Verify. 

   Release the online-verify code from drbd-plus to drbd-8.2, creating a new
   protocol version by the way.

2  Hot cache.
 
   Finish the hot cache feature. With this feature enabled DRBD updates the
   correct block caches (page cache) on the secondary node, as data gets
   written and read on the primary. 

   Rationale: On Database machines with huge amounts of RAM, the database
   can only deliver reasonable performance if Linux's disk caches are hot.
   With a conventional DRBD cluster for such a database, the performance
   of the database is after a switchover insufficient, since the caches
   on the secondary machine are cold.

3  write quorum of 2.

   There are users that want to use DRBD to mirror data but do not want
   it to continue in case the connection to the secondary is lost. Such
   a system is not an HA-system but an always redundant system. It should
   freeze IO in case the connection to the secondary is lost, or the 
   the local disk gets detached. And thaw IO as soon as both pathes
   are available again.

4  Configurable write quorum weights.

   For OCFS2/GFS users it makes even sense to have configurable weights
   for the write quorum. So that one can setup a cluster in that node
   A continues to run but node B freezes its IO when the brain splits.

I should mention that number 1 and 2 are already in the works and
will soon appear in DRBD-8.2.

Now I added to the list:

5  Use the kernel's write barriers

   As the support for write barriers is now available  (this holds
   true for hardware as for the Linux kernel) we should make use of 
   this.

   * Use BIO_RW_BARRIER writes for updates to our meta-data-superblock.

   * Use BIO_RW_BARRIER for writes to the AL.

   * Implement the algorithm descibed in section 6 of 
     http://www.drbd.org/fileadmin/drbd/publications/drbd8.pdf .

   * Delay setting of RQ_NET_DONE in the request objects until the right
     BarrierAck comes in, also for protocol C.



Does this make sense ?

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
