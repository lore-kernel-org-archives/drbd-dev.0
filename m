Return-Path: <BATV+56f34be8dd15322694df+4665+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id ACE2A1056332
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jun 2016 15:44:32 +0200 (CEST)
Date: Wed, 1 Jun 2016 06:44:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@canonical.com>
Message-ID: <20160601134427.GA15888@infradead.org>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
	<20160531155348.GA24840@redhat.com>
	<CACVXFVM9FqZFkMat_4ysJ8_vFd1FFnf6Bd9sHDDoCK=v93wViQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVM9FqZFkMat_4ysJ8_vFd1FFnf6Bd9sHDDoCK=v93wViQ@mail.gmail.com>
Cc: linux-block@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sagi Grimberg <sagig@mellanox.com>, NeilBrown <neilb@suse.com>,
	Jens Axboe <axboe@fb.com>, Joe Thornber <ejt@redhat.com>,
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

On Wed, Jun 01, 2016 at 08:38:41PM +0800, Ming Lei wrote:
> > be dm-crypt.c.  Maybe you've identified some indirect use of
> > BIO_MAX_SIZE?
> 
> I mean the recently introduced BIO_MAX_SIZE in -next tree:
> 
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/md/dm-crypt.c?id=4ed89c97b0706477b822ea2182827640c0cec486

The crazy bcache bios striking back once again.  I really think it's
harmful having a _MAX value and then having a minor driver
reinterpreting it and sending larger ones.  Until we can lift the
maximum limit in general nad have common code exercise it we really need
to stop bcache from sending these instead of littering the tree with
workarounds.
