Return-Path: <bvanassche@acm.org>
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 13050160876
	for <drbd-dev@lists.linbit.com>; Wed, 11 Mar 2026 17:57:07 +0100 (CET)
Message-ID: <445d61ae-c579-4558-a127-62291473ac6f@acm.org>
Date: Wed, 11 Mar 2026 09:49:49 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] drbd: fix pointer cast spacing
To: Richard Lyu <richard.lyu@suse.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <20260311083510.183631-1-richard.lyu@suse.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260311083510.183631-1-richard.lyu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
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

On 3/11/26 1:35 AM, Richard Lyu wrote:
> Checkpatch.pl reports the following coding style issue:
> ERROR: "(foo*)" should be "(foo *)"
> +		struct p_trim *t = (struct p_trim*)p;
Checkpatch is for checking patches before these are posted on a Linux
kernel mailing list and should not be used on code that has already
been merged into the Linux kernel tree.

Thanks,

Bart.
