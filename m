Return-Path: <roland.kammerer@linbit.com>
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
	[209.85.167.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 71ABA160650
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2025 10:11:51 +0200 (CEST)
Received: by mail-lf1-f41.google.com with SMTP id
	2adb3069b0e04-55324062ea8so3625749e87.3
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2025 01:11:51 -0700 (PDT)
Date: Wed, 28 May 2025 10:11:49 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [PATCH v2 2/2] remove lock file after using it
Message-ID: <aDbFRcFQpEbhG9E1@arm64>
References: <20250515024817.25717-1-heming.zhao@suse.com>
	<20250515024817.25717-3-heming.zhao@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515024817.25717-3-heming.zhao@suse.com>
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 15, 2025 at 10:48:15AM +0800, Heming Zhao wrote:
> In a SELinux env, if a user runs as root to set up a DRBD device,
> it will leave a lock file in "/var/run/drbd/lock/". Then HA pacemaker
> will fail to set up DRBD because of a permission issue.

Sorry, but that needs more explanation. I wonder why it works for
everybody else including our SuSE customers but would require changes
for you? What exactly (sles versions, pacemaker versions,...) do I need
to reproduce this?

>  /* ignore errors */
> -void dt_unlock_drbd(int lock_fd)
> +void dt_unlock_drbd(int lock_fd, int minor)
>  {
> +	int ret;
> +	char *lfname;
> +
>  	if (lock_fd >= 0)
>  		unlock_fd(lock_fd);
> +
> +	lfname = get_lock_filename(minor, 0);
> +	ret = unlink(lfname);
> +	free(lfname);
> +	if (ret < 0) {
> +		perror("unlink");
> +	}
>  }

As I don't understand why you would need these changes in the first
place I did not look into the patch too closely, but: You first unlock
and then unlink? Shouldn't that be the other way round? As is you would
create a race I guess. But first things first: why do you need that at
all?

Regards, rck

P.S.: it is fine to send user land patches here, but the main focus is
on kernel level coordination, feel free to send patches via github.
