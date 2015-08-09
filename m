Return-Path: <mlin@kernel.org>
Message-ID: <1439103347.7880.3.camel@hasee>
From: Ming Lin <mlin@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Date: Sat, 08 Aug 2015 23:55:47 -0700
In-Reply-To: <20150809064128.GB2436@infradead.org>
References: <1436168690-32102-1-git-send-email-mlin@kernel.org>
	<20150731192337.GA8907@redhat.com>
	<CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com> <1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<yq18u9liwhj.fsf@sermon.lab.mkp.net>
	<1439099990.7880.0.camel@hasee> <20150809064128.GB2436@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Mike Snitzer <snitzer@redhat.com>, Lei <ming.lei@canonical.com>,
	device-mapper development <dm-devel@redhat.com>, Alasdair,
	Christoph Hellwig <hch@lst.de>, Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Kelleher <pjk1939@linux.vnet.ibm.com>, Philip,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Ming Lin <ming.l@ssi.samsung.com>,
	Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Ming, Minchan Kim <minchan@kernel.org>,
	Dongsu Park <dpark@posteo.net>, drbd-user@lists.linbit.com
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

On Sat, 2015-08-08 at 23:41 -0700, Christoph Hellwig wrote:
> On Sat, Aug 08, 2015 at 10:59:50PM -0700, Ming Lin wrote:
> > +/*
> > + * Ensure that max discard sectors doesn't overflow bi_size and hopefully
> > + * it is of the proper granularity as long as the granularity is a power
> > + * of two.
> > + */
> > +#define MAX_DISCARD_SECTORS ((1U << 31) >> 9)
> 
> Thisn't isn't MAX_DISCARD_SECTORS, it's MAX_BIO_SECTORS.  If we ever
> to something like Kent's multipage biovecs we'll actually need it for
> regular read/write bios in addition to discard and write same.
> 
> Except for that the patch looks reasonable to me.

Will change it to MAX_BIO_SECTORS.
May I add your ACK?


