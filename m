Return-Path: <Markus.Elfring@web.de>
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 66352420312
	for <drbd-dev@lists.linbit.com>; Mon, 27 Mar 2023 19:39:17 +0200 (CEST)
Message-ID: <7a6c195f-42df-eef2-e2b7-9f7510dbdf06@web.de>
Date: Mon, 27 Mar 2023 19:26:22 +0200
MIME-Version: 1.0
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
	kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
	<8d193937-532f-959f-9b84-d911984508aa@web.de>
	<941709b5-d940-42c9-5f31-7ed56e3e6151@web.de>
	<a989f01e-79a9-44a4-3603-ba4eeeb86dea@linbit.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a989f01e-79a9-44a4-3603-ba4eeeb86dea@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [Drbd-dev] drbd: Fix exception handling in
	nla_put_drbd_cfg_context()
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

> Can you identify the issue with the current code and can you explain how
> your patch makes it better?

I propose to avoid a duplicate pointer check also in this function implementation.

Regards,
Markus

