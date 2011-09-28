Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DCB6310556B9
	for <drbd-dev@lists.linbit.com>; Wed, 28 Sep 2011 11:20:17 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Kyle Moffett <kyle@moffetthome.net>
Date: Wed, 28 Sep 2011 11:20:06 +0200
References: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
	<201109271134.06410.philipp.reisner@linbit.com>
	<CAGZ=bqL=K6v+jxZOwv-=iL=MjOpoJ4JRAPLTtwdHNW_CsFc4GA@mail.gmail.com>
In-Reply-To: <CAGZ=bqL=K6v+jxZOwv-=iL=MjOpoJ4JRAPLTtwdHNW_CsFc4GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201109281120.07349.philipp.reisner@linbit.com>
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

Am Mittwoch, 28. September 2011, 06:26:45 schrieb Kyle Moffett:
> On Tue, Sep 27, 2011 at 05:34, Philipp Reisner
> 
> <philipp.reisner@linbit.com> wrote:
> > Am Freitag, 23. September 2011, 19:28:24 schrieb Kyle Moffett:
> >> On Fri, Sep 23, 2011 at 10:31, Philipp Reisner 
<philipp.reisner@linbit.com> wrote:
> >> > diff --git a/drivers/block/drbd/drbd_main.c
> >> > b/drivers/block/drbd/drbd_main.c index 3310986..99b467e 100644
> >> > --- a/drivers/block/drbd/drbd_main.c
> >> > +++ b/drivers/block/drbd/drbd_main.c
> >> > @@ -717,11 +717,11 @@ static unsigned int prepare_header80(struct
> >> > p_header80 *h, enum drbd_packet cmd, return sizeof(struct p_header80);
> >> >  }
> >> > 
> >> > -static unsigned int prepare_header95(struct p_header95 *h, enum
> >> > drbd_packet cmd, int size, int vnr) +static unsigned int
> >> > prepare_header95(struct p_header95 *h, enum drbd_packet cmd, int size)
> >> > { h->magic   = cpu_to_be16(DRBD_MAGIC_BIG);
> >> >        h->command = cpu_to_be16(cmd);
> >> > -       h->vol_n_len = cpu_to_be32(vnr << 24 | size);
> >> > +       h->length = cpu_to_be32(size);
> >> >        return sizeof(struct p_header95);
> >> >  }
> >> 
> >> This patch needs a commit message indicating why it does not break
> >> compatibility.  If you are guaranteed that the "vnr" passed into
> >> prepare_header95 is always zero, then you should indicate why that is
> >> true.
> > 
> > Here is the commit message for that one. The alternative is to merge
> > that to patch 'drbd: Use new header layout, and send volume IOs'.
> > ( Which is patch number 236, i.e. outside of this (10th) posting of
> >  DRBD-8.4 patches. It was posted on August 25.
> >  See https://lkml.org/lkml/2011/8/25/322 )
> > 
> > Author: Andreas Gruenbacher <agruen@linbit.com>
> > Date:   Tue Mar 22 13:17:47 2011 +0100
> > 
> >    drbd: Remove volume numbers from struct p_header95
> > 
> >    Remove the temporal 8 bit volume number form header 95. All
> > connections that support multiple volumes are new using protocol 100
> > with header 100.
> 
> So my concern is that this effectively ignores an old field in
> header95, so an old DRBD trying to talk about multiple volumes to a
> new DRBD using header95 is going to get its volume number ignored,
> right?
> 
> This means that old-DRBD and new-DRBD cannot communicate about
> multiple volumes over one connection at all.  That needs to be made an
> explicit part of this commit message and the rationale explained in
> detail.
> 
> In particular, you need to make sure to describe what negotiation
> mechanism prevents multiple-volume-header95 messages from being sent
> to a version of DRBD including this commit.  If that behavior (IE: a
> negotiation change) is part of another commit, then this is small
> enough that I would merge it with that other commit, but it still
> needs comments about why version interoperability will not break.
> 
> It seems to me like DRBD has historically not been terribly strict
> with backwards-compatibility to very old versions, but now that it is
> in the upstream kernel that is a very serious concern.  With an
> out-of-tree module you have a lot more control over exactly which
> version you are running, but when it's in-tree you are stuck with
> whatever your vendor's kernel version is (for the most part).  Any
> time you change or break backwards compatibility there needs to be at
> the very *least* a detailed comment indicating why it needs to be
> broken and exactly how you avoid additional complications from that.
> 

Hi,

Well, the last time we broke the on-the-wire compatibility was in January
2007, with the release of drbd-8.0.0. Since then all newer releases can
connect to drbd-8.0.0 and every release in between. (Side node: The 8.0
code was also the code we submitted for inclusion into mainline for the
first time back in 2007)

What happened here in this patch set is, that first (with patch #236)
the volume number gets introduced in the highest byte of the length
(since the bio size only needs 20 bits currently that is valid).
Later on the protocol 100 header gets implemented, and the
volume number field in header 95 is removed again.

So the header 95 with volume numbers is a temporal thing, that happened
during development. It was never in a released version.

Ok, to put an end to this discussion:
I changed patch #236 to never introduce that field into header 95.
As a consequence this patch 'drbd: Remove volume numbers from struct 
p_header95' turns into the removal of outdated comments. See the follow-up
mail.

Best,
 Phil

-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
