Return-Path: <Bart.VanAssche@sandisk.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
	(mail-by2on0057.outbound.protection.outlook.com [207.46.100.57])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2CCAB1056332
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 19:02:25 +0200 (CEST)
To: Philipp Reisner <philipp.reisner@linbit.com>, Jens Axboe <axboe@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
	<1461586077-11581-5-git-send-email-philipp.reisner@linbit.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <571E37AD.1050607@sandisk.com>
Date: Mon, 25 Apr 2016 08:28:45 -0700
MIME-Version: 1.0
In-Reply-To: <1461586077-11581-5-git-send-email-philipp.reisner@linbit.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 04/30] drbd: Implement handling of thinly
 provisioned storage on resync target nodes
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

On 04/25/2016 05:10 AM, Philipp Reisner wrote:
> If during resync we read only zeroes for a range of sectors assume
> that these secotors can be discarded on the sync target node.

Hello Phil,

With which interconnect(s) has this patch been tested? I'm afraid that 
for high-speed interconnects this patch will slow down I/O instead of 
making it faster because all_zero() examines all data before it is sent.

Bart.

