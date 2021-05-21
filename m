Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
	[209.85.221.173])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 104A0420A73
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 10:38:08 +0200 (CEST)
Received: by mail-vk1-f173.google.com with SMTP id 184so3619823vkz.13
	for <drbd-dev@lists.linbit.com>; Fri, 21 May 2021 01:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210521055116.1053587-1-hch@lst.de>
	<20210521055116.1053587-20-hch@lst.de>
In-Reply-To: <20210521055116.1053587-20-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 May 2021 10:37:56 +0200
Message-ID: <CAMuHMdUReZCGwii_rJuOOag+jmn4E3yfH+=P3a=5bJDf8CJvrQ@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: nvdimm@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
	dm-devel@redhat.com, linux-bcache@vger.kernel.org,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	linux-s390 <linux-s390@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Matias Bjorling <mb@lightnvm.io>, Nitin Gupta <ngupta@vflare.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"open list:TENSILICA XTENSA PORT \(xtensa\)"
	<linux-xtensa@linux-xtensa.org>, Alex Dubov <oakad@yahoo.com>,
	Heiko Carstens <hca@linux.ibm.com>, Coly Li <colyli@suse.de>,
	linux-block@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Philip Kelleher <pjk1939@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Zankel <chris@zankel.net>,
	linux-raid@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
	Linux MMC List <linux-mmc@vger.kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Jim Paris <jim@jtan.com>, Minchan Kim <minchan@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Drbd-dev] [PATCH 19/26] nfblock: convert to
	blk_alloc_disk/blk_cleanup_disk
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

On Fri, May 21, 2021 at 7:52 AM Christoph Hellwig <hch@lst.de> wrote:
> Convert the nfblock driver to use the blk_alloc_disk and blk_cleanup_disk
> helpers to simplify gendisk and request_queue allocation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
