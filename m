Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3F22610003FD
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 364481B4313
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:59 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s4IfIqt6S1gg for <drbd-dev@lists.linbit.com>;
	Thu, 24 May 2012 18:15:59 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 090E71B4312
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:59 +0200 (CEST)
Resent-Message-ID: <20120524161558.GU5734@soda.linbit>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
	(using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A7EA0106DCE1
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 03:23:34 +0200 (CEST)
Message-ID: <1337822611.4279.3.camel@joe2Laptop>
From: Joe Perches <joe@perches.com>
To: Kent Overstreet <koverstreet@google.com>
Date: Wed, 23 May 2012 18:23:31 -0700
In-Reply-To: <20120524011654.GA28662@dhcp-172-18-216-138.mtv.corp.google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-13-git-send-email-koverstreet@google.com>
	<1337820443.1747.24.camel@joe2Laptop>
	<20120524011654.GA28662@dhcp-172-18-216-138.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 12/14] Closures
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, 2012-05-23 at 21:16 -0400, Kent Overstreet wrote:
> > or maybe just bundle all this in a single seq_printf
> Do you mean something like this?
> seq_printf(f, "%s%s%s%s%s\n",
> 	   r & CLOSURE_RUNNING	? "R" : "",
> 	   r & CLOSURE_BLOCKING ? "B" : "");

Yes.

> Or do you have a better way of writing that in mind?

No.

cheers, Joe

