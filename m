Return-Path: <lmb@suse.de>
Date: Mon, 4 Oct 2004 15:41:43 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Message-ID: <20041004134143.GX1542@marowsky-bree.de>
References: <200410041456.21841.philipp.reisner@linbit.com>
	<20041004130158.GP1542@marowsky-bree.de>
	<uIL/2eWT70b0jHBPleL+GiI=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uIL/2eWT70b0jHBPleL+GiI=lge@web.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-10-04T15:20:14, Lars Ellenberg <Lars.Ellenberg@linbit.com> wrote:

> "In case our user goes up the wall",
> we need to guarantee that whatever our users do,
> out lower level devices are identical. allways.

You can't. Not efficiently. You'd need global ordering and global
write/read locking. That would totally kill performance.

> so *in case* gfs had a bug, or something other does strange things with
> us, we can not trust it to not write concurrently on both nodes to the
> same block at the same time.

In case GFS or whatever else messes up it's internal write ordering and
cache coherency mechanisms, you're SOL anyway.

All what is needed is to guarantee the consistency when barriers come
down; ie, after a barrier (or tagged command sequence, as in SCSI) need
the devices be consistent (for writes which have happened so far).

> and the (wanted) side effect is, that we always know
> which regions of the device have been active,
> so we can do the resync correctly eventually.

Well, yes, but that's a different issue. Of course the activity logs etc
need to be kept.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

