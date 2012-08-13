Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A0CF8103B4C6
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 9BDE51B4361
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:07 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UZMK7AQbTS5T for <drbd-dev@lists.linbit.com>;
	Thu, 16 Aug 2012 20:17:07 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 7B0EB1B435E
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:07 +0200 (CEST)
Resent-Message-ID: <20120816181707.GD8189@soda.linbit>
Received: from mail-yx0-f182.google.com (mail-yx0-f182.google.com
	[209.85.213.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E60B41019A78
	for <drbd-dev@lists.linbit.com>; Mon, 13 Aug 2012 23:46:59 +0200 (CEST)
Received: by yenl7 with SMTP id l7so5514487yen.27
	for <drbd-dev@lists.linbit.com>; Mon, 13 Aug 2012 14:46:58 -0700 (PDT)
Date: Mon, 13 Aug 2012 14:46:54 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120813214654.GD9541@google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-13-git-send-email-koverstreet@google.com>
	<20120809173700.GB6644@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120809173700.GB6644@dhcp-172-17-108-109.mtv.corp.google.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 12/12] block: Only clone bio vecs that are
	in use
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Aug 09, 2012 at 10:37:00AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 06, 2012 at 03:08:41PM -0700, Kent Overstreet wrote:
> > bcache creates large bios internally, and then splits them according to
> > the device requirements before it sends them down. If a lower level
> > device tries to clone the bio, and the original bio had more than
> > BIO_MAX_PAGES, the clone will fail unecessarily.
> > 
> > We can fix this by only cloning the bio vecs that are actually in use.
> 
> How was this tested?

This code has been in the bcache tree for months, and I added it to fix
a real bug (think I saw it with bcache on top of dm) - and since then
it's been tested in probably just about all the relevant configurations,
certainly both dm and md.
