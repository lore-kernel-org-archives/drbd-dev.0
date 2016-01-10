Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1BA921056314
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D681A360050
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:29 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id V7WXI6D97wTJ for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B555A36482E
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:29 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id T0DQMoOqg0hB for <drbd-dev@lists.linbit.com>;
	Tue, 12 Jan 2016 11:09:29 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 8FB55364792
	for <drbd-dev@lists.linbit.com>; Tue, 12 Jan 2016 11:09:29 +0100 (CET)
Resent-Message-ID: <20160112100929.GC3313@soda.linbit>
Received: from sabe.cs.wisc.edu (sabe.cs.wisc.edu [128.105.6.20])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 433B01056308
	for <drbd-dev@lists.linbit.com>; Sun, 10 Jan 2016 02:21:51 +0100 (CET)
Message-ID: <5691B208.9060001@cs.wisc.edu>
Date: Sat, 09 Jan 2016 19:21:12 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
MIME-Version: 1.0
To: device-mapper development <dm-devel@redhat.com>, mchristi@redhat.com
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
	<1452027218-32303-3-git-send-email-mchristi@redhat.com>
	<20160109133716.GB26660@infradead.org>
	<5691AC2E.2050403@cs.wisc.edu>
In-Reply-To: <5691AC2E.2050403@cs.wisc.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-raid@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-scsi@vger.kernel.org, konrad.wilk@oracle.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	xfs@oss.sgi.com, linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org, target-devel@vger.kernel.org,
	linux-mtd@lists.infradead.org, osd-dev@open-osd.org,
	linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com,
	ocfs2-devel@oss.oracle.com, linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [dm-devel] [PATCH 02/35] block: add REQ_OP
 definitions and bi_op/op fields
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

On 01/09/2016 06:56 PM, Mike Christie wrote:
> On 01/09/2016 07:37 AM, Christoph Hellwig wrote:
>> Seems like this is missing REQ_OP_FLUSH, which still hides as a write?
>>

Oh yeah, to answer the second part of your question, REQ_OP_FLUSH is
only a flush operation like what request_fn drivers wanted.

REQ_PREFLUSH can be set with a REQ_OP_WRITE bio when filesystems want to
do both.

There is then the case where filesystems and blkdev_issue_flush could
just want to request a flush. I left them as a REQ_PREFLUSH with
REQ_OP_WRITE set, so there would be a single code path.

> 
> I might have misunderstood what you wanted or am misunderstanding you now.
> 
> I did not change the flush related code until the last patches. I added
> REQ_OP_FLUSH in patch:
> 
> [PATCH 33/35] block, drivers: add REQ_OP_FLUSH operation
> commit 18dea20363ba245a47bc1bb54f6465b8a05b19af
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Tue Jan 5 21:02:17 2016 -0600
> 
>     block, drivers: add REQ_OP_FLUSH operation
> 
> 
> and I added the REQ_PREFLUSH flag in
> 
> 
> [PATCH 35/35] block, drivers, fs: rename REQ_FLUSH to REQ_PREFLUSH
> commit 303dc6a7cc3673065538ba041562fcd833a619af
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Thu Jan 7 18:17:03 2016 -0600
> 
>     block, drivers, fs: rename REQ_FLUSH to REQ_PREFLUSH
> 
> 
> I did them in separate patches, because I was not sure if they were
> correct with what you requested before, and because they were a little
> more tricky because of how request_fn drivers, make_request_fn drivers,
> and dm-multipath handle flushes differently.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

