Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 87DEC14314
	for <drbd-dev@lists.linbit.com>; Fri, 24 Sep 2004 14:07:53 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] r1559 - in branches/drbd-0.7: drbd user
Date: Fri, 24 Sep 2004 14:08:14 +0200
References: <20040924111354.399A13BE6E@garcon.linbit.com>
	<FzrmeyosCK+tKKTx6KNpxh8=lge@web.de>
In-Reply-To: <FzrmeyosCK+tKKTx6KNpxh8=lge@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409241408.14509.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Friday 24 September 2004 13:40, Lars Ellenberg wrote:
> [ bitte reply-to in drbd-cvs auf drbd-dev setzen ]
>

ack. done.

> > -#define DRBD_MAX_SECTORS \
> > +#if ( !defined(CONFIG_LBD) ) && ( BITS_PER_LONG == 32 )
> > +# define DRBD_MAX_SECTORS (0xffffffffLU)
> > +#else
> > +# define DRBD_MAX_SECTORS \
> >            ( (MD_RESERVED_SIZE*2LL - MD_BM_OFFSET) *
> > (1LL<<(BM_EXT_SIZE_B-9)) ) +#endif
>
> oh well...
> why not simple (sector_t) ?
> just because it is then 0xffdc0000 instead of 0xffffffff ?
> so what ...

I did not know that it would be 0xffdc0000, I did not do the
math... , OTOH it is made it explicit.

-philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
