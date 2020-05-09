Return-Path: <dan.j.williams@intel.com>
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
	[209.85.218.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7AC1B4203D2
	for <drbd-dev@lists.linbit.com>; Sat,  9 May 2020 17:07:25 +0200 (CEST)
Received: by mail-ej1-f41.google.com with SMTP id re23so3887551ejb.4
	for <drbd-dev@lists.linbit.com>; Sat, 09 May 2020 08:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200508161517.252308-1-hch@lst.de>
	<CAPcyv4j3gVqrZWCCc2Q-6JizGAQXW0b+R1BcvWCZOvzaukGLQg@mail.gmail.com>
	<20200509082352.GB21834@lst.de>
In-Reply-To: <20200509082352.GB21834@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 9 May 2020 08:07:14 -0700
Message-ID: <CAPcyv4ggb7_rwzGbhHNXSHd+jjSpZC=+DMEztY6Cu8Bc=ZNzag@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
	linux-raid <linux-raid@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Geoff Levand <geoff@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jim Paris <jim@jtan.com>, linux-block@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>, linux-m68k@lists.linux-m68k.org,
	Philip Kelleher <pjk1939@linux.ibm.com>, linux-bcache@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] remove a few uses of ->queuedata
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, May 9, 2020 at 1:24 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, May 08, 2020 at 11:04:45AM -0700, Dan Williams wrote:
> > On Fri, May 8, 2020 at 9:16 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Hi all,
> > >
> > > various bio based drivers use queue->queuedata despite already having
> > > set up disk->private_data, which can be used just as easily.  This
> > > series cleans them up to only use a single private data pointer.
> >
> > ...but isn't the queue pretty much guaranteed to be cache hot and the
> > gendisk cache cold? I'm not immediately seeing what else needs the
> > gendisk in the I/O path. Is there another motivation I'm missing?
>
> ->private_data is right next to the ->queue pointer, pat0 and part_tbl
> which are all used in the I/O submission path (generic_make_request /
> generic_make_request_checks).  This is mostly a prep cleanup patch to
> also remove the pointless queue argument from ->make_request - then
> ->queue is an extra dereference and extra churn.

Ah ok. If the changelogs had been filled in with something like "In
preparation for removing @q from make_request_fn, stop using
->queuedata", I probably wouldn't have looked twice.

For the nvdimm/ driver updates you can add:

    Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...or just let me know if you want me to pick those up through the nvdimm tree.
