Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
	[209.85.217.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7CE93420603
	for <drbd-dev@lists.linbit.com>; Wed,  1 Sep 2021 15:41:59 +0200 (CEST)
Received: by mail-vs1-f52.google.com with SMTP id l9so2441841vsb.8
	for <drbd-dev@lists.linbit.com>; Wed, 01 Sep 2021 06:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210830221000.179369-1-mcgrof@kernel.org>
	<20210830221000.179369-2-mcgrof@kernel.org>
In-Reply-To: <20210830221000.179369-2-mcgrof@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Sep 2021 15:41:47 +0200
Message-ID: <CAMuHMdUUrp-ktVmOPRs7KinykrVKEMx-dG42RapPc-egxODNnQ@mail.gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Luis,

On Tue, Aug 31, 2021 at 12:10 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling. Only the disk is cleaned up inside
> z2ram_register_disk() as the caller deals with the rest.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks for your patch!

> --- a/drivers/block/z2ram.c
> +++ b/drivers/block/z2ram.c
> @@ -318,6 +318,7 @@ static const struct blk_mq_ops z2_mq_ops = {
>  static int z2ram_register_disk(int minor)
>  {
>         struct gendisk *disk;
> +       int err;
>
>         disk = blk_mq_alloc_disk(&tag_set, NULL);
>         if (IS_ERR(disk))
> @@ -333,8 +334,10 @@ static int z2ram_register_disk(int minor)
>                 sprintf(disk->disk_name, "z2ram");
>
>         z2ram_gendisk[minor] = disk;
> -       add_disk(disk);
> -       return 0;
> +       err = add_disk(disk);
> +       if (err)
> +               blk_cleaup_disk(disk);

blk_cleanup_disk()?

Seems like lkp already detected this back in July...

> +       return err;
>  }
>
>  static int __init z2_init(void)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
