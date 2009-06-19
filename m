Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 138D610735BC
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 17:54:42 +0200 (CEST)
Resent-Message-ID: <20090619155441.GE9526@soda.linbit>
Received: from master.grad.hr (master.grad.hr [161.53.50.3])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4DBCD101380C
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 16:49:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by master.grad.hr (Postfix) with ESMTP id 57B9B494234
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 16:39:12 +0200 (CEST)
Received: from master.grad.hr ([127.0.0.1])
	by localhost (master.grad.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkhUq9LcmCnk for <drbd-dev@lists.linbit.com>;
	Fri, 19 Jun 2009 16:39:12 +0200 (CEST)
Received: from [192.168.78.136] (iskon217-215.duo.CARNet.hr [161.53.215.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by master.grad.hr (Postfix) with ESMTPSA id 20B144940E0
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 16:39:11 +0200 (CEST)
Message-ID: <4A3BA30F.70406@grad.hr>
Date: Fri, 19 Jun 2009 16:39:11 +0200
From: =?UTF-8?B?QW50ZSBLYXJhbWF0acSH?= <ivoks@grad.hr>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] Compatibility with 2.6.30 and current git
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi

I've mentioned this during Ubuntu 8.10 time frame, but nothing much has
changed since then.

Looking at linux/drbd.h, there's this part:

#ifndef CN_IDX_DRBD
# define CN_IDX_DRBD                    0x4
/* Ubuntu "intrepid ibex" release defined CN_IDX_DRBD as 0x6 */
#endif

Ubuntu defined CN_IDX_DRBD as 0x6 cause 0x4 was taken by vesa
framebuffer device. Linux kernels 2.6.30 and latest git has both 0x4 and
0x6 taken by other modules (include/linux/connector.h):

#define CN_IDX_V86D			0x4

#define CN_DST_IDX			0x6

These IDs should be unique (hence the name 'Process Events connector
unique ids'). If you want 2.6.30 compatibility (at least), change it to
0x7. That one is free. But keep an eye on it for 2.6.31. So, something
like this:

#ifndef CN_IDX_DRBD
# define CN_IDX_DRBD                    0x7
#endif

In current state, if vesa frame buffer module is loaded, drbd won't
work. Module will load, but userspace tools won't be able to connect to
it - they'll be connecting to frame buffer :)

Take care...
