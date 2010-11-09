Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6B0B210590B0
	for <drbd-dev@lists.linbit.com>; Tue,  9 Nov 2010 11:19:05 +0100 (CET)
Message-ID: <4CD91FDD.3030603@kernel.org>
Date: Tue, 09 Nov 2010 11:18:05 +0100
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
	<1288628129-12811-5-git-send-email-tj@kernel.org>
	<20101103150658.GA5627@quack.suse.cz>
In-Reply-To: <20101103150658.GA5627@quack.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: shaggy@linux.vnet.ibm.com, leochen@broadcom.com, neilb@suse.de,
	heiko.carstens@de.ibm.com, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, konishi.ryusuke@lab.ntt.co.jp,
	drbd-dev@lists.linbit.com, joel.becker@oracle.com,
	hch@infradead.org, aelder@sgi.com, mfasheh@suse.com,
	joern@logfs.org, reiserfs-devel@vger.kernel.org,
	viro@zeniv.linux.org.uk, swhiteho@redhat.com,
	chris.mason@oracle.com, axboe@kernel.dk, tytso@mit.edu,
	sbranden@broadcom.com, petero2@telia.com,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
	akpm@linux-foundation.org
Subject: Re: [Drbd-dev] [PATCH 4/5] block: make blkdev_get/put() handle
	exclusive access
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On 11/03/2010 04:06 PM, Jan Kara wrote:
> On Mon 01-11-10 17:15:28, Tejun Heo wrote:
>   The patch looks OK to me as far as ext3, ext4, and reiserfs are
> concerned. One thing I wondered about when I looked at it - does someone
> use the 'mode' argument of the blkdev_put() function (well, apart from the
> exclusive flag)? Because I've looked at a few random disk ->release()
> functions and none of them used it...

Yeah, I thought about removing @mode and make blkdev_put() take
@holder for exclusive releases.  From what I can see, it doesn't seem
like any implementation cares but it's customary to have access to
@mode on ->release(), so I decided to keep it.  It's rather flaky as
there's no mechanism to check or enforce it tho.

Thanks.

-- 
tejun
