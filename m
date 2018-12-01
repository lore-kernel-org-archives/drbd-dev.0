Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D0929101AC56
	for <drbd-dev@lists.linbit.com>; Sat,  1 Dec 2018 19:36:07 +0100 (CET)
Received: by mail-pg1-f194.google.com with SMTP id v28so3907105pgk.10
	for <drbd-dev@lists.linbit.com>; Sat, 01 Dec 2018 10:36:07 -0800 (PST)
To: Yangtao Li <tiny.windzz@gmail.com>, ed.cashin@acm.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org, josh.h.morris@us.ibm.com,
	pjk1939@linux.vnet.ibm.com
References: <20181201142414.7766-1-tiny.windzz@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5682c419-9e44-10ed-6a2e-286e6f5c5def@kernel.dk>
Date: Sat, 1 Dec 2018 11:10:58 -0700
MIME-Version: 1.0
In-Reply-To: <20181201142414.7766-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: nbd@other.debian.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2] block: Change to use
	DEFINE_SHOW_ATTRIBUTE macro
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

On 12/1/18 7:24 AM, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> changes in v2:
> -Modify some function names to avoid compilation errors

The fact that your previous patch didn't even compile doesn't fill me
with a lot of confidence in the amount of diligence and testing
you apply to your patches.

Why would you send something out that you didn't even compile?

-- 
Jens Axboe

