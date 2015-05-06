Return-Path: <BATV+6c74f8c349a9404a205a+4273+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 5 May 2015 23:48:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lin <mlin@kernel.org>
Message-ID: <20150506064849.GB5181@infradead.org>
References: <1430203717-13307-1-git-send-email-mlin@kernel.org>
	<1430203717-13307-2-git-send-email-mlin@kernel.org>
	<20150428114320.GA9790@lst.de> <5549AFD4.5020803@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5549AFD4.5020803@kernel.org>
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>,
	Keith Busch <keith.busch@intel.com>, dm-devel@redhat.com,
	Joshua Morris <josh.h.morris@us.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Minchan Kim <minchan@kernel.org>,
	Christoph Hellwig <hch@lst.de>, drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/10] block: make generic_make_request
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

On Tue, May 05, 2015 at 11:08:20PM -0700, Ming Lin wrote:
> How about below incremental patch?

> -
> -		/*
> -		 * If the queue doesn't support SG gaps and adding this
> -		 * offset would create a gap, disallow it.
> -		 */
> -		if (q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS) &&
> -		    bvec_gap_to_prev(prev, offset))
> -			return 0;

You need to keep the explicit checks for the BLOCK_PC case, as we can't
split those.

Otherwise it looks fine.
