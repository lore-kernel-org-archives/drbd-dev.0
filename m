Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C75EA1019A78
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 22:28:52 +0200 (CEST)
Received: by pbbro2 with SMTP id ro2so6330684pbb.27
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 13:28:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 29 May 2012 05:28:39 +0900
From: Tejun Heo <tj@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID: <20120528202839.GA18537@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-15-git-send-email-koverstreet@google.com>
	<20120525204651.GA24246@redhat.com>
	<20120525210944.GB14196@google.com>
	<20120525223937.GF5761@agk-dp.fab.redhat.com>
	<Pine.LNX.4.64.1205281129180.2227@file.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1205281129180.2227@file.rdu.redhat.com>
Cc: axboe@kernel.dk, Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <koverstreet@google.com>,
	Dave Chinner <dchinner@redhat.com>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	tytso@google.com, vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, yehuda@hq.newdream.net,
	drbd-dev@lists.linbit.com, Alasdair G Kergon <agk@redhat.com>,
	sage@newdream.net
Subject: Re: [Drbd-dev] [PATCH v3 14/16] Gut bio_add_page()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On Mon, May 28, 2012 at 12:07:14PM -0400, Mikulas Patocka wrote:
> With accurately sized bios, you send one bio for 256 sectors (it is sent 
> immediatelly to the disk) and a second bio for another 256 sectors (it is 
> put to the block device queue). The first bio finishes, pages are marked 
> as uptodate, the second bio is sent to the disk. While the disk is 

They're split and made in-flight together.

> processing the second bio, the kernel already knows that the first 256 
> sectors are finished - so it copies the data to userspace and lets the 
> userspace process them - while the disk is processing the second bio. So, 
> disk transfer and data processing are overlapped.
>
> Now, with your patch, you send just one 512-sector bio. The bio is split 
> to two bios, the first one is sent to the disk and you wait. The disk 
> finishes the first bio, you send the second bio to the disk and wait. The 
> disk finishes the second bio. You complete the master bio, mark all 512 
> sectors as uptodate in the pagecache, start copying data to the userspace 
> and processing them. Disk transfer and data processing are not overlapped.

Disk will most likely seek to the sector read all of them into buffer
at once and then serve the two consecutive commands back-to-back
without much inter-command delay.

> accurately-sized bios (that don't span stripe boundaries), each bio waits 
> just for one disk to seek to the requested position. If you send oversized 
> bio that spans several stripes, that bio will wait until all the disks 
> seek to the requested position.
> 
> In general, you can send oversized bios if the user is waiting for all the 
> data requested (for example O_DIRECT read or write). You shouldn't send 
> oversized bios if the user is waiting just for a small part of data and 
> the kernel is doing readahead - in this case, oversized bio will result in 
> additional delay.

Isn't it more like you shouldn't be sending read requested by user and
read ahead in the same bio?

> I think bio_add_page should be simplified in such a way that in the most 
> common cases it doesn't create oversized bio, but it can create oversized 
> bios in uncommon cases. We could retain a limit on a maximum number of 
> sectors (this limit is most commonly hit on disks), put a stripe boundary 
> to queue_limits (the stripe boundary limit is most commonly hit on raid), 
> ignore the rest of the limits in bio_add_page and remove merge_bvec.

If exposing segmenting limit upwards is a must (I'm kinda skeptical),
let's have proper hints (or dynamic hinting interface) instead.

Thanks.

-- 
tejun
