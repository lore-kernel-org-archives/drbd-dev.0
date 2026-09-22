Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB4534473
	for <drbd-dev@lists.linux.dev>; Tue, 22 Sep 2026 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080804; cv=none; b=hLiFmN30NnC5LBPh0qVvGPkLcA2dg9icF/TBztOGh5GmlaqdkgXHTT7uRYILfv/Vgvztx9UniCXaFWd7fk55INLrhQymVL1vtW9s4YXey0eQvkpqJoHk6bNMNH71S57NeBgPxqJ291TYl82BMMlvFsCd3SSJZXLoOmrt07h0VS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080804; c=relaxed/simple;
	bh=wFmJBrwWil7bpAeYIpoN4GzUL1HvXOt5ldn6IIIiFHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6Vul1G8kCk9QCc6ZAwk03kmzGNGFX2gAEshghWyARzraS7X2qQNefpFW4cFXc1GiyFmsKN1nT8hkWVJiz2rsR9/WPpwpm5Y19OyTBdfqSmJNnx0DCh2khKA6ETGfAwZLwlNxRHqtiV+qbX5hA4E9G8hsO/F9EMYUM8gy1NAGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=GV3lsffK; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="GV3lsffK"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e97e2c7d4so2044004241.1
        for <drbd-dev@lists.linux.dev>; Tue, 22 Sep 2026 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1790080799; x=1790685599; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9blDfaIlaDE7zWOzf7sAkl81n8mIgiGQIMLz8R8dVg=;
        b=GV3lsffKgYbMPBOsez8i7whbgaoi8Nj8eWM9E+ojKmpW+hU3iYxfpWZK6O7qs/GrOh
         4D14JOQlYmX//RblMcJD6GDos9U8Az2gZlCPnwXoiLHP9cYIv3D8IlyEtgzA634iaRFv
         NIpWneWMJKc8KKWR12bC9irKp3FQFzsswqGSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080799; x=1790685599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9blDfaIlaDE7zWOzf7sAkl81n8mIgiGQIMLz8R8dVg=;
        b=uHFrd+8Z6aC8T7tggqmw9//gf5p1GPSubPrzOH5w4RGtK+a8DmYI2jrWhQL0Si3HO1
         XsQ3ovjLMI7PdC8/7+FLnhBOBnmx7qgvotWdnN/2lxiNSy3YdcflChiwHLs5f6QCwQR+
         +xsYn+9EpPXwCVR6+CsBYW4Y7HAFED1JwA25ADuFJs1KPnk/eDHChVrDXR9QbdHW3ZwV
         y0mnuUUkW6XwrS2/EHpglDs4DuSPxs1CPdbFt5A9VxkXT8h//+Eui/PM3+3AYzPheisf
         y7yDdYQm0NIRRr83S0A9h/a/Xlq4AJjbeIQ3jNM7hxtQD92cwXtymGmdqBTiRmmiWd+c
         rTeQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDp39GbAErMc/lWixhBVXUFL6c32q6zOAU2nAc+s2VWQQk6eQE47onfE7E8svU7Jp1ZlX+6Gis2Q==@lists.linux.dev
X-Gm-Message-State: AFuF++m8EdR5HJP0LIwRw4QUjr5oMmeUmsa4pAF8zoaZ6MVHhhBHQ6y3
	SBub+4UfaPxpy6fQJQrym5mbpOWexcv1W2OGYOGX9p2SA+E4KMwkpYjK1KJvesw23w==
