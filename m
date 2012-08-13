Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2ADBA1013804
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 251971B4361
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:07 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tcm3m8vom9mo for <drbd-dev@lists.linbit.com>;
	Thu, 16 Aug 2012 20:17:07 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id F3B8F1B435E
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:06 +0200 (CEST)
Resent-Message-ID: <20120816181706.GC8189@soda.linbit>
Received: from mail-gh0-f182.google.com (mail-gh0-f182.google.com
	[209.85.160.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7AD951013803
	for <drbd-dev@lists.linbit.com>; Mon, 13 Aug 2012 23:44:51 +0200 (CEST)
Received: by ghrr13 with SMTP id r13so5263250ghr.27
	for <drbd-dev@lists.linbit.com>; Mon, 13 Aug 2012 14:44:50 -0700 (PDT)
Date: Mon, 13 Aug 2012 14:44:46 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Joseph Glanville <joseph.glanville@orionvm.com.au>
Message-ID: <20120813214446.GC9541@google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-3-git-send-email-koverstreet@google.com>
	<20120808220612.GA6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120808235731.GA7262@moria.home.lan>
	<CAOzFzEhPW5-edb6mnL2gNbb4956u2MbWqQovv01010PyBCbc+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzFzEhPW5-edb6mnL2gNbb4956u2MbWqQovv01010PyBCbc+g@mail.gmail.com>
Cc: axboe@kernel.dk, snitzer@redhat.com, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	Tejun Heo <tj@kernel.org>, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 02/12] dm: Use bioset's front_pad for
 dm_rq_clone_bio_info
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Aug 11, 2012 at 03:24:45PM +1000, Joseph Glanville wrote:
> Hi Kent, Tejun
> 
> On 9 August 2012 09:57, Kent Overstreet <koverstreet@google.com> wrote:
> >> Also, how was this tested?
> >
> > Well, AFAICT the only request based dm target is multipath, and from the
> > documentation I've seen it doesn't appear to work without multipath
> > hardware, or at least I haven't seen it documented how. So, unless
> > there's another user I missed it's not been tested.
> 
> Multipath can be tested quite easily with a loopback scsi target, you
> don't require specialized hardware.
> The easiest way to do this would probably be the built in LIO target +
> open_iscsi initiator.
> 
> I haven't attempted running this current version of the patch series
> but I haven't run into issues with bcache+multipath in the past.

Actually, I bet you have been running this code - do you think you could
check the git log for the version you're running? That'd be awesome if
you are.
