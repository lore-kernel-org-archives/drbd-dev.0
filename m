Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4AC30105646A
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:47:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3E5CA2AE03B
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:47:26 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3ZNLLnM5eZ2Z for <drbd-dev@lists.linbit.com>;
	Mon,  3 Oct 2016 16:47:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 06B1247E279
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:47:26 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y-0N1nlR_gSi for <drbd-dev@lists.linbit.com>;
	Mon,  3 Oct 2016 16:47:25 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id B44A22AE03B
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:47:25 +0200 (CEST)
Resent-Message-ID: <20161003144724.GJ3302@soda.linbit>
Received: from smtprelay.hostedemail.com (smtprelay0121.hostedemail.com
	[216.40.44.121])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 69528105646B
	for <drbd-dev@lists.linbit.com>; Sat,  1 Oct 2016 22:27:16 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
	[10.5.19.251])
	by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 4442A172964
	for <drbd-dev@lists.linbit.com>; Sat,  1 Oct 2016 20:20:01 +0000 (UTC)
Message-ID: <1475353194.1996.3.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>, linux-metag@vger.kernel.org
Date: Sat, 01 Oct 2016 13:19:54 -0700
In-Reply-To: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-mtd@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	drbd-dev@lists.linbit.com
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

On Sat, 2016-10-01 at 21:46 +0200, Julia Lawall wrote:
> These patches fix cases where the documentation above a function definition
> is not consistent with the function header.  Issues are detected using the
> semantic patch below (http://coccinelle.lip6.fr/).  Basically, the semantic
> patch parses a file to find comments, then matches each function header,
> and checks that the name and parameter list in the function header are
> compatible with the comment that preceeds it most closely.

Hi Julia.

Would it be possible for a semantic patch to scan for
function definitions where the types do not have
identifiers and update the definitions to match the
declarations?

For instance, given:

<some.h>
int foo(int);

<some.c>
int foo(int bar)
{
	return baz;
}

Could coccinelle output:

diff a/some.h b/some.h
[]
-int foo(int);
+int foo(int bar);
