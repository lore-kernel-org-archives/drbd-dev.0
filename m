Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2C675101AC56
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2018 21:27:49 +0200 (CEST)
Date: Wed, 30 May 2018 15:27:48 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Message-ID: <20180530192747.GA6568@redhat.com>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
	<20180520222558.7053-8-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180520222558.7053-8-kent.overstreet@gmail.com>
Cc: axboe@kernel.dk, hch@infradead.org, linux-raid@vger.kernel.org,
	darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
	colyli@suse.de, linux-block@vger.kernel.org, clm@fb.com,
	neilb@suse.com, bacik@fb.com, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 07/12] dm: convert to
	bioset_init()/mempool_init()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, May 20 2018 at  6:25pm -0400,
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  drivers/md/dm-bio-prison-v1.c      | 13 ++++---
>  drivers/md/dm-bio-prison-v2.c      | 13 ++++---
>  drivers/md/dm-cache-target.c       | 25 ++++++-------
>  drivers/md/dm-core.h               |  4 +-
>  drivers/md/dm-crypt.c              | 60 ++++++++++++++----------------
>  drivers/md/dm-integrity.c          | 15 ++++----
>  drivers/md/dm-io.c                 | 29 ++++++++-------
>  drivers/md/dm-kcopyd.c             | 22 ++++++-----
>  drivers/md/dm-log-userspace-base.c | 19 +++++-----
>  drivers/md/dm-region-hash.c        | 23 ++++++------
>  drivers/md/dm-rq.c                 |  2 +-
>  drivers/md/dm-snap.c               | 17 ++++-----
>  drivers/md/dm-thin.c               | 32 ++++++++--------
>  drivers/md/dm-verity-fec.c         | 55 +++++++++++++--------------
>  drivers/md/dm-verity-fec.h         |  8 ++--
>  drivers/md/dm-zoned-target.c       | 13 +++----
>  drivers/md/dm.c                    | 53 ++++++++++++--------------
>  17 files changed, 197 insertions(+), 206 deletions(-)

In general I think each of these driver patches in the series needs a
one-line summary in the description, e.g.:
Embed bioset and mempool_t to avoid pointer indirection in the fast IO path.

But that aside, on a code level, I had to double check bioset_exit() is
safe to call even if bioset_init() failed.  AFter confirming it is (and
double checking by chatting with Kent) I like how the code is simpler
(not having to check if the bioset is set before calling it).

Nice job Kent, like you said: mostly mechnical.  But even the changes
that weren't purely mechnical (e.g. passing r to ERR_PTR, rather than
using old hardcode) were fixed up nicely.

Acked-by: Mike Snitzer <snitzer@redhat.com>
