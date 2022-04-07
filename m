Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
	[209.85.208.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 37B41421019
	for <drbd-dev@lists.linbit.com>; Thu,  7 Apr 2022 12:02:28 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id g20so5782155edw.6
	for <drbd-dev@lists.linbit.com>; Thu, 07 Apr 2022 03:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220223084442.3312409-1-rui.xu@easystack.cn>
	<AJ*A6wDEId6nn-rl7MpNZapM.3.1648177318891.Hmail.rui.xu@easystack.cn>
In-Reply-To: <AJ*A6wDEId6nn-rl7MpNZapM.3.1648177318891.Hmail.rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Thu, 7 Apr 2022 12:02:17 +0200
Message-ID: <CAGNP_+UpeqaLU6bLVBOqORB+k0E=joO9nnTW5JFpmHBZ_pNTgw@mail.gmail.com>
To: Xu Rui <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: fix a bug of do_change_disk_state when
	attach
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

The patch looks plausible but the commit message is hard to
understand. Please split the 8 line sentence into multiple sentences.
Also explain at the start which versions need to be mixed to trigger
this bug.

Regarding versions - it looks like you have a 3 node cluster where one
node is running DRBD 8. This is not recommended. What is your
use-case?

Best regards,
Joel
