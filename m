Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2B03E105643A
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:32:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 249192A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:32:20 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id gr3mzSb3L7Dn for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:32:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 081A22A5CD4
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:32:20 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fIUi6_CuAMD2 for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 21:32:19 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id D2D472A5C46
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:32:19 +0100 (CET)
Resent-Message-ID: <20160108203219.GX28982@soda.linbit>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
	[150.101.137.141])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6D6051056312
	for <drbd-dev@lists.linbit.com>; Thu,  7 Jan 2016 04:19:11 +0100 (CET)
Date: Thu, 7 Jan 2016 14:13:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <20160107031341.GC32200@dastard>
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
	<yq14meqi2va.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq14meqi2va.fsf@sermon.lab.mkp.net>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, xfs@oss.sgi.com,
	target-devel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
	linux-scsi@vger.kernel.org, konrad.wilk@oracle.com,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	mchristi@redhat.com, linux-mtd@lists.infradead.org,
	osd-dev@open-osd.org, linux-fsdevel@vger.kernel.org,
	lars.ellenberg@linbit.com, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/35 v2] separate operations from flags in
 the bio/request structs
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

On Wed, Jan 06, 2016 at 08:40:09PM -0500, Martin K. Petersen wrote:
> >>>>> "Mike" == mchristi  <mchristi@redhat.com> writes:
> 
> Mike> The following patches begin to cleanup the request->cmd_flags and
> bio-> bi_rw mess. We currently use cmd_flags to specify the operation,
> Mike> attributes and state of the request. For bi_rw we use it for
> Mike> similar info and also the priority but then also have another
> Mike> bi_flags field for state. At some point, we abused them so much we
> Mike> just made cmd_flags 64 bits, so we could add more.
> 
> Mike> The following patches seperate the operation (read, write discard,
> Mike> flush, etc) from cmd_flags/bi_rw.
> 
> Mike> This patchset was made against linux-next from today Jan 5 2016.
> Mike> (git tag next-20160105).
> 
> Very nice work. Thanks for doing this!
> 
> I think it's a much needed cleanup. I focused mainly on the core block,
> discard, write same and sd.c pieces and everything looks sensible to me.
> 
> I wonder what the best approach is to move a patch set with this many
> stakeholders forward? Set a "speak now or forever hold your peace"
> review deadline?

I say just ask Linus to pull it immediately after the next merge
window closes....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
