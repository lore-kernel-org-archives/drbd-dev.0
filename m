Return-Path: <axboe@kernel.dk>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
	[209.85.213.169]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 481831056446
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 16:16:59 +0200 (CEST)
Received: by mail-ig0-f169.google.com with SMTP id f1so148942733igr.1
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 07:16:59 -0700 (PDT)
To: Ming Lei <ming.lei@canonical.com>, Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
References: <1460634438-26530-1-git-send-email-ming.lei@canonical.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <570FA4F7.6020301@kernel.dk>
Date: Thu, 14 Apr 2016 08:11:03 -0600
MIME-Version: 1.0
In-Reply-To: <1460634438-26530-1-git-send-email-ming.lei@canonical.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Mike Snitzer <snitzer@redhat.com>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Shaohua Li <shli@fb.com>, Tejun Heo <tj@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH v4 0/8] block: prepare for multipage bvecs
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

On 04/14/2016 05:46 AM, Ming Lei wrote:
> Hi,
>
> Interests[1] have been shown in multipage bvecs, so this patchset
> try to prepare for the support and do two things:
>
> 1) the 1st 4 patches use bvec iterator to implement iterate_bvec(),
> then we can drop the non-standard way for iterating bvec, which
> can be thought as a good cleanup for lib/iov_iter.c
>
> 2) remove BIO_MAX_SECTORS & BIO_MAX_SIZE, and now there is only
> one user for each. Once multipage bvecs is introduced, one bio
> may hold lots of sectors, and we should always use sort of BIO_MAX_VECS
> which should be introduced in future and is similiar with current
> BIO_MAX_PAGES.
>
> xfstests(-a auto) have been run over ext4/xfs and no regression found
> by this patchset.

We've had too many disasters in the block layer the last few series, I'm 
making the 4.7 round a nice and small one. I don't mind taking prep 
patches for the multipage bvecs, if they are simple and clean, but 
that's about the extent of it.

Just a heads up.

-- 
Jens Axboe

