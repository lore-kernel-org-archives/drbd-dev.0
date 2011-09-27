Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CC27310556C5
	for <drbd-dev@lists.linbit.com>; Tue, 27 Sep 2011 11:34:17 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Kyle Moffett <kyle@moffetthome.net>
Date: Tue, 27 Sep 2011 11:34:06 +0200
References: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
	<1316788285-17433-10-git-send-email-philipp.reisner@linbit.com>
	<CAGZ=bq+Ef+wy8E9taBv=vZfTdvC_VBFFD=GzNqR9Em46U-wMmg@mail.gmail.com>
In-Reply-To: <CAGZ=bq+Ef+wy8E9taBv=vZfTdvC_VBFFD=GzNqR9Em46U-wMmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201109271134.06410.philipp.reisner@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 09/10] drbd: Remove volume numbers from
	struct p_header95
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 23. September 2011, 19:28:24 schrieb Kyle Moffett:
> Hi!
> 
> On Fri, Sep 23, 2011 at 10:31, Philipp Reisner
> 
> <philipp.reisner@linbit.com> wrote:
> > From: Andreas Gruenbacher <agruen@linbit.com>
> > 
> > Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> > Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> > ---
> 
> [...snip...]
> 
> > diff --git a/drivers/block/drbd/drbd_main.c
> > b/drivers/block/drbd/drbd_main.c index 3310986..99b467e 100644
> > --- a/drivers/block/drbd/drbd_main.c
> > +++ b/drivers/block/drbd/drbd_main.c
> > @@ -717,11 +717,11 @@ static unsigned int prepare_header80(struct
> > p_header80 *h, enum drbd_packet cmd, return sizeof(struct p_header80);
> >  }
> > 
> > -static unsigned int prepare_header95(struct p_header95 *h, enum
> > drbd_packet cmd, int size, int vnr) +static unsigned int
> > prepare_header95(struct p_header95 *h, enum drbd_packet cmd, int size) {
> >        h->magic   = cpu_to_be16(DRBD_MAGIC_BIG);
> >        h->command = cpu_to_be16(cmd);
> > -       h->vol_n_len = cpu_to_be32(vnr << 24 | size);
> > +       h->length = cpu_to_be32(size);
> >        return sizeof(struct p_header95);
> >  }
> 
> This patch needs a commit message indicating why it does not break
> compatibility.  If you are guaranteed that the "vnr" passed into
> prepare_header95 is always zero, then you should indicate why that is
> true.
> 

Here is the commit message for that one. The alternative is to merge
that to patch 'drbd: Use new header layout, and send volume IOs'.
( Which is patch number 236, i.e. outside of this (10th) posting of
  DRBD-8.4 patches. It was posted on August 25.
  See https://lkml.org/lkml/2011/8/25/322 )

Author: Andreas Gruenbacher <agruen@linbit.com>
Date:   Tue Mar 22 13:17:47 2011 +0100

    drbd: Remove volume numbers from struct p_header95
    
    Remove the temporal 8 bit volume number form header 95. All connections
    that support multiple volumes are new using protocol 100 with header 100.
    
    Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
    Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

Best,
 Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
