Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
	(mail-bn1on0092.outbound.protection.outlook.com [157.56.110.92])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AA1121056308
	for <drbd-dev@lists.linbit.com>; Wed,  6 Jan 2016 18:31:22 +0100 (CET)
To: device-mapper development <dm-devel@redhat.com>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-ext4@vger.kernel.org>,
	<konrad.wilk@oracle.com>, <drbd-dev@lists.linbit.com>,
	<philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
	<linux-raid@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-bcache@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <target-devel@vger.kernel.org>,
	<linux-btrfs@vger.kernel.org>, <osd-dev@open-osd.org>, <xfs@oss.sgi.com>,
	<ocfs2-devel@oss.oracle.com>
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
	<1452027218-32303-2-git-send-email-mchristi@redhat.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <568D39DE.2060709@sandisk.com>
Date: Wed, 6 Jan 2016 16:59:26 +0100
MIME-Version: 1.0
In-Reply-To: <1452027218-32303-2-git-send-email-mchristi@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Christie <mchristi@redhat.com>
Subject: Re: [Drbd-dev] [dm-devel] [PATCH 01/35] block/fs/drivers: remove rw
 argument from submit_bio
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

On 01/05/2016 09:53 PM, mchristi@redhat.com wrote:
> From: Mike Christie <mchristi@redhat.com>
>
> This has callers of submit_bio/submit_bio_wait set the bio->bi_rw
> instead of passing it in. This makes that use the same as
> generic_make_request and how we set the other bio fields.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
