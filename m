Return-Path: <BATV+e6e8d67345077491df58+4143+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 789D01028A59
	for <drbd-dev@lists.linbit.com>; Sat, 27 Dec 2014 16:02:19 +0100 (CET)
Date: Sat, 27 Dec 2014 07:02:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dongsu Park <dongsu.park@profitbricks.com>
Message-ID: <20141227150207.GC1094@infradead.org>
References: <cover.1419241597.git.dongsu.park@profitbricks.com>
	<d26a9a0fc9a7d1529c115785ee5935d5750782bd.1419241597.git.dongsu.park@profitbricks.com>
	<20141223101614.GA13138@infradead.org>
	<20141223114140.GB15080@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141223114140.GB15080@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Oleg Drokin <oleg.drokin@intel.com>,
	Nitin Gupta <ngupta@vflare.org>,
	Mike Snitzer <snitzer@redhat.com>, Ming Lin <mlin@minggr.net>,
	Minchan Kim <minchan@kernel.org>, Neil Brown <neilb@suse.de>,
	Jiri Kosina <jkosina@suse.cz>, Ming Lei <ming.lei@canonical.com>,
	linux-kernel@vger.kernel.org, Jim Paris <jim@jtan.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, Geoff Levand <geoff@infradead.org>,
	Kent Overstreet <kmo@daterainc.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <andreas.dilger@intel.com>, dm-devel@redhat.com,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC PATCH 01/17] block: make generic_make_request
 handle arbitrarily sized bios
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

On Tue, Dec 23, 2014 at 12:41:40PM +0100, Dongsu Park wrote:
> You mean, checking rq->cmd_type == REQ_TYPE_BLOCK_PC, right?
> 
> I'm wondering about how to check that in blk_queue_split().
> At the moment when blk_queue_split() is called, it's even before a request
> is mapped e.g. in blk_sq_make_request().
> Unlike scsi drivers where it's easy to get cmd->rq, blk_queue_split()
> doesn't seem to be able to get a request by blk_get_request().
> 
> Or am I missing something?

You're probably missing what I didn't notice either: BLOCK_PC requests
are never sent through ->make_request.  Consider my comment withdrawn
and sorry for the confusion.
