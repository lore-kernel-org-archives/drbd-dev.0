Return-Path: <senozhatsky@chromium.org>
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
	[209.85.214.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 09AE2160963
	for <drbd-dev@lists.linbit.com>; Sun, 29 Dec 2024 05:36:38 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
	d9443c01a7336-21644aca3a0so2476615ad.3
	for <drbd-dev@lists.linbit.com>; Sat, 28 Dec 2024 20:36:38 -0800 (PST)
Date: Sun, 29 Dec 2024 13:36:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Shi Xinhe <shixinhe6@gmail.com>
Subject: Re: [PATCH] Documentation zram: fix description about huge page
	writeback example
Message-ID: <qfagx4fjlluq4fox7fw5ltx63wxpifnr7lp3nkt63jm4wbtzp2@mna6znzgfqv2>
References: <20241229042758.163842-1-shixinhe6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241229042758.163842-1-shixinhe6@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, philipp.reisner@linbit.com,
	linux-kernel@vger.kernel.org, minchan@kernel.org,
	lars.ellenberg@linbit.com, senozhatsky@chromium.org,
	drbd-dev@lists.linbit.com
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

On (24/12/29 04:27), Shi Xinhe wrote:
> 
> Corrected the description to accurately reflect that huge page writeback example.

But what is the correction?  In zram huge page is incompressible page.
