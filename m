Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep12-int.chello.at (viefep12-int.chello.at [213.46.255.25])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 985CF14360
	for <drbd-dev@lists.linbit.com>; Thu, 21 Oct 2004 17:56:15 +0200 (CEST)
Received: from wollmersdorfer.at ([212.186.65.148]) by viefep12-int.chello.at
	(InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
	id <20041021155614.ZOWT25452.viefep12-int.chello.at@wollmersdorfer.at>
	for <drbd-dev@lists.linbit.com>; Thu, 21 Oct 2004 17:56:14 +0200
Message-ID: <4177DC1E.70600@wollmersdorfer.at>
Date: Thu, 21 Oct 2004 17:56:14 +0200
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] user interface test of drbd.conf
References: <41768F97.60206@wollmersdorfer.at>	<PYb2hAVM47FNy9iVUnme8JY=lge@web.de>	<4177AD40.9070209@wollmersdorfer.at>
	<WhHybcWnp6n8hv8yqruBrJk=lge@web.de>
In-Reply-To: <WhHybcWnp6n8hv8yqruBrJk=lge@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars Ellenberg wrote:
> / 2004-10-21 14:36:16 +0200
> \ Helmut Wollmersdorfer:
> 
>>Lars Ellenberg wrote:
>>
>>>/ 2004-10-20 18:17:27 +0200
>>>\ Helmut Wollmersdorfer:

>>>>From my experience as tester I will not expect, that _any_ values will 
>>>>work correctly without "dry-run".

>>>hm?

>>Very easy explanation:
>>As we all know, usally numbers represented in text are converted to an 
>>easier to handle representation inside a program. This can be hex, 
>>decimal packed, floating etc. and mostly will be of fixed length. Even 
>>bignums will have an upper limit (e.g. 64Kdigits). If there is no check 
>>for a maximum value at input, funny things can happen in program logik 
>>afterwards: overruns, skip to negative values, truncated values, which 
>>possible could cause crazy program behaviour.

> but what has that to do with dry-run?

If I only test with dry-run, I only test the parser. This cannot uncover 
errors in afterwards logic.

> and to improve the scanner, maybe limiting to 9 digits will do?
[...]
> +OUT_OF_RANGE_NUM	  [0-9]{10,}[kmgKMG]? 
> +NUM			  [0-9]{1,9}
> +NUM_U			  [0-9]{1,9}[kmgKMG]?
Let's try
999999999k ~ 1 T
999999999M ~ 1000 T
999999999G ~ 1000000 T

[...]
>  <NUM>{
>    {NUM}			yy_pop_state(); CP; return TK_INTEGER;
> +  {OUT_OF_RANGE_NUM}	{
> +			  PRINTF("%s: number too big\n", yytext);
Better:
+	PRINTF("%s: number exceeds limit of 9 digits\n", yytext);


Helmut Wollmersdorfer
