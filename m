Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EF2DD1056320
	for <drbd-dev@lists.linbit.com>; Wed, 24 May 2017 12:45:50 +0200 (CEST)
Received: by mail-wm0-f48.google.com with SMTP id b84so60021809wmh.0
	for <drbd-dev@lists.linbit.com>; Wed, 24 May 2017 03:45:50 -0700 (PDT)
Date: Wed, 24 May 2017 12:45:48 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Nick Wang <nwang@suse.com>
Message-ID: <20170524104548.GA48382@rck.sh>
References: <20170524100235.22887-1-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170524100235.22887-1-nwang@suse.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix expression to check new
 replication state
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

On Wed, May 24, 2017 at 06:02:35PM +0800, Nick Wang wrote:
> Only tell peers when replication link is established.
> 
> Signed-off-by: Nick Wang <nwang@suse.com>
> 
> CC: Lars Ellenberg <lars.ellenberg@linbit.com>
> CC: drbd-dev@lists.linbit.com
> 
> ---
>  drbd/drbd-kernel-compat | 2 +-
>  drbd/drbd_state.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drbd/drbd-kernel-compat b/drbd/drbd-kernel-compat
> index bd3fb0d9..bca18431 160000
> --- a/drbd/drbd-kernel-compat
> +++ b/drbd/drbd-kernel-compat
> @@ -1 +1 @@
> -Subproject commit bd3fb0d970e496c9d374101888b15ecf3618fc8a
> +Subproject commit bca18431a58fc53485d969f8745d886dd9537755
> diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> index 9829d94f..816b8ffe 100644
> --- a/drbd/drbd_state.c
> +++ b/drbd/drbd_state.c
> @@ -3040,7 +3040,7 @@ static int w_after_state_change(struct drbd_work *w, int unused)
>  
>  			/* Outdated myself, or became D_UP_TO_DATE tell peers */
>  			if (disk_state[NEW] >= D_INCONSISTENT && disk_state[NEW] != disk_state[OLD] &&
> -			    repl_state[OLD] >= L_ESTABLISHED && repl_state[OLD] >= L_ESTABLISHED)
> +			    repl_state[OLD] >= L_ESTABLISHED && repl_state[NEW] >= L_ESTABLISHED)
>  				send_state = true;
>  
>  			/* Skipped resync with peer_device, tell others... */
> -- 
> 2.12.0
> 

Correct. In that case Phil was faster, I pushed the current state to
public.

http://git.linbit.com/drbd-9.0.git/commit/c654bbe36bcba33ab40a43f730d86bad97804879

Thanks, rck

-- 
Roland Kammerer
+43 1 817 82 92 - 70
roland.kammerer@linbit.com

LINBIT | Keeping the Digital World Running
DRBD – Corosync – Pacemaker

