Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E3B011056312
	for <drbd-dev@lists.linbit.com>; Thu,  7 Jan 2016 00:17:43 +0100 (CET)
To: mchristi@redhat.com
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
	<1452027218-32303-3-git-send-email-mchristi@redhat.com>
Date: Wed, 06 Jan 2016 18:17:01 -0500
In-Reply-To: <1452027218-32303-3-git-send-email-mchristi@redhat.com>
	(mchristi@redhat.com's message of "Tue, 5 Jan 2016 14:53:05 -0600")
Message-ID: <yq1d1tei9hu.fsf@sermon.lab.mkp.net>
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
Subject: Re: [Drbd-dev] [PATCH 02/35] block: add REQ_OP definitions and
	bi_op/op fields
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

+enum req_op {
+	REQ_OP_READ,
+	REQ_OP_WRITE		= REQ_WRITE,
+	REQ_OP_DISCARD		= REQ_DISCARD,
+	REQ_OP_WRITE_SAME	= REQ_WRITE_SAME,
+};
+

I have been irked by the REQ_ prefix in bios since the flags were
consolidated a while back. When I attempted to fix the READ/WRITE mess I
used a BLK_ prefix as a result.

Anyway. Just bikeshedding...

-- 
Martin K. Petersen	Oracle Linux Engineering
