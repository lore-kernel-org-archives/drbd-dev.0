Return-Path: <htejun@gmail.com>
Received: from mail-gh0-f182.google.com (mail-gh0-f182.google.com
	[209.85.160.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 24047104C146
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 01:28:10 +0200 (CEST)
Received: by ghrr13 with SMTP id r13so2130341ghr.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 16:28:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 8 Aug 2012 16:28:04 -0700
From: Tejun Heo <tj@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID: <20120808232804.GL6983@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-13-git-send-email-koverstreet@google.com>
	<Pine.LNX.4.64.1208061913500.21956@file.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1208061913500.21956@file.rdu.redhat.com>
Cc: axboe@kernel.dk, Kent Overstreet <koverstreet@google.com>,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>, agk@redhat.com,
	sage@newdream.net, yehuda@hq.newdream.net, vgoyal@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v5 12/12] block: Only clone bio
 vecs that are in use
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Aug 06, 2012 at 07:16:33PM -0400, Mikulas Patocka wrote:
> Hi Kent
> 
> When you change the semantics of an exported function, rename that 
> function. There may be external modules that use __bio_clone and this 
> change could silently introduce bugs in them.
> 
> Otherwise, the patchset looks fine.

I don't know.  This doesn't change the main functionality and should
be transparent unless the caller is doing something crazy.  It *might*
be nice to rename but I don't think that's a must here.

Thanks.

-- 
tejun
