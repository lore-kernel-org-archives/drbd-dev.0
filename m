Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-055-235.arcor-ip.net
	[145.254.55.235])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 7B2061436B
	for <drbd-dev@lists.linbit.com>; Thu, 21 Oct 2004 19:22:25 +0200 (CEST)
Date: Thu, 21 Oct 2004 19:03:33 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] user interface test of drbd.conf
Message-ID: <x/QbWvt8wEANp1z3TadTCK0=lge@web.de>
References: <41768F97.60206@wollmersdorfer.at>
	<PYb2hAVM47FNy9iVUnme8JY=lge@web.de>
	<4177AD40.9070209@wollmersdorfer.at>
	<WhHybcWnp6n8hv8yqruBrJk=lge@web.de>
	<4177DC1E.70600@wollmersdorfer.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177DC1E.70600@wollmersdorfer.at>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-21 17:56:14 +0200
\ Helmut Wollmersdorfer:
> >>>>From my experience as tester I will not expect, that _any_ values will 
> >>>>work correctly without "dry-run".
> 
> >>>hm?

> If I only test with dry-run, I only test the parser. This cannot uncover 
> errors in afterwards logic.
> 
> >and to improve the scanner, maybe limiting to 9 digits will do?
> [...]
> >+OUT_OF_RANGE_NUM	  [0-9]{10,}[kmgKMG]? 
> >+NUM			  [0-9]{1,9}
> >+NUM_U			  [0-9]{1,9}[kmgKMG]?
> Let's try
> 999999999k ~ 1 T
> 999999999M ~ 1000 T
> 999999999G ~ 1000000 T

well, of course there should be additional range_checks
in drbdadm_parser.y

but 9 digits do fit very well into a 32bit integer.
(the default return type of strtol on a 32bit arch).
then the overflow conditions need to be checked before
using the unit multiplier, as mentioned previously.

> [...]
> > <NUM>{
> >   {NUM}			yy_pop_state(); CP; return TK_INTEGER;
> >+  {OUT_OF_RANGE_NUM}	{
> >+			  PRINTF("%s: number too big\n", yytext);
> Better:
> +	PRINTF("%s: number exceeds limit of 9 digits\n", yytext);

yeah, whatever :)

I'm going to make up a decent patch somewhen this weekend, I guess.
though I'll be distracted by some major family meeting ...

	lge
