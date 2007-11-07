Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 6 Nov 2007 22:54:02 -0500
Message-ID: <342BAC0A5467384983B586A6B0B376710707496D@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Handling on-disk caches
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

A few months ago, we had a discussion about how to handle systems with
on-disk caches enabled in the face of failures which can cause the cache
to be lost after disk writes are completed back to DRBD. At the time,
the suggestion was to rely on the Linux barrier implementation which is
used by the file systems to ensure correct behavior in the face of disk
caches.

I've now had time to get back to this and review the Linux barrier
implementation and it's become clear to me that the barrier
implementation is insufficient -- imagine the case where a write is
being done, it completes on the secondary (but is still in disk cache
there), then we power off this node -- NO errors are reported to Linux
on the primary (because the other half of the raid set is still there,
the original IO completes successfully BUT we have a difference side to
side...

So a failure of the secondary is NOT reflected back to linux and
therefore we can get out of sync in a way that does not track the blocks
that need to be resynced independent of the use of barriers.

Consider the following sequence of writes:

[1] [2] [3] [barrier] [4] [5]

If we've processed [1] through [3] and the writes have completed on both
primary and secondary but the data is sitting in the disk cache and then
the secondary is powered off, the following occurs:

1. The primary doesn't return any error to Linux
2. The primary goes ahead and processes the [barrier] (which flushes
[1]-[3] to disk then
   performs [4] and [5] and includes the blocks covered by these in the
DRBD bitmap.
3. Now the Secondary comes back -- we ONLY resync [4] and [5] even
though [1]-[3] never made it
   to disk (because we didn't execute the [barrier] on the secondary)

I think the solution to this consists of a number of changes:

1. As suggested previously, DRBD should respect barriers on the
secondary (by passing the appropriate=20
   flags to the secondary) -- this will handle unexpected failure of the
primary.
2. Meta-data updates (certainly the AL but possibly all meta-data
updates) should be
   issued as barrier requests (so that we know these are on disk before
issuing the
   associated writes) (I don't think they are currently)
3. DRBD should include the area addressed by the AL when recovering from
an unexpected
   secondary failure. There are two approaches for this:
   a) Maintain the AL on both sides - when the secondary restarts, add
the AL to the
      set of blocks needing to be resynced as is done on the primary
today
   b) Add the current AL to the bitmap on the primary when it loses
contact with the
      secondary.
  The second is probably easier and is, I think, just as effective --
even if the primary
  fails as well (so we lose the in memory bitmap), when it comes back it
WILL add the on-disk
  AL to the bitmap and we wont resync until it comes back...

What do you think?
Simon
