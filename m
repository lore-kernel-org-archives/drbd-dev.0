Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E09071056445
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jun 2016 15:57:28 +0200 (CEST)
Date: Wed, 1 Jun 2016 09:57:25 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Message-ID: <20160601135725.GB30759@redhat.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
	<20160601134300.GA15656@infradead.org> <574EE8F7.4050509@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574EE8F7.4050509@suse.de>
Cc: Jens Axboe <axboe@fb.com>, Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Ming Lei <ming.lei@canonical.com>, linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagig@mellanox.com>, NeilBrown <neilb@suse.com>,
	Christoph Hellwig <hch@infradead.org>,
	Joe Thornber <ejt@redhat.com>, linux-block@vger.kernel.org,
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

On Wed, Jun 01 2016 at  9:53am -0400,
Hannes Reinecke <hare@suse.de> wrote:

> On 06/01/2016 03:43 PM, Christoph Hellwig wrote:
> > These patches look good on their own.  They might be an easier sell
> > just as bio cleanups :)
> 
> Fully agree. I've seen (some) improvements with those patches, so
> I'd prefer to have them.

Can you be more specific on what improvements you've seen?
