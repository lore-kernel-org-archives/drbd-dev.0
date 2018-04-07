Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7D0651057315
	for <drbd-dev@lists.linbit.com>; Sat,  7 Apr 2018 23:35:10 +0200 (CEST)
Received: by mail-wm0-f44.google.com with SMTP id b127so9747229wmf.5
	for <drbd-dev@lists.linbit.com>; Sat, 07 Apr 2018 14:35:09 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	g75sm11615154wmc.47.2018.04.07.14.35.08
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 07 Apr 2018 14:35:08 -0700 (PDT)
Date: Sat, 7 Apr 2018 23:35:08 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20180407213457.GG16420@soda.linbit>
References: <alpine.LRH.2.11.1804062306340.7784@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.11.1804062306340.7784@mail.ewheeler.net>
Subject: Re: [Drbd-dev] [PATCH] drbd-utils: Add disable-write-same as a
 drbd.conf option
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

On Fri, Apr 06, 2018 at 11:07:44PM +0000, Eric Wheeler wrote:
> 
> Author: Eric Wheeler <drbd@linux.ewheeler.net>
> Date:   Fri Apr 6 16:04:26 2018 -0700
> 
>     drbd-utils: Add disable-write-same as a drbd.conf option
>     
>     This patch updates the grammar parser so that disable-write-same can be
>     used in drbd.conf

Thanks, but already done:
https://github.com/LINBIT/drbd-utils/commit/5a522dd6e4b3
