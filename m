Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
	[209.85.208.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8AF1642011D
	for <drbd-dev@lists.linbit.com>; Thu,  7 Apr 2022 12:48:23 +0200 (CEST)
Received: by mail-ed1-f53.google.com with SMTP id x20so5883518edi.12
	for <drbd-dev@lists.linbit.com>; Thu, 07 Apr 2022 03:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220303071009.1070360-1-rui.xu@easystack.cn>
In-Reply-To: <20220303071009.1070360-1-rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Thu, 7 Apr 2022 12:48:12 +0200
Message-ID: <CAGNP_+VZLZhCuMymZO+qwSDZmFjYgyJHLfsPLwGZaGE+E5cD_Q@mail.gmail.com>
To: Rui Xu <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: create new uuid even we dont have
	quorum
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

Hi,

When quorum is configured, we expect not to have split-brain
situations. Hence it is important that we do not generate new UUIDs
until they are definitely necessary. When we do not have quorum, no
writes should complete, so we do not need to generate a new UUID. We
may need to generate one before we regain quorum instead.

That said, there have been various bugs in the implementation. Try to
reproduce your issue with the latest drbd-9.1. If it can still be
reproduced, then describe the exact reproduction steps and we can
discuss the appropriate fix.

Best regards,
Joel
