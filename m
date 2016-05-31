Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 721D51056332
	for <drbd-dev@lists.linbit.com>; Tue, 31 May 2016 17:53:52 +0200 (CEST)
Date: Tue, 31 May 2016 11:53:49 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Ming Lei <ming.lei@canonical.com>
Message-ID: <20160531155348.GA24840@redhat.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
Cc: linux-block@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	linux-kernel@vger.kernel.org, Sagi Grimberg <sagig@mellanox.com>,
	NeilBrown <neilb@suse.com>, Jens Axboe <axboe@fb.com>,
	Joe Thornber <ejt@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Shaohua Li <shli@fb.com>, Tejun Heo <tj@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH v6 0/8] block: prepare for multipage bvecs
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

On Mon, May 30 2016 at  9:34am -0400,
Ming Lei <ming.lei@canonical.com> wrote:

> 
> Hi,
> 
> Interests[1] have been shown in multipage bvecs, so this patchset
> try to prepare for the support and do two things:
> 
> 1) the 1st 4 patches use bvec iterator to implement iterate_bvec(),
> then we can drop the non-standard way for iterating bvec, which
> can be thought as a good cleanup for lib/iov_iter.c
> 
> 2) remove BIO_MAX_SECTORS and makre BIO_MAX_SIZE as obsolete, and
> now there is only one user for each. Once multipage bvecs is introduced,
> one bio may hold lots of sectors, and we should always use sort of
> BIO_MAX_VECS which should be introduced in future and is similiar
> with current BIO_MAX_PAGES.
> 
> The only functional change is iterate_bvec():lib/iov_iter.c
> 
> xfstests(-a auto) over loop aio is run for ext4/xfs to verify 
> the change and no regression found with this patchset.
> 
> V6:
> 	- rebased on v4.7-rc1
> 	- add reviewed-by tag
> 	- mark BIO_MAX_SIZE as obsolete instead of removing because
> 	dm-tree adds one usage now

Not sure what you're referring to here with "dm-tree" (since "dm-tree"
doesn't exist).  But only direct user of "BIO_MAX_SIZE" in DM appears to
be dm-crypt.c.  Maybe you've identified some indirect use of
BIO_MAX_SIZE?
