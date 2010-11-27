Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 255B510589E0
	for <drbd-dev@lists.linbit.com>; Sat, 27 Nov 2010 17:01:43 +0100 (CET)
Message-ID: <4CF12B4B.2050909@kernel.org>
Date: Sat, 27 Nov 2010 17:01:15 +0100
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: axboe@kernel.dk, hch@infradead.org, linux-kernel@vger.kernel.org,
	petero2@telia.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
	jack@suse.cz, akpm@linux-foundation.org, adilger.kernel@dilger.ca,
	tytso@mit.edu, mfasheh@suse.com, joel.becker@oracle.com,
	aelder@sgi.com, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
	neilb@suse.de, leochen@broadcom.com, sbranden@broadcom.com,
	chris.mason@oracle.com, swhiteho@redhat.com, shaggy@linux.vnet.ibm.com,
	joern@logfs.org, konishi.ryusuke@lab.ntt.co.jp,
	reiserfs-devel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
	<4CDC2488.1030801@kernel.org>
In-Reply-To: <4CDC2488.1030801@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

On 11/11/2010 06:14 PM, Tejun Heo wrote:
> Hello,
> 
> I just appended two patches to the series.  These two are the
> blkdev_get_by_*() cleanup patches suggested in the fourth patch which
> Christoph liked.
> 
> I updated the git tree accordingly and added acked-by's.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git cleanup-bd_claim
> 
> Jens, if you want the whole series resent, please let me know.

Ping.

-- 
tejun
