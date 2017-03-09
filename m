Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DA1B0105633D
	for <drbd-dev@lists.linbit.com>; Thu,  9 Mar 2017 11:33:36 +0100 (CET)
Received: by mail-wm0-f47.google.com with SMTP id n11so135932505wma.1
	for <drbd-dev@lists.linbit.com>; Thu, 09 Mar 2017 02:33:36 -0800 (PST)
Received: from localhost (213-47-144-126.static.upcbusiness.at.
	[213.47.144.126]) by smtp.gmail.com with ESMTPSA id
	f48sm7645151wrf.17.2017.03.09.02.27.08
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 Mar 2017 02:27:08 -0800 (PST)
Date: Thu, 9 Mar 2017 11:27:07 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170309102707.GB18615@rck.sh>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
	<1488857279-29079-3-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488857279-29079-3-git-send-email-nwang@suse.com>
Subject: Re: [Drbd-dev] [Patch v0 2/8] Adapt pointer backing_dev_info in
 struct request_queue
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

On Tue, Mar 07, 2017 at 11:27:53AM +0800, Nick Wang wrote:
> In dc3b17cc, struct request_queue use pointer to backing_dev_info,
> so all related call should be converted.
> 
> This patch is for drbd-kernel-compat
> 
> Signed-off-by: Nick Wang <nwang@suse.com>
> CC: Philipp Reisner <philipp.reisner@linbit.com>
> CC: Lars Ellenberg <lars.ellenberg@linbit.com>
> CC: drbd-dev@lists.linbit.com 
> 
> ---
>  drbd_wrappers.h                       | 5 +++++
>  tests/have_pointer_backing_dev_info.c | 7 +++++++
>  2 files changed, 12 insertions(+)
>  create mode 100644 tests/have_pointer_backing_dev_info.c
> 
> diff --git a/drbd_wrappers.h b/drbd_wrappers.h
> index 0489e7f..778a6fd 100644
> --- a/drbd_wrappers.h
> +++ b/drbd_wrappers.h
> @@ -888,6 +888,11 @@ static inline void blk_queue_write_cache(struct request_queue *q, bool enabled,
>  #endif
>  #endif
>  
> +#ifdef COMPAT_HAVE_POINTER_BACKING_DEV_INFO
> +#define bdi_rw_congested(B) bdi_rw_congested(*(B))
> +#define bdi_congested(B, C) bdi_congested(*(B), C)
> +#endif
> +

We do compat work the other way round. The goal is to have our
out-of-tree code as close as possible to linux upstream. Otherwise we
would "get stuck" at the old paradigms.

In that specific case it actually means to change drbd_debugfs.c in a
way that it looks like linux upstream (basically removing the '&') and
provide compat #defines for older kernels.

Regards, rck
