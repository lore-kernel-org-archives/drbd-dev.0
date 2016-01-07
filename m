Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BE4121056312
	for <drbd-dev@lists.linbit.com>; Thu,  7 Jan 2016 02:40:49 +0100 (CET)
To: mchristi@redhat.com
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
Date: Wed, 06 Jan 2016 20:40:09 -0500
In-Reply-To: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
	(mchristi@redhat.com's message of "Tue, 5 Jan 2016 14:53:03 -0600")
Message-ID: <yq14meqi2va.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, xfs@oss.sgi.com,
	ocfs2-devel@oss.oracle.com, linux-scsi@vger.kernel.org,
	konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
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

>>>>> "Mike" == mchristi  <mchristi@redhat.com> writes:

Mike> The following patches begin to cleanup the request->cmd_flags and
bio-> bi_rw mess. We currently use cmd_flags to specify the operation,
Mike> attributes and state of the request. For bi_rw we use it for
Mike> similar info and also the priority but then also have another
Mike> bi_flags field for state. At some point, we abused them so much we
Mike> just made cmd_flags 64 bits, so we could add more.

Mike> The following patches seperate the operation (read, write discard,
Mike> flush, etc) from cmd_flags/bi_rw.

Mike> This patchset was made against linux-next from today Jan 5 2016.
Mike> (git tag next-20160105).

Very nice work. Thanks for doing this!

I think it's a much needed cleanup. I focused mainly on the core block,
discard, write same and sd.c pieces and everything looks sensible to me.

I wonder what the best approach is to move a patch set with this many
stakeholders forward? Set a "speak now or forever hold your peace"
review deadline?

-- 
Martin K. Petersen	Oracle Linux Engineering
