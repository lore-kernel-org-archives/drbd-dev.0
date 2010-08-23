Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <jaxboe@fusionio.com>
Date: Mon, 23 Aug 2010 18:03:22 +0200
References: <20100811223845.GE645@bicker> <4C724EB5.8030807@fusionio.com>
In-Reply-To: <4C724EB5.8030807@fusionio.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201008231803.22680.philipp.reisner@linbit.com>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, Dan Carpenter <error27@gmail.com>,
	"drbd-user@lists.linbit.com" <drbd-user@lists.linbit.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [patch] drbd: cleanup: change "<= 0" to "== 0"
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 23. August 2010, um 12:34:29 schrieb Jens Axboe:
> On 2010-08-12 00:38, Dan Carpenter wrote:
> > dt is unsigned so it's never less than zero.  We are calculating the
> > elapsed time, and that's never less than zero (unless there is a bug or
> > we invent time travel).  The comparison here is just to guard against
> > divide by zero bugs.
> > 
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > 
> > diff --git a/drivers/block/drbd/drbd_proc.c
> > b/drivers/block/drbd/drbd_proc.c index be3374b..4c0c4aa 100644
> > --- a/drivers/block/drbd/drbd_proc.c
> > +++ b/drivers/block/drbd/drbd_proc.c
> > @@ -118,7 +118,7 @@ static void drbd_syncer_progress(struct drbd_conf
> > *mdev, struct seq_file *seq)
> > 
> >  	/* mean speed since syncer started
> >  	
> >  	 * we do account for PausedSync periods */
> >  	
> >  	dt = (jiffies - mdev->rs_start - mdev->rs_paused) / HZ;
> > 
> > -	if (dt <= 0)
> > +	if (dt == 0)
> > 
> >  		dt = 1;
> >  	
> >  	db = mdev->rs_total - rs_left;
> >  	dbdt = Bit2KB(db/dt);
> 
> Lars et al, I'll let you pick this up.

Jens, we (LINBIT) feel responsible for picking this up. I work on that
tomorrow.

Best,
 Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
