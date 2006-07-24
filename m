Return-Path: <milind.dumbare@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B9C5C2DF627B
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jul 2006 17:05:45 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id i30so694762wra
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jul 2006 08:05:44 -0700 (PDT)
Message-ID: <44C4E271.3080607@gmail.com>
Date: Mon, 24 Jul 2006 20:38:33 +0530
From: Milind Dumbare <milind.dumbare@gmail.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] Bug?
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,
First of all to tell I am working on x86_64 machine.

The structure ioctl_get_config has size 576(bytes) and its padded with
int (4byte) so it makes 580 (bytes). And compiler will align it to 584
(bytes), as 580 is not completely divisible by 8 while 584 is.

So don't you think drbd_sizeof_sanity_check.c:21 should be

        SZO(struct ioctl_get_config,    576)
rather than
        SZO(struct ioctl_get_config,    580)

after removing padding. It will also be alligned on 32 bit compilers.

-Thanks
-Milind