X-Gm-Gg: AYBFou2zdIu5VR1Iy6MM4mAfHCixHH4TDdaCC+g1+PsfZ1byygH6o8fm83BpWtcw3IT
	BZa5qyvzvIot5i/LKC4GKSHVJBdYAd7qe3WTuT30gERYFlLcTanIOM9p0G8N53/KtEXq4mD2/01
	XEY3vSpELY+6w/6YCtBghab7Rhuis7ac3pBHOUoxbp3/csTQFMe1wyCUhd+YN6kgKzrR8OYrU0+
	BRfysr8EownNWUa+MhPssQ03GnFTuEzsZZ1jE+pxEJFdnE5+xddWwQIV3A0E8Br0caECPFz7fKR
	r0Ozsi1rDsaKBfDd3eVD8SQWrkqLK5SSAzaWURgvuhz0TPTKrIAow+0/l23bnXpEvVtMtHZeTtD
	pswK7YURpcA6sCjOLPVwq6stnMBs2rNNSK1ApTMYzfV88ewe440rsQmEbZolcx8mPcmmld+pVqr
	a/IAxpypGW8EY5d9AfR6oHwMDyepiBJofkUGX2GwWNUlqybWLYy3ZZAzdjM2l30RKXXhMzj8kuu
	bgn
X-Received: by 2002:a05:6122:e22b:b0:5c9:a60c:2736 with SMTP id 71dfb90a1353d-5c9b598e442mr8405960e0c.14.1790080799199;
        Tue, 22 Sep 2026 05:39:59 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-91402535ce1sm14566906d6.48.2026.09.22.05.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 05:39:53 -0700 (PDT)
Message-ID: <d2052425-3fb4-4104-b1ed-f2d53e5a710d@ieee.org>
Date: Tue, 22 Sep 2026 07:39:47 -0500
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] umh, treewide: Explicitly include linux/umh.h
 where needed
To: Petr Pavlu <petr.pavlu@suse.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
 <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 9:46 AM, Petr Pavlu wrote:
> The usermode helper declarations were previously provided by linux/kmod.h
> but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
> moved them to linux/umh.h in 2017.
> 
> Add explicit includes of linux/umh.h to files that use usermode helpers and
> remove linux/kmod.h where it is no longer needed.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>   arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
>   drivers/block/drbd/drbd_nl.c         | 1 +
>   drivers/greybus/svc_watchdog.c       | 1 +

For Greybus:

Acked-by: Alex Elder <elder@riscstar.com>

>   drivers/macintosh/windfarm_core.c    | 1 +
>   drivers/pnp/pnpbios/core.c           | 2 +-
>   drivers/video/fbdev/uvesafb.c        | 1 +
>   fs/coredump.c                        | 2 +-
>   fs/nfs/cache_lib.c                   | 2 +-
>   fs/nfsd/nfs4layouts.c                | 2 +-
>   fs/nfsd/nfs4recover.c                | 1 +
>   fs/ocfs2/stackglue.c                 | 1 +
>   kernel/cgroup/cgroup-v1.c            | 2 +-
>   kernel/module/kmod.c                 | 1 +
>   kernel/power/process.c               | 2 +-
>   kernel/reboot.c                      | 2 +-
>   kernel/umh.c                         | 2 +-
>   lib/kobject_uevent.c                 | 2 +-
>   net/bridge/br_stp_if.c               | 2 +-
>   security/keys/request_key.c          | 2 +-
>   security/tomoyo/common.h             | 2 +-
>   20 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> index 053555206d81..af4e76babe7a 100644
> --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
> +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> @@ -11,7 +11,7 @@
>   
>   #include <linux/miscdevice.h>
>   #include <linux/slab.h>
> -#include <linux/kmod.h>
> +#include <linux/umh.h>
>   #include <linux/poll.h>
>   
>   #include "internal.h"
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index b77f901fc3ef..6f5d059394b3 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -14,6 +14,7 @@
>   #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>   
>   #include <linux/module.h>
> +#include <linux/umh.h>
>   #include <linux/drbd.h>
>   #include <linux/in.h>
>   #include <linux/fs.h>
> diff --git a/drivers/greybus/svc_watchdog.c b/drivers/greybus/svc_watchdog.c
> index 16e6de5e9eff..b318eb34bcca 100644
> --- a/drivers/greybus/svc_watchdog.c
> +++ b/drivers/greybus/svc_watchdog.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/delay.h>
>   #include <linux/suspend.h>
> +#include <linux/umh.h>
>   #include <linux/workqueue.h>
>   #include <linux/greybus.h>
>   
. . .
