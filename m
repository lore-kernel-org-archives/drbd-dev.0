Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 18E6410003DD
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id D7C3F1B435E
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:12 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tEdUxaXdSGB8 for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:41:12 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 7DA971B435D
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:12 +0200 (CEST)
Resent-Message-ID: <20120530084112.GV4141@soda.linbit>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6C3581019A78
	for <drbd-dev@lists.linbit.com>; Tue, 29 May 2012 05:34:40 +0200 (CEST)
Received: by dadv36 with SMTP id v36so6051652dad.27
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 20:34:38 -0700 (PDT)
Date: Mon, 28 May 2012 23:34:34 -0400
From: Kent Overstreet <koverstreet@google.com>
To: Dave Chinner <david@fromorbit.com>
Message-ID: <20120529033434.GC10175@dhcp-172-18-216-138.mtv.corp.google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-15-git-send-email-koverstreet@google.com>
	<20120525204651.GA24246@redhat.com>
	<20120525210944.GB14196@google.com> <20120529015438.GZ5091@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120529015438.GZ5091@dastard>
Cc: axboe@kernel.dk, Mike Snitzer <snitzer@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, tytso@google.com,
	mpatocka@redhat.com, agk@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, yehuda@hq.newdream.net,
	drbd-dev@lists.linbit.com, vgoyal@redhat.com, sage@newdream.net
Subject: Re: [Drbd-dev] [PATCH v3 14/16] Gut bio_add_page()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, May 29, 2012 at 11:54:38AM +1000, Dave Chinner wrote:
> It also allowed us to build IOs that span
> entire RAID stripe widths, thereby avoiding potential RAID RMW
> cycles, and even allowing high end raid controllers to trigger BBWC
> bypass fast paths that could double or triple the write throughput
> of the arrays...

merge_bvec_fn has nothing to do with that though, since for one there
aren't any merge_bvec_fn's being called in the IO paths on these high
end disk arrays, and for our software raid implementations their
merge_bvec_fns will keep you from sending them bios that span entire
stripes.
