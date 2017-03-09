Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BFCCB105631C
	for <drbd-dev@lists.linbit.com>; Thu,  9 Mar 2017 10:21:50 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id t189so50826350wmt.1
	for <drbd-dev@lists.linbit.com>; Thu, 09 Mar 2017 01:21:50 -0800 (PST)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id 61sm7451855wrs.29.2017.03.09.01.21.49
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 Mar 2017 01:21:49 -0800 (PST)
Date: Thu, 9 Mar 2017 10:21:42 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170309092142.GU10667@soda.linbit>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488857279-29079-1-git-send-email-nwang@suse.com>
Subject: Re: [Drbd-dev] [Patch v0 0/8] Patches for compat drbd9 to kernel
	v4.10
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

On Tue, Mar 07, 2017 at 11:27:51AM +0800, Nick Wang wrote:
> Patches for drbd9 compatible to kernel4.10, including drbd,
> drbd-kernel-compat and drbd-headers repos. Ordered as 
> functionality, so may mix the three repos in one patch set.
> 
> block layer API and genetlink API have many changes in kernel v4.10.
> 93c5bdf7 and 70fd7614, bio_set_op_attrs change to inline 
>     then obsolete by use flag directly.
> dc3b17cc, use pointer to backing_dev_info in struct request_queue.
> 10383aea, use refcount_t for struct kref.
> a07ea4d9 and 489111e5, statically initialize genetlink family.
> 
> Signed-off-by: Nick Wang <nwang@suse.com>
> CC: Philipp Reisner <philipp.reisner@linbit.com>
> CC: Lars Ellenberg <lars.ellenberg@linbit.com>
> CC: drbd-dev@lists.linbit.com 

Thanks,
We'll find time review them "soon", I hope.

    Lars

