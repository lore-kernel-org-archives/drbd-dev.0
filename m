Return-Path: <lars.ellenberg@linbit.com>
Date: Fri, 5 Nov 2010 22:04:54 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20101105210454.GE2321@barkeeper1-xen.linbit>
References: <1288985241-3515-1-git-send-email-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1288985241-3515-1-git-send-email-snitzer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jens Axboe <jaxboe@fusionio.com>,
	Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block: read i_size with i_size_read()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Nov 05, 2010 at 03:27:21PM -0400, Mike Snitzer wrote:
> Convert direct reads of an inode's i_size to using i_size_read().
> 
> i_size_{read,write} use a seqcount to protect reads from accessing
> incomple writes.  Concurrent i_size_write()s require mutual exclussion
> to protect the seqcount that is used by i_size_{read,write}.  But
> i_size_read() callers do not need to use additional locking.
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> Cc: Jens Axboe <jaxboe@fusionio.com>
> Cc: Neil Brown <neilb@suse.de>
> Cc: drbd-dev@lists.linbit.com
> ---
>  block/blk-core.c              |    4 ++--
>  block/compat_ioctl.c          |    4 ++--
>  block/ioctl.c                 |    6 +++---
>  drivers/block/drbd/drbd_int.h |    2 +-
>  drivers/md/md.c               |   18 +++++++++---------
>  5 files changed, 17 insertions(+), 17 deletions(-)

DRBD one line fix trivially
  Acked-by: Lars Ellenberg <lars.ellenberg@linbit.com>


> NOTE: I stopped short of fixing drbd and nbd to use revalidate_disk
> and/or i_size_write.

Ok, we'll pick up the DRBD part of it.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
