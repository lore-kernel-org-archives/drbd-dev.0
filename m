Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DC489105633D
	for <drbd-dev@lists.linbit.com>; Thu, 20 Jul 2017 14:10:33 +0200 (CEST)
Received: by mail-wm0-f47.google.com with SMTP id k69so22630080wmc.1
	for <drbd-dev@lists.linbit.com>; Thu, 20 Jul 2017 05:10:33 -0700 (PDT)
Date: Thu, 20 Jul 2017 14:10:31 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170720121030.GT1453@rck.sh>
References: <6863677bb21b5adb672d850983d5f8d1@cs.utah.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6863677bb21b5adb672d850983d5f8d1@cs.utah.edu>
Subject: Re: [Drbd-dev] Potentially invalid memory accesses in file
 drivers/block/drbd/drbd_worker.c
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

On Wed, Jul 19, 2017 at 10:50:47PM -0600, Shaobo wrote:
> Hi there,
> 
> My name is Shaobo He and I am a graduate student at University of Utah. I am
> using a static analysis tool to search for null pointer dereferences and
> came across a couple of potentially invalid memory accesses in the file
> drivers/block/drbd/drbd_worker.c: in function `drbd_start_resync`, pointer
> variable `connection` in line 1727 can be NULL while is dereferenced at line
> 1767 (```if (current == connection->worker.task) {```).
> 
> Please let me know if it makes sense. I am looking forward to your reply.

Hi Shaobo,

While highly theoretical and unlikely, better be safe than sorry. Fixed
and we will send that to mainline Linux soon.

Regards, rck
