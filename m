Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (0122700014.0.fullrate.dk [95.166.99.235])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 68FDC10589E3
	for <drbd-dev@lists.linbit.com>; Sat, 27 Nov 2010 19:47:40 +0100 (CET)
Message-ID: <4CF1524B.8020207@kernel.dk>
Date: Sat, 27 Nov 2010 19:47:39 +0100
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
	<4CDC2488.1030801@kernel.org> <4CF12B4B.2050909@kernel.org>
In-Reply-To: <4CF12B4B.2050909@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jack@suse.cz, leochen@broadcom.com, neilb@suse.de,
	heiko.carstens@de.ibm.com, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, konishi.ryusuke@lab.ntt.co.jp,
	shaggy@linux.vnet.ibm.com, drbd-dev@lists.linbit.com,
	joel.becker@oracle.com, hch@infradead.org, aelder@sgi.com,
	mfasheh@suse.com, joern@logfs.org,
	reiserfs-devel@vger.kernel.org, viro@zeniv.linux.org.uk,
	swhiteho@redhat.com, chris.mason@oracle.com, tytso@mit.edu,
	sbranden@broadcom.com, petero2@telia.com,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
	akpm@linux-foundation.org
Subject: Re: [Drbd-dev] [PATCHSET] block: clean up bdev claim/release
	handling
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2010-11-27 17:01, Tejun Heo wrote:
> On 11/11/2010 06:14 PM, Tejun Heo wrote:
>> Hello,
>>
>> I just appended two patches to the series.  These two are the
>> blkdev_get_by_*() cleanup patches suggested in the fourth patch which
>> Christoph liked.
>>
>> I updated the git tree accordingly and added acked-by's.
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git cleanup-bd_claim
>>
>> Jens, if you want the whole series resent, please let me know.
> 
> Ping.

You don't have to resend it, I'll pull it in.

-- 
Jens Axboe

