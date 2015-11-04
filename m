Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0AF041056192
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id F1CB52A24E3
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:33 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id apAC4cWRxSAD for <drbd-dev@lists.linbit.com>;
	Wed,  4 Nov 2015 18:09:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B3B4E2A253E
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:33 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VroR12vYq-jv for <drbd-dev@lists.linbit.com>;
	Wed,  4 Nov 2015 18:09:33 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 885C02A24E3
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 18:09:33 +0100 (CET)
Resent-Message-ID: <20151104170933.GN14472@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 10CD210518AB
	for <drbd-dev@lists.linbit.com>; Wed,  4 Nov 2015 17:33:33 +0100 (CET)
From: mchristi@redhat.com
To: linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Date: Wed,  4 Nov 2015 10:32:55 -0600
Message-Id: <1446654807-6935-1-git-send-email-mchristi@redhat.com>
Subject: [Drbd-dev] [RFC PATCH 00/32] separate operations from flags in the
	bio/request structs
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

There are a couple new block layer commands we are trying to add support
for in the near term:

compare and write
http://www.spinics.net/lists/target-devel/msg07826.html

copy offload/extended copy/xcopy
https://www.redhat.com/archives/dm-devel/2014-July/msg00070.html

The problem is if we contine to add more commands we will have to one day
extend the cmd_flags/bi_rw fields again. To prevent that, this patchset
separates the operation (REQ_WRITE, REQ_DISCARD, REQ_WRITE_SAME, etc) from
the flags (REQ_SYNC, REQ_QUIET, etc) in the bio and request structs. In the
end of this set, we will have two fields bio->bi_op/request->op and
bio->bi_rw/request->cmd_flags.

The patches were made against Jens's linux-block tree's for-linus branch:
https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git/log/?h=for-linus
(last commit a22c4d7e34402ccdf3414f64c50365436eba7b93).

I have done some basic testing for a lot of the drivers and filesystems,
but I wanted to get comments before trying to track down more hardware/
systems for testing.


Known issues:
- REQ_FLUSH is still a flag, but should probably be a operation.
 For lower level drivers like SCSI where we only get a flush, it makes
more sense to be a operation. However, upper layers like filesystems
can send down flushes with writes, so it is more of a flag for them.
I am still working on this.

- There is a regression with the dm flakey target. It currently
cannot corrupt the operation values.

- The patchset is a little awkward. It touches so much code,
but I wanted to maintain git bisectibility, so there is lots of compat code
left around until the last patches where everyting is cleaned up.


