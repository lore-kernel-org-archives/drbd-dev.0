Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 343401057623
	for <drbd-dev@lists.linbit.com>; Tue, 16 Jan 2018 10:08:12 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id f3so7009001wmc.1
	for <drbd-dev@lists.linbit.com>; Tue, 16 Jan 2018 01:08:12 -0800 (PST)
Date: Tue, 16 Jan 2018 10:08:09 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Eric Wheeler <drbd-dev@lists.ewheeler.net>
Message-ID: <20180116090809.GC4107@soda.linbit>
References: <1516060335-27029-1-git-send-email-drbd-dev@lists.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516060335-27029-1-git-send-email-drbd-dev@lists.ewheeler.net>
Cc: linux-kernel@vger.kernel.org, Eric Wheeler <drbd@linux.ewheeler.net>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Eric Wheeler <git@linux.ewheeler.net>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: standardize kthread/workqueue thread
 naming to include drbd minor number
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

On Mon, Jan 15, 2018 at 03:52:15PM -0800, Eric Wheeler wrote:
> From: Eric Wheeler <git@linux.ewheeler.net>
> 
> For DRBD resources with long names that start with the same prefix,
> it was difficult to find all process pids for that minor since names
> are truncated to the task_struct's comm field (16 bytes).
> 
> This patch names all processes associated with a DRBD device as drbdN_*
> where N is the DRBD minor in the same ways that the drbdN_submit workqueue
> is named.  Userspace tools can then lookup the name=>minor=>pid mapping
> and for all pids and use tools like chrt, ioprio, nice, add pids to
> cgroups, or for other useful purpose.


DRBD can do "multi volume" resources, which means most threads
are associated not with one, but with many minors.

"does not work just like that"

    Lars

