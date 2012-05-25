Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3B9351012A92
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 0CD541B4315
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:03 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0UkS62J8BUCe for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 22:30:02 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id DE0681B40F5
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:30:02 +0200 (CEST)
Resent-Message-ID: <20120525203002.GB1903@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B48851019A78
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 20:48:40 +0200 (CEST)
Date: Fri, 25 May 2012 14:48:27 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Boaz Harrosh <bharrosh@panasas.com>
Message-ID: <20120525184827.GA8300@redhat.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-12-git-send-email-koverstreet@google.com>
	<4FBE6823.50904@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FBE6823.50904@panasas.com>
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	yehuda@hq.newdream.net, linux-fsdevel@vger.kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 11/14] block: Rework bio splitting
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 24, 2012 at 07:56:03PM +0300, Boaz Harrosh wrote:

[..]
> In the split you have a single bio with or without bvects allocation
> should you not let the caller make sure not to set __GFP_WAIT.
> 
> For me, inspecting current->bio_list is out of context and a complete
> hack. The caller should take care of it, which has more context.
> 
> For example I might want to use split from OSD code where I do
> not use an elevator at all, and current->bio_list could belong
> to a completely different device. (Maybe)

FWIW, I too think that checking for current->bio_list in bio_split() sounds
hackish and it should be left to caller to set right gfp flags. And it should
be commented well.

Thanks
Vivek
