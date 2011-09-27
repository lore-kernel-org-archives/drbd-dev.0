Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 51DA810556C5
	for <drbd-dev@lists.linbit.com>; Tue, 27 Sep 2011 11:34:20 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Kyle Moffett <kyle@moffetthome.net>
Date: Tue, 27 Sep 2011 11:34:03 +0200
References: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
	<1316788285-17433-8-git-send-email-philipp.reisner@linbit.com>
	<CAGZ=bq+XQNGEU1HHBEMWdc-hg-B-=eoKNYobUeGrZeeSq41M_A@mail.gmail.com>
In-Reply-To: <CAGZ=bq+XQNGEU1HHBEMWdc-hg-B-=eoKNYobUeGrZeeSq41M_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201109271134.03529.philipp.reisner@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 07/10] drbd: Remove headers from on-the-wire
	data structures (struct p_*)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 23. September 2011, 19:38:15 schrieb Kyle Moffett:
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
> >  drivers/block/drbd/drbd_int.h      |   45 ----------
> >  drivers/block/drbd/drbd_main.c     |   44 +++++-----
> >  drivers/block/drbd/drbd_receiver.c |  171
> > ++++++++++++++++++------------------ drivers/block/drbd/drbd_worker.c  
> > |    2 +-
> 
> This commit is kind of borderline too-big for just a one-line commit
> message.
> 
> It is admittedly very simple (changing the same pointer math in ~50
> places), but it needs a bit more explanation about why it's helpful or
> necessary.
> 
> I *think* it's because the protocol-100 code will use a different-sized
> header, but that needs to be actually explained somewhere.
> 

I updated the patch to carry the following commit message:

Author: Andreas Gruenbacher <agruen@linbit.com>
Date:   Wed Mar 30 12:54:42 2011 +0200

    drbd: Remove headers from on-the-wire data structures (struct p_*)
    
    Prepare the introduction of the protocol 100 headers. The actual protocol
    header is removed for the packet declarations. I.e. allow us to use the
    packets with different headers.
    
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
