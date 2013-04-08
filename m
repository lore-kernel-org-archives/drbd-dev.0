Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 8 Apr 2013 22:45:10 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Chen Gang <gang.chen@asianux.com>
Message-ID: <20130408204510.GB13761@soda.linbit>
References: <5152980D.8090903@asianux.com>
 <515BE19F.2080709@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <515BE19F.2080709@asianux.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drivers/block/drbd: remove erroneous
	semicolon
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

On Wed, Apr 03, 2013 at 04:00:31PM +0800, Chen Gang wrote:
> Hello maintainers:
> 
>   when you have time, please help to check this patch whether is OK.
> 
>   thanks.

Thanks.

It has already been queued in:
http://git.kernel.dk/?p=linux-block.git;a=commit;h=0b6ef4164f50698eee536903d69d086add1a7889

> On 2013年03月27日 14:56, Chen Gang wrote:
> > 
> >   need remove it, or always return -EBUSY.
> >   it is found by compiler with 'EXTRA_CFLAG=-W'.
> > 
> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> > ---
> >  drivers/block/drbd/drbd_actlog.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
> > index 6afe173..6608076 100644
> > --- a/drivers/block/drbd/drbd_actlog.c
> > +++ b/drivers/block/drbd/drbd_actlog.c
> > @@ -389,7 +389,7 @@ int drbd_al_begin_io_nonblock(struct drbd_conf *mdev, struct drbd_interval *i)
> >  		if (unlikely(tmp != NULL)) {
> >  			struct bm_extent  *bm_ext = lc_entry(tmp, struct bm_extent, lce);
> >  			if (test_bit(BME_NO_WRITES, &bm_ext->flags)) {
> > -				if (!test_and_set_bit(BME_PRIORITY, &bm_ext->flags));
> > +				if (!test_and_set_bit(BME_PRIORITY, &bm_ext->flags))
> >  					return -EBUSY;
> >  				return -EWOULDBLOCK;
> >  			}
> > 
