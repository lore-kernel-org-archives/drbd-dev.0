Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 42AB1105647D
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:47:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3C9202AE03B
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:47:30 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id HHwaiLM4MpB4 for <drbd-dev@lists.linbit.com>;
	Mon,  3 Oct 2016 16:47:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1ED1C47E271
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:47:30 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aoDwHVqBMVWx for <drbd-dev@lists.linbit.com>;
	Mon,  3 Oct 2016 16:47:30 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id EDFAF2AE03B
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:47:29 +0200 (CEST)
Resent-Message-ID: <20161003144729.GK3302@soda.linbit>
Received: from mail2-relais-roc.national.inria.fr
	(mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 133ED105646B
	for <drbd-dev@lists.linbit.com>; Sat,  1 Oct 2016 22:39:17 +0200 (CEST)
Date: Sat, 1 Oct 2016 22:39:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Joe Perches <joe@perches.com>
In-Reply-To: <1475353194.1996.3.camel@perches.com>
Message-ID: <alpine.DEB.2.10.1610012232350.3445@hadrien>
References: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
	<1475353194.1996.3.camel@perches.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-clk@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-media@vger.kernel.org, linux-metag@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/15] improve function-level documentation
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



On Sat, 1 Oct 2016, Joe Perches wrote:

> On Sat, 2016-10-01 at 21:46 +0200, Julia Lawall wrote:
> > These patches fix cases where the documentation above a function definition
> > is not consistent with the function header.  Issues are detected using the
> > semantic patch below (http://coccinelle.lip6.fr/).  Basically, the semantic
> > patch parses a file to find comments, then matches each function header,
> > and checks that the name and parameter list in the function header are
> > compatible with the comment that preceeds it most closely.
>
> Hi Julia.
>
> Would it be possible for a semantic patch to scan for
> function definitions where the types do not have
> identifiers and update the definitions to match the
> declarations?
>
> For instance, given:
>
> <some.h>
> int foo(int);
>
> <some.c>
> int foo(int bar)
> {
> 	return baz;
> }
>
> Could coccinelle output:
>
> diff a/some.h b/some.h
> []
> -int foo(int);
> +int foo(int bar);

The following seems to work:

@r@
identifier f;
position p;
type T, t;
parameter list[n] ps;
@@

T f@p(ps,t,...);

@s@
identifier r.f,x;
type r.T, r.t;
parameter list[r.n] ps;
@@

T f(ps,t x,...) { ... }

@@
identifier r.f, s.x;
position r.p;
type r.T, r.t;
parameter list[r.n] ps;
@@

T f@p(ps,t
+ x
  ,...);

After letting it run for a few minutes without making any effort to
include .h files, I get over 2700 changed lines.

julia
