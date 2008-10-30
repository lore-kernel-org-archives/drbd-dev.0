Return-Path: <philipp.reisner@linbit.com>
Received: from fat-tyre.localnet (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 7440D2E03728
	for <drbd-dev@lists.linbit.com>; Thu, 30 Oct 2008 12:23:21 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 8.2.6 Peer disk state handling issue when attaching
Date: Thu, 30 Oct 2008 12:23:20 +0100
References: <DA0E7D869C862D4095C265233CD1D41EC30F85@EXNA.corp.stratus.com>
	<DA0E7D869C862D4095C265233CD1D41E0E3F55@EXNA.corp.stratus.com>
In-Reply-To: <DA0E7D869C862D4095C265233CD1D41E0E3F55@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810301223.20773.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag 15 September 2008 20:26:15 schrieb Petrakis, Peter:
> Hi All,
>
> We've evolved the original patch to the following, which seems to solve
> our problem. Can you see anything wrong with it? Thanks.
>
> diff -r f9aa469f7044 drbd_main.c
> --- a/drbd_main.c       Fri Sep 12 13:51:40 2008 -0400
> +++ b/drbd_main.c       Mon Sep 15 10:04:48 2008 -0400
> @@ -765,7 +765,7 @@
>                 ns.conn = Connected;
>         }
>
> -       if (ns.conn != os.conn && ns.conn >= Connected &&
> +       if (ns.conn >= Connected &&
>             (ns.disk == Consistent || ns.disk == Outdated)) {
>                 switch(ns.conn) {
>                 case WFBitMapT:
> @@ -787,7 +787,7 @@
>                         WARN("Implicit set disk from Outdate to
> UpToDate\n");
>         }
>
> -       if (ns.conn != os.conn && ns.conn >= Connected &&
> +       if (ns.conn >= Connected &&
>             (ns.pdsk == Consistent || ns.pdsk == Outdated)) {
>                 switch(ns.conn) {
>                 case Connected:
>
>

Hi Peter,

There is nothing wrong with that patch. It is just my failure to follow
drbd-dev for the last month...

I have committed now nearly that code change upstream. You will
find it there soon as 00f2ce70e0daaa72775b3712863fb29ee99581f3
(in drbd-8.0) and from there it will be propagated to 8.2 of 
course.

-phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.

