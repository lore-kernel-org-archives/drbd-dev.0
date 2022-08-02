Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
	[209.85.218.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B707D4203DF
	for <drbd-dev@lists.linbit.com>; Tue,  2 Aug 2022 11:23:35 +0200 (CEST)
Received: by mail-ej1-f51.google.com with SMTP id a7so11899751ejp.2
	for <drbd-dev@lists.linbit.com>; Tue, 02 Aug 2022 02:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <AL*AywBKImqCcBd6mgBHvKqI.1.1657802179974.Hmail.rui.xu@easystack.cn>
In-Reply-To: <AL*AywBKImqCcBd6mgBHvKqI.1.1657802179974.Hmail.rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Tue, 2 Aug 2022 11:23:24 +0200
Message-ID: <CAGNP_+WQe2bnEPOTNLD-bLWM-K78YOppb+wArQxuwD3oMU0OJQ@mail.gmail.com>
To: "rui.xu" <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd: a question of uuid compare
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

Hi Xu,

Commit 300bfb7ba follows after commit 33600a4632f2. They are both
intended to improve the same scenario. That scenario is described in
the commit message for 33600a4632f2. In short, 300bfb7ba prevents an
unnecessary resync in a case where the connection was lost and
regained, but no data was written in between.

You have found a scenario that is broken by this change. We need to
find a solution that works in both scenarios. Patches welcome.

Best regards,
Joel
