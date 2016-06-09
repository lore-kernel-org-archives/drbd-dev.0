Return-Path: <axboe@kernel.dk>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
	[209.85.223.179]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8F4EE1056445
	for <drbd-dev@lists.linbit.com>; Thu,  9 Jun 2016 18:11:29 +0200 (CEST)
Received: by mail-io0-f179.google.com with SMTP id o189so42146201ioe.2
	for <drbd-dev@lists.linbit.com>; Thu, 09 Jun 2016 09:11:28 -0700 (PDT)
To: Ming Lei <ming.lei@canonical.com>, Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <575993EA.3010005@kernel.dk>
Date: Thu, 9 Jun 2016 10:06:02 -0600
MIME-Version: 1.0
In-Reply-To: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>, Mike Snitzer <snitzer@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	NeilBrown <neilb@suse.com>, Sagi Grimberg <sagig@mellanox.com>,
	Steven Whitehouse <swhiteho@redhat.com>,
	linux-block@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Shaohua Li <shli@fb.com>,
	Tejun Heo <tj@kernel.org>, Keith Busch <keith.busch@intel.com>,
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

On 05/30/2016 07:34 AM, Ming Lei wrote:
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

Added patches 1-7, still waiting for an answer on my reply to #8.

-- 
Jens Axboe

