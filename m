Return-Path: <hch@lst.de>
Date: Sat, 8 Aug 2015 14:35:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kent Overstreet <kent.overstreet@gmail.com>
Message-ID: <20150808123521.GA8216@lst.de>
References: <1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<1438581502.26596.24.camel@hasee> <20150804113626.GA12682@lst.de>
	<1438754604.29731.31.camel@hasee>
	<20150807073001.GA17485@lst.de> <1438990806.24452.8.camel@ssi>
	<20150808003057.GA1811@kmo-pixel>
	<CAF1ivSYAiRqG1RhxiHE+cfogB_VKyDDs0aE7YbtZ2o6UeGhZcQ@mail.gmail.com>
	<20150808052226.GA7050@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150808052226.GA7050@kmo-pixel>
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>, dm-devel@redhat.com,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, Nitin Gupta <ngupta@vflare.org>,
	Ming Lin <ming.l@ssi.samsung.com>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Ming Lin <mlin@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 01/11] block: make generic_make_request
	handle	arbitrarily sized bios
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

On Fri, Aug 07, 2015 at 09:22:26PM -0800, Kent Overstreet wrote:
> Is granularity required to be a power of two? One would hope, but looking at the
> code that doesn't appear to be a requirement... ugh, that's terrible...

If devices have an odd granularity we'll just have to split more than
nessecary.  Let's hope no major hardware does that.
