Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 651711005420
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 237F71B4361
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:05 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fn4r1OGRyGTe for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:41:05 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 942D81B435C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:04 +0200 (CEST)
Resent-Message-ID: <20120530084104.GN4141@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D0C9F1019A68
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 18:07:30 +0200 (CEST)
Date: Mon, 28 May 2012 12:07:14 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Alasdair G Kergon <agk@redhat.com>
In-Reply-To: <20120525223937.GF5761@agk-dp.fab.redhat.com>
Message-ID: <Pine.LNX.4.64.1205281129180.2227@file.rdu.redhat.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-15-git-send-email-koverstreet@google.com>
	<20120525204651.GA24246@redhat.com> <20120525210944.GB14196@google.com>
	<20120525223937.GF5761@agk-dp.fab.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: axboe@kernel.dk, Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <koverstreet@google.com>,
	Dave Chinner <dchinner@redhat.com>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, tytso@google.com,
	bharrosh@panasas.com, linux-fsdevel@vger.kernel.org,
	yehuda@hq.newdream.net, drbd-dev@lists.linbit.com,
	vgoyal@redhat.com, sage@newdream.net
Subject: Re: [Drbd-dev] [PATCH v3 14/16] Gut bio_add_page()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi

The general problem with bio_add_page simplification is this:

Suppose that you have an old ATA disk that can read or write at most 256 
sectors. Suppose that you are reading from the disk and readahead for 512 
sectors is used:

With accurately sized bios, you send one bio for 256 sectors (it is sent 
immediatelly to the disk) and a second bio for another 256 sectors (it is 
put to the block device queue). The first bio finishes, pages are marked 
as uptodate, the second bio is sent to the disk. While the disk is 
processing the second bio, the kernel already knows that the first 256 
sectors are finished - so it copies the data to userspace and lets the 
userspace process them - while the disk is processing the second bio. So, 
disk transfer and data processing are overlapped.

Now, with your patch, you send just one 512-sector bio. The bio is split 
to two bios, the first one is sent to the disk and you wait. The disk 
finishes the first bio, you send the second bio to the disk and wait. The 
disk finishes the second bio. You complete the master bio, mark all 512 
sectors as uptodate in the pagecache, start copying data to the userspace 
and processing them. Disk transfer and data processing are not overlapped.

The same problem arises with raid-0, raid-5 or raid-10: if you send 
accurately-sized bios (that don't span stripe boundaries), each bio waits 
just for one disk to seek to the requested position. If you send oversized 
bio that spans several stripes, that bio will wait until all the disks 
seek to the requested position.

In general, you can send oversized bios if the user is waiting for all the 
data requested (for example O_DIRECT read or write). You shouldn't send 
oversized bios if the user is waiting just for a small part of data and 
the kernel is doing readahead - in this case, oversized bio will result in 
additional delay.


I think bio_add_page should be simplified in such a way that in the most 
common cases it doesn't create oversized bio, but it can create oversized 
bios in uncommon cases. We could retain a limit on a maximum number of 
sectors (this limit is most commonly hit on disks), put a stripe boundary 
to queue_limits (the stripe boundary limit is most commonly hit on raid), 
ignore the rest of the limits in bio_add_page and remove merge_bvec.

Mikulas



On Fri, 25 May 2012, Alasdair G Kergon wrote:

> Where's the urge to remove merge_bvec coming from?
> 
> I think it's premature to touch this, and that the other changes, if
> fixed and integrated, should be allowed to bed themselves down first.
> 
> 
> Ideally every bio would be the best size on submission and no bio would
> ever need to be split.
> 
> But there is a cost involved in calculating the best size - we use
> merge_bvec for this, which gives a (probable) maximum size.  It's
> usually very cheap to calculate - but not always.  [In dm, we permit
> some situations where the answer we give will turn out to be wrong, but
> ensure dm will always fix up those particular cases itself later and
> still process the over-sized bio correctly.]
> 
> Similarly there is a performance penalty incurred when the size is wrong
> - the bio has to be split, requiring memory, potential delays etc.
> 
> There is a trade-off between those two, and our experience with the current
> code has that tilted strongly in favour of using merge_bvec all the time.
> The wasted overhead in cases where it is of no benefit seem to be
> outweighed by the benefit where it does avoid lots of splitting and help
> filesystems optimise their behaviour.
> 
> 
> If the splitting mechanism is changed as proposed, then that balance
> might shift.  My gut feeling though is that any shift would strengthen
> the case for merge_bvec.
> 
> Alasdair
> 
