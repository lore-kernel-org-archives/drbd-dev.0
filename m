Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (c-134-76-76.b.dial.de.ignite.net [62.134.76.76])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2131E14368
	for <drbd-dev@lists.linbit.com>; Thu, 21 Oct 2004 15:17:27 +0200 (CEST)
Date: Thu, 21 Oct 2004 15:17:17 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] user interface test of drbd.conf
Message-ID: <WhHybcWnp6n8hv8yqruBrJk=lge@web.de>
References: <41768F97.60206@wollmersdorfer.at>
	<PYb2hAVM47FNy9iVUnme8JY=lge@web.de>
	<4177AD40.9070209@wollmersdorfer.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177AD40.9070209@wollmersdorfer.at>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-21 14:36:16 +0200
\ Helmut Wollmersdorfer:
> Lars Ellenberg wrote:
> >/ 2004-10-20 18:17:27 +0200
> >\ Helmut Wollmersdorfer:
> 
> >>wfc-timeout
> [...]
> >>100000 valid passed
> 
> >>Problem description: Very high, maybe senseless values are accepted.
> 
> >should we limit it to three days?
> 
> Seems very high for a HA-System. On the other hand maybe someone wants 
> the system to wait for a whole weekend.
> 
> 3 days = 259200 seconds. I would like an easier to remember plain value 
> like 100000, 200000 or 300000.
> 
> >I don't get the next sentence:
> 
> >>From my experience as tester I will not expect, that _any_ values will 
> >>work correctly without "dry-run".
> 
> >hm?
> 
> Very easy explanation:
> As we all know, usally numbers represented in text are converted to an 
> easier to handle representation inside a program. This can be hex, 
> decimal packed, floating etc. and mostly will be of fixed length. Even 
> bignums will have an upper limit (e.g. 64Kdigits). If there is no check 
> for a maximum value at input, funny things can happen in program logik 
> afterwards: overruns, skip to negative values, truncated values, which 
> possible could cause crazy program behaviour.

but what has that to do with dry-run?

anyways, I think all "Numbers" in the drbd.conf file end up as int,
or unsigned int. at some places we actually convert them with atoi,
which does not detect errors.
so that should be fixed to use strtol.
and where we use strtol in drbdsetup.c, actually it is m_strtol(),
we should be more paranoid about not having an ERANGE, not exceeding 
the range of the target integer type when multiplying our "unit" into
it, and probably that the unit letter, if present, actually _is_ the
last character in that integer string.

and to improve the scanner, maybe limiting to 9 digits will do?

Index: user/drbdadm_scanner.fl
===================================================================
--- user/drbdadm_scanner.fl	(revision 1609)
+++ user/drbdadm_scanner.fl	(working copy)
@@ -57,8 +57,9 @@
 COMMENT			  \#[^\n]*
 WSC			  ({WS}|{COMMENT}\n)+
 ASSIGN			  {LS}
-NUM			  [0-9]+
-NUM_U			  [0-9]+[kmgKMG]? 
+OUT_OF_RANGE_NUM	  [0-9]{10,}[kmgKMG]? 
+NUM			  [0-9]{1,9}
+NUM_U			  [0-9]{1,9}[kmgKMG]? 
 NAME			  [/_.A-Za-z0-9-]+
 STRING			  ({NAME}|\"([^\"\\\n]*|\\.)*\")+
 USTRING			  \"([^\"\\\n]*|\\.)*
@@ -115,11 +116,19 @@
 
 <NUM>{
   {NUM}			yy_pop_state(); CP; return TK_INTEGER;
+  {OUT_OF_RANGE_NUM}	{
+			  PRINTF("%s: number too big\n", yytext);
+			  exit(E_syntax);
+			}
   {NDELIM}		expect_error("integer"); yy_pop_state();
 }
 
 <NUM_U>{
   {NUM_U}		yy_pop_state(); CP; return TK_INTEGER;
+  {OUT_OF_RANGE_NUM}	{
+			  PRINTF("%s: number too big\n", yytext);
+			  exit(E_syntax);
+			}
   {NDELIM}		expect_error("[0-9]+[KMG]?"); yy_pop_state();
 }
 

> >well, we have had a bugzilla, but we did not use it.
> >and it would be very fast very heavily out of date.
> >do you want to keep it up-to-date,
> >and kick Phillip or me every now and then?
> 
> Yeah. But it needs a minimum of cooperation from developers. E.g. such 
> messages like "solved, ready for retest", "won't solve", priorities etc.

actually, we still have it, it only no longer is linked from www.drbd.org
have a look at http://bugs.drbd.org

any comments by Philipp on this?
