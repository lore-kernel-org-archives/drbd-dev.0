Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CA139100EC11
	for <drbd-dev@lists.linbit.com>; Wed, 28 Oct 2015 10:17:32 +0100 (CET)
Date: Wed, 28 Oct 2015 10:17:31 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: punit vara <punitvara@gmail.com>, drbd-dev@lists.linbit.com
Message-ID: <20151028091731.GK1947@rck.sh>
References: <1445798917-18876-1-git-send-email-punitvara@gmail.com>
	<1445798917-18876-2-git-send-email-punitvara@gmail.com>
	<CABXAfNL=WkXT8m-hcay9Mii+GePugKf=OQyqUdsdLGKf489=PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXAfNL=WkXT8m-hcay9Mii+GePugKf=OQyqUdsdLGKf489=PA@mail.gmail.com>
Subject: Re: [Drbd-dev] [DRBD-user] [PATCH 1/6] block: Remove unneeded
 variable err for returning 0
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

On Wed, Oct 28, 2015 at 12:41:28AM +0530, punit vara wrote:
> On Mon, Oct 26, 2015 at 12:18 AM, Punit Vara <punitvara@gmail.com> wrote:
> > This patch is to the mg_disk.c file that removes unnecessary err
> > and fixes  following warning reported by coccicheck:
> >
> > Unneeded variable: "err". Return "0" on line 1077
> >
> > Signed-off-by: Punit Vara <punitvara@gmail.com>
> > ---
> >  drivers/block/mg_disk.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/mg_disk.c b/drivers/block/mg_disk.c
> > index 145ce2a..d6f3feb 100644
> > --- a/drivers/block/mg_disk.c
> > +++ b/drivers/block/mg_disk.c
> > @@ -1038,7 +1038,6 @@ static int mg_remove(struct platform_device *plat_dev)
> >  {
> >         struct mg_drv_data *prv_data = plat_dev->dev.platform_data;
> >         struct mg_host *host = prv_data->host;
> > -       int err = 0;
> >
> >         /* delete timer */
> >         del_timer_sync(&host->timer);
> > @@ -1074,7 +1073,7 @@ static int mg_remove(struct platform_device *plat_dev)
> >         /* free mg_host */
> >         kfree(host);
> >
> > -       return err;
> > +       return 0;
> >  }
> >
> >  static struct platform_driver mg_disk_driver = {
> > --
> > 2.5.3
> >
> Anybody going to review this patches please and I dont know who is
> maintainer for all these patches

Hi,

hm, so if it always returns the same value, why not make the function
"void" and change the call sites? The compiler optimizes it anyways,
this does not save anything.

Like the rest of your patch set, it does not really improve anything.
These style/whitespace fixes will happen anyways when someone is
actually working on the _code_...

So thank you for your input, valid points, but as long as there is a
single item on my todo-list, I - again highly personal view - don't care
about whitespace patches.

Regards, rck
