Return-Path: <martin.petersen@oracle.com>
To: Mike Snitzer <snitzer@redhat.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1436168690-32102-1-git-send-email-mlin@kernel.org>
	<20150731192337.GA8907@redhat.com>
	<CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com> <1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
Date: Sat, 08 Aug 2015 12:19:20 -0400
In-Reply-To: <20150801163356.GA21478@redhat.com> (Mike Snitzer's message of
	"Sat, 1 Aug 2015 12:33:57 -0400")
Message-ID: <yq18u9liwhj.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Ming Lei <ming.lei@canonical.com>,
	device-mapper development <dm-devel@redhat.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Ming Lin <ming.l@ssi.samsung.com>,
	Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Ming Lin <mlin@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v5 01/11] block: make
	generic_make_request handle arbitrarily sized bios
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

>>>>> "Mike" == Mike Snitzer <snitzer@redhat.com> writes:

Mike> This will translate to all intermediate layers that might split
Mike> discards needing to worry about granularity/alignment too
Mike> (e.g. how dm-thinp will have to care because it must generate
Mike> discard mappings with associated bios based on how blocks were
Mike> mapped to thinp).

The fundamental issue here is that alignment and granularity should
never, ever have been enforced at the top of the stack. Horrendous idea
from the very beginning.

For the < handful of braindead devices that get confused when you do
partial or misaligned blocks we should have had a quirk that did any
range adjusting at the bottom in sd_setup_discard_cmnd().

There's a reason I turned discard_zeroes_data off for UNMAP!

Wrt. the range size I don't have a problem with capping at the 32-bit
bi_size limit. We probably don't want to send commands much bigger than
that anyway.

-- 
Martin K. Petersen	Oracle Linux Engineering
