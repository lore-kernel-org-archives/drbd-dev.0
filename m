Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A6B59420603
	for <drbd-dev@lists.linbit.com>; Wed,  1 Sep 2021 21:41:41 +0200 (CEST)
Date: Wed, 1 Sep 2021 12:41:25 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <YS/XZeu3J3nAXUll@bombadil.infradead.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
	<20210830221000.179369-2-mcgrof@kernel.org>
	<CAMuHMdUUrp-ktVmOPRs7KinykrVKEMx-dG42RapPc-egxODNnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUUrp-ktVmOPRs7KinykrVKEMx-dG42RapPc-egxODNnQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, justin@coraid.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Tim Waugh <tim@cyberelk.net>, Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	"open list:TENSILICA XTENSA PORT \(xtensa\)"
	<linux-xtensa@linux-xtensa.org>, Johannes Berg <johannes.berg@intel.com>,
	Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>,
	linux-block@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Chris Zankel <chris@zankel.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	chris.obbard@collabora.com, Tejun Heo <tj@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, thehajime@gmail.com,
	YiFei Zhu <zhuyifei1999@gmail.com>
Subject: Re: [Drbd-dev] [PATCH 01/15] z2ram: add error handling support for
	add_disk()
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

On Wed, Sep 01, 2021 at 03:41:47PM +0200, Geert Uytterhoeven wrote:
> > --- a/drivers/block/z2ram.c
> > +++ b/drivers/block/z2ram.c
> > @@ -333,8 +334,10 @@ static int z2ram_register_disk(int minor)
> >                 sprintf(disk->disk_name, "z2ram");
> >
> >         z2ram_gendisk[minor] = disk;
> > -       add_disk(disk);
> > -       return 0;
> > +       err = add_disk(disk);
> > +       if (err)
> > +               blk_cleaup_disk(disk);
> 
> blk_cleanup_disk()?

Fixed thanks.

  Luis
