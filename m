Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E3C9C1056780
	for <drbd-dev@lists.linbit.com>; Tue,  9 Apr 2013 17:47:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id D80C6B0E003
	for <drbd-dev@lists.linbit.com>; Tue,  9 Apr 2013 17:47:26 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KmKI5kjFmTdj for <drbd-dev@lists.linbit.com>;
	Tue,  9 Apr 2013 17:47:26 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id BB85DB0E002
	for <drbd-dev@lists.linbit.com>; Tue,  9 Apr 2013 17:47:26 +0200 (CEST)
Resent-Message-ID: <20130409154726.GF13761@soda.linbit>
Message-ID: <51636D60.8060809@asianux.com>
Date: Tue, 09 Apr 2013 09:22:40 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com, drbd-user@lists.linbit.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5152980D.8090903@asianux.com> <515BE19F.2080709@asianux.com>
	<20130408204510.GB13761@soda.linbit>
In-Reply-To: <20130408204510.GB13761@soda.linbit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 2013年04月09日 04:45, Lars Ellenberg wrote:
> On Wed, Apr 03, 2013 at 04:00:31PM +0800, Chen Gang wrote:
>> > Hello maintainers:
>> > 
>> >   when you have time, please help to check this patch whether is OK.
>> > 
>> >   thanks.
> Thanks.
> 
> It has already been queued in:
> http://git.kernel.dk/?p=linux-block.git;a=commit;h=0b6ef4164f50698eee536903d69d086add1a7889
> 

  ok thanks.

  it seems I am a little earlier than the link's patch.
    I found it on Wed 27 Mar 2013 14:56
    link's patch found it on Wed 27 Mar 2013 21:08

  ;-)


  but that's all right, it doesn't matter.

  thanks.

  :-)

gchen.


>> > On 2013年03月27日 14:56, Chen Gang wrote:
>>> > > 
>>> > >   need remove it, or always return -EBUSY.
>>> > >   it is found by compiler with 'EXTRA_CFLAG=-W'.
>>> > > 
>>> > > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>>> > > ---
>>> > >  drivers/block/drbd/drbd_actlog.c |    2 +-
>>> > >  1 files changed, 1 insertions(+), 1 deletions(-)
>>> > > 
>>> > > diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
>>> > > index 6afe173..6608076 100644
>>> > > --- a/drivers/block/drbd/drbd_actlog.c
>>> > > +++ b/drivers/block/drbd/drbd_actlog.c
>>> > > @@ -389,7 +389,7 @@ int drbd_al_begin_io_nonblock(struct drbd_conf *mdev, struct drbd_interval *i)
>>> > >  		if (unlikely(tmp != NULL)) {
>>> > >  			struct bm_extent  *bm_ext = lc_entry(tmp, struct bm_extent, lce);
>>> > >  			if (test_bit(BME_NO_WRITES, &bm_ext->flags)) {
>>> > > -				if (!test_and_set_bit(BME_PRIORITY, &bm_ext->flags));
>>> > > +				if (!test_and_set_bit(BME_PRIORITY, &bm_ext->flags))
>>> > >  					return -EBUSY;
>>> > >  				return -EWOULDBLOCK;
>>> > >  			}
>>> > > 
> 


-- 
Chen Gang

Asianux Corporation
