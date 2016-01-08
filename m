Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A1BBB1056312
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 22:03:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 68BD72A6416
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 22:03:20 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id e_mob_1WkLFM for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 22:03:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4B21E2A6434
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 22:03:20 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RLJ_mvYhB2bR for <drbd-dev@lists.linbit.com>;
	Fri,  8 Jan 2016 22:03:20 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 2118A2A6416
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 22:03:20 +0100 (CET)
Resent-Message-ID: <20160108210319.GA28982@soda.linbit>
Received: from sabe.cs.wisc.edu (sabe.cs.wisc.edu [128.105.6.20])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3DBA41056431
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jan 2016 21:59:53 +0100 (CET)
Message-ID: <56902132.8080008@cs.wisc.edu>
Date: Fri, 08 Jan 2016 14:50:58 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, mchristi@redhat.com
References: <1452027218-32303-1-git-send-email-mchristi@redhat.com>
	<20160108133237.GA7663@infradead.org>
In-Reply-To: <20160108133237.GA7663@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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

On 01/08/2016 07:32 AM, Christoph Hellwig wrote:
> This looks good to me from a highlevel point of view.
> Do you also have a git tree to take a look at all the changes in a
> single big diff?

I uploaded a git tree here:

https://github.com/mikechristie/linux-kernel.git

based off of linux-next today. The patches are just in the master branch.
