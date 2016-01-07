Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 47E171056439
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:32:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 416792A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:32:19 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0XQCO0rjM2I0 for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:32:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1D2FB2A5CD4
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:32:19 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id onMijr2EPQr4 for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:32:19 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id B693D2A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:32:18 +0100 (CET)
Resent-Message-ID: <20160108203218.GW28982@soda.linbit>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
	[150.101.137.141])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 07C041056312
	for <drbd-dev@lists.linbit.com>; Thu,  7 Jan 2016 04:16:49 +0100 (CET)
Date: Thu, 7 Jan 2016 14:11:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: mchristi@redhat.com
Message-ID: <20160107031131.GB32200@dastard>
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
	<1452027218-32303-14-git-send-email-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452027218-32303-14-git-send-email-mchristi@redhat.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, xfs@oss.sgi.com,
	ocfs2-devel@oss.oracle.com, linux-scsi@vger.kernel.org,
	konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
	osd-dev@open-osd.org, linux-fsdevel@vger.kernel.org,
	lars.ellenberg@linbit.com, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 13/35] xfs: set bi_op to REQ_OP
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

On Tue, Jan 05, 2016 at 02:53:16PM -0600, mchristi@redhat.com wrote:
> From: Mike Christie <mchristi@redhat.com>
> 
> This patch has xfs set the bio bi_op to a REQ_OP, and
> rq_flag_bits to bi_rw.
> 
> Note:
> I have run xfs tests on these btrfs patches. There were some failures
> with and without the patches. I have not had time to track down why
> xfstest fails without the patches.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>  fs/xfs/xfs_aops.c |  3 ++-
>  fs/xfs/xfs_buf.c  | 27 +++++++++++++++------------
>  2 files changed, 17 insertions(+), 13 deletions(-)

Not sure which patches your note is refering to here.

The XFS change here looks fine.

Acked-by: Dave Chinner <dchinner@redhat.com>

-Dave.
-- 
Dave Chinner
david@fromorbit.com
