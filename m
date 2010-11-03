Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 3 Nov 2010 16:53:08 +0100
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
In-Reply-To: <1288628129-12811-1-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201011031653.09159.philipp.reisner@linbit.com>
Cc: jack@suse.cz, leochen@broadcom.com, neilb@suse.de,
	heiko.carstens@de.ibm.com, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, konishi.ryusuke@lab.ntt.co.jp,
	shaggy@linux.vnet.ibm.com, joel.becker@oracle.com,
	hch@infradead.org, aelder@sgi.com, mfasheh@suse.com,
	joern@logfs.org, reiserfs-devel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, viro@zeniv.linux.org.uk,
	swhiteho@redhat.com, chris.mason@oracle.com, axboe@kernel.dk,
	tytso@mit.edu, sbranden@broadcom.com, petero2@telia.com,
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

Am Montag, 1. November 2010, um 17:15:24 schrieb Tejun Heo:
> bdev exclusive access handling is somewhat clumsy.  The primary
> interface is bd_claim() and bd_release() but there also are
> open_bdev_exclusive(), close_bdev_exclusive() and bd_claim_by_disk()
> and bd_release_from_disk().
[...]
>  drivers/block/drbd/drbd_int.h   |    2
>  drivers/block/drbd/drbd_main.c  |    7
>  drivers/block/drbd/drbd_nl.c    |  103 ++-----
[...]

Hi Tejun,

  Acked-by: Philipp Reisner <philipp.reisner@linbit.com>

...for the DRBD part of the patch.

Best,
 Phil
